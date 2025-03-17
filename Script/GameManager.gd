extends Node2D

@export var slime_scene : PackedScene
@export var spawn_timer : Timer
@export var score : int = 0
@export var score_lable : Label
@export var game_over_label: Label

# 色相值（范围：0 到 1）
var hue: float = 0.0
var hue_speed: float = 0.25

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# 不涉及物理计算可以直接用 _process
	# 每秒减少 0.2
	spawn_timer.wait_time -= 0.2 * delta
	# 设置最高为 1 最低为 3
	spawn_timer.wait_time = clamp(spawn_timer.wait_time, 1, 3)
	
	# 更新UI
	score_lable.text = "Score: " + str(score)
	dynamicColor(score_lable, delta, "font_color")
	if game_over_label.visible == true:
		dynamicColor(game_over_label, delta, "font_outline_color")

func _spawn_slime() -> void:
	var slime_node = slime_scene.instantiate()
	slime_node.position = Vector2(250, randf_range(50, 115))
	get_tree().current_scene.add_child(slime_node)

func show_game_over(): 
	game_over_label.visible = true

func dynamicColor(dynamicLabel: Label, delta: float, colorName: String) -> void:
	# 更新色相值
	hue += hue_speed * delta
	if hue >= 1.0:
		hue -= 1.0  # 循环渐变

	var new_color: Color = Color.from_hsv(hue, 1.0, 1.0)
	#add_theme_color_override("font_outline_color", Color(1, 0, 0))
	dynamicLabel.add_theme_color_override(colorName, new_color)
