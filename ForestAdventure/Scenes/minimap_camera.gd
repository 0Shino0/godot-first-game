extends Camera2D

@export var background1 : Sprite2D
@export var background2 : Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_limits()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_limits():

	limit_left = -230
	limit_right = 230
	limit_bottom = 126
	limit_top = -126


	# 启用边界限制
	set_limit_smoothing_enabled(true)
