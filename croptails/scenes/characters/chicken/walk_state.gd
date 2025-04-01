extends NodeState

@export var character: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D
@export var navigation_agent_2d: NavigationAgent2D
@export var min_speed: float = 5.0
@export var max_speed: float = 10.0

var speed: float

func _ready() -> void:
	#计算出避障速度时发出通知。只要 avoidance_enabled 为 true 并且代理存在导航地图，就会在每次更新时发出。
	navigation_agent_2d.velocity_computed.connect(on_safe_velocity_computed)
	
	#空闲时调用，空闲时间主要出现在处理帧和物理帧的末尾。
	call_deferred("character_setup")

func character_setup() -> void:
	#当我们使用 NavigationRegion2D 需要等待第一个物理帧
	await get_tree().physics_frame
	
	set_movement_target()
	
func set_movement_target() -> void:
	#返回与 navigation_layers 匹配的所有地图区块多边形中随机挑选的位置。
	#传入 navigation_agent_2d.get_navigation_map() 和 
	var target_position: Vector2 = NavigationServer2D.map_get_random_point(navigation_agent_2d.get_navigation_map(), navigation_agent_2d.navigation_layers, false)
	navigation_agent_2d.target_position = target_position
	
	speed = randf_range(min_speed, max_speed)

func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	if navigation_agent_2d.is_navigation_finished():
		set_movement_target()
		return
	
	#获取一个可以动的位置
	var target_position:Vector2 = navigation_agent_2d.get_next_path_position()
	#计算方向
	var target_direction:Vector2 = character.global_position.direction_to(target_position)
	#翻转
	animated_sprite_2d.flip_h = target_direction.x < 0
	
	var velocity:Vector2 = target_direction * speed
	#如果为 true，该代理会在 NavigationServer2D 上注册 RVO 避障回调。当使用 velocity 并且处理完成时，会通过与 velocity_computed 的信号连接接收到安全速度 safe_velocity Vector2。注册的代理过多会为避障处理带来显著的性能开销，应该仅在需要它的代理上启用。
	if navigation_agent_2d.avoidance_enabled:
		navigation_agent_2d.velocity = velocity
	else:
		character.velocity = velocity
		character.move_and_slide()

func on_safe_velocity_computed(safe_velocity: Vector2) -> void:
	character.velocity = safe_velocity
	character.move_and_slide()

func _on_next_transitions() -> void:
	if navigation_agent_2d.is_navigation_finished():
		#速度向量置0
		character.velocity = Vector2.ZERO
		transition.emit("idle")


func _on_enter() -> void:
	animated_sprite_2d.play("walk")


func _on_exit() -> void:
	animated_sprite_2d.stop()
