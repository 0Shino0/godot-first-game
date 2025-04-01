class_name NonPlayableCharacter
extends CharacterBody2D

#步行周期
@export var min_walk_cycle: int = 2
#最大步行周期
@export var max_walk_cycle: int = 6

var walk_cycles: int
var current_walk_cycles: int
