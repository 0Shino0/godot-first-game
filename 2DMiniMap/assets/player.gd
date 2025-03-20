extends CharacterBody2D

func _process(delta: float) -> void:
	var horizontal = Input.get_axis("ui_left", "ui_right")
	var vertical = Input.get_axis("ui_up", "ui_down")
	var input = Vector2(horizontal, vertical)
	velocity = input * 100.0
	move_and_slide()
	
	if input.length_squared() > 0:
		$AnimatedSprite2D.play("walk")
		if horizontal != 0:
			$AnimatedSprite2D.flip_h = horizontal < 0
	else:
		$AnimatedSprite2D.play("idle")
