extends SubViewport

@export var camera_node : Node2D
@export var player_node : Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#设置subviewport 使用主场景的2D世界
	world_2d = get_tree().root.world_2d
	get_tree().root.set_canvas_cull_mask_bit(1, false)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	camera_node.position = player_node.position
	
	pass
