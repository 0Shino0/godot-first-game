extends CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	velocity = Vector2(50 , 0)

@export var move_speed : float = 50
@export var animator : AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta: float) -> void:
func _physics_process(delta: float) -> void:
	# 实时检测玩家输入 然后将它转化为角色的方向
	velocity = Input.get_vector("left", "right" , "up", "down") * move_speed
	
	# 如果速度为0 播放待机动画
	if velocity == Vector2.ZERO:
		animator.play("idle")
	# 如果速度不为0 播放跑步动画
	else:
		print(animator)
		animator.play("run")
	
	print(velocity)
	move_and_slide()
