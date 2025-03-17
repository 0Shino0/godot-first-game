extends CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	velocity = Vector2(50 , 0)

@export var move_speed : float = 50
@export var animator : AnimatedSprite2D

# 是否输掉游戏
@export var is_game_over : bool = false

# 子弹场景
@export var bullet_scene : PackedScene

func _process(delta: float) -> void:
	if velocity == Vector2.ZERO or is_game_over:
		$RunningSound.stop()
	elif not $RunningSound.playing:
		$RunningSound.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta: float) -> void:
func _physics_process(delta: float) -> void:
	if not is_game_over:
		# 实时检测玩家输入 然后将它转化为角色的方向
		velocity = Input.get_vector("left", "right" , "up", "down") * move_speed
		
		# 如果速度为0 播放待机动画
		if velocity == Vector2.ZERO:
			animator.play("idle")
		# 如果速度不为0 播放跑步动画
		else:
			animator.play("run")
		move_and_slide()

func game_over():
	if not is_game_over:
		is_game_over = true
		animator.play("game_over")
		# 调用 GameManager 中的show_game_over 方法，显示GAME OVER文本
		get_tree().current_scene.show_game_over()
		
		$GameOverSound.play()
		
		$RestartTimer.start()
		


func _on_fire() -> void:
	if velocity != Vector2. ZERO || is_game_over:
		return
	
	$FireSound.play()
	
	var bullet_node = bullet_scene.instantiate()
	# 生成的子弹在玩家当位置
	bullet_node.position = position + Vector2(12, 6)
	# 把子弹节点添加到当前节点的子节点
	get_tree().current_scene.add_child(bullet_node)


func _reload_scene() -> void:
	get_tree().reload_current_scene()
