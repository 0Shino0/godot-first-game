extends CanvasLayer

@export var player : Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _save() -> void:
	var data = SceneData.new()
	data.player_position = player.position
	#获取方向 水平翻转值
	data.is_facing_left = player.get_child(0).flip_h
	
	#存所有箱子 - 获取Box分组
	var boxes = get_tree().get_nodes_in_group("Box")
	for box in boxes:
		var box_scene =  PackedScene.new()
		box_scene.pack(box)
		data.box_array.append(box_scene)
	
	#写入硬盘 写入 user路径
	ResourceSaver.save(data, "user://scene_data.tres")
	print("save!")

func _load() -> void:
	var data = ResourceLoader.load("user://scene_data.tres") as SceneData
	
	player.global_position = data.player_position
	player.get_child(0).flip_h = data.is_facing_left
	
	#读取箱子 - 先删除
	for box in get_tree().get_nodes_in_group("Box"):
		box.queue_free()

	#再从文件读取添加		
	for box in data.box_array:
		#先转化节点
		var box_node = box.instantiate()
		get_tree().current_scene.add_child(box_node)
		#生成箱子的瞬间 停止他们的物理计算
		box_node.freeze = true
	
	await get_tree().create_timer(0.1).timeout
	for box in get_tree().get_nodes_in_group("Box"):
		box.freeze = false
