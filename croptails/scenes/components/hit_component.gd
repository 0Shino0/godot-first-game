# 攻击组件-挂载在角色下用于处理不同工具的攻击事件
class_name  HitComponent
extends Area2D

@export var current_tool : DataTypes.Tools = DataTypes.Tools.None
@export var hit_damage : int = 1
