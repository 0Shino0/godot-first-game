extends Area2D

@export var slime_speed = -100

var is_dead : bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if not is_dead:
		position += Vector2(slime_speed, 0) * delta
	
	# 判断史莱姆是否超出屏幕外
	if position.x < -267:
		queue_free()

func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	# 如果忘记物体进入了史莱姆的区域、则让忘记输掉游戏
	if body is CharacterBody2D and not is_dead:
		body.game_over()


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullet"):
		$AnimatedSprite2D.play("death")
		is_dead = true		
		area.queue_free()
		# 等待 0.6 s后销毁史莱姆也行
		
		$DeathSound.play()
		
		#获取主场景的score 并 +1
		get_tree().current_scene.score += 1
		


func _on_animated_sprite_2d_animation_finished() -> void:
	# death 播放完毕时 销毁
	queue_free()
