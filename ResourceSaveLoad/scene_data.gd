extends Resource

class_name SceneData

#如果需要player_position以文件形式保存在电脑上需要再前添加 @export
@export var player_position : Vector2
@export var is_facing_left : bool

#PackedScene
@export var box_array : Array[PackedScene]
