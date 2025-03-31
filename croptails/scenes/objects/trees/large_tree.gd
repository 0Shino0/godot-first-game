extends Sprite2D

@onready var hurt_component: HurtComponent = $HurtComponent
@onready var damage_component: DamageComponennt = $DamageComponent


#获取Log
var log_scene = preload("res://scenes/objects/trees/log.tscn")

func _ready() -> void:
	#connnet 将此信号连接到指定的 callable
	hurt_component.hurt.connect(on_hurt) 
	damage_component.max_damaged_reached.connect(on_max_damaged_reached)
	
func on_hurt(hit_damage: int) -> void:
	damage_component.apply_damage(hit_damage)
	#受击时设置shader摇动强度
	material.set_shader_parameter("shake_intensity", 1.0)

	#等待1秒，将摇动强度重置为0
	await get_tree().create_timer(1.0).timeout
	material.set_shader_parameter("shake_intensity", 0.0)

	
	
func on_max_damaged_reached() -> void:
	#如果接架子LogScene，然后释放队列，会得到一个错误
	#所以这里采用迟调用的形式,
	call_deferred("add_log_scene")
	print("max damaged reached")
	queue_free()
	
func add_log_scene() -> void:
	var log_instance = log_scene.instantiate() as Node2D
	log_instance.global_position = global_position
	#不能直接挂在在TreeScene下，因为树即将销毁；因此我们将Log挂载在Tree的父节点下
	get_parent().add_child(log_instance) 
