extends StaticBody2D
class_name ItemContainerScene

@onready var current_diraction: Vector2 = Vector2.DOWN.rotated(rotation)

signal item_opened(pos, direction)
var opened: bool = false
