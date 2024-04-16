extends LevelParent

@export var outside_level_scene: PackedScene


# Called when the node enters the scene tree for the first time.

func _on_exit_gate_area_body_entered(_body):
	var tween = create_tween()
	tween.tween_property($Player, "speed", 0, 0.5)
	#get_tree().change_scene_to_file("res://scenes/levels/outside.tscn")
	TransitionLayer.change_scene("res://scenes/levels/outside.tscn")
