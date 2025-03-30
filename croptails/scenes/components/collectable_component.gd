class_name CollectableComponent
extends Area2D

@export var collectable_name: String

func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body is Player:
		print("Collected")
		get_parent().queue_free()
