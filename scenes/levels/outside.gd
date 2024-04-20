extends LevelParent


# Called when the node enters the scene tree for the first time.

func _on_gate_player_enered_gate(body):
	if body.is_in_group("MainCharacter"):
		var tween = create_tween()
		tween.tween_property($Player, "speed", 0, 0.5)
		TransitionLayer.change_scene("res://scenes/levels/inside.tscn")


func _on_house_player_entered():
	var tween = get_tree().create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(0.45, 0.45), 1)


func _on_house_player_exited():
	var tween = get_tree().create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(0.4, 0.4), 1)
