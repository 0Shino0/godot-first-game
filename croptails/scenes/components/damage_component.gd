class_name DamageComponennt
extends Node2D

@export var max_damage = 1
@export var current_damage = 0

signal max_damaged_reached

#造成伤害
func apply_damage(damage: int) -> void:
	current_damage = clamp(current_damage + damage, 0, max_damage)
	
	if current_damage == max_damage:
		max_damaged_reached.emit()
