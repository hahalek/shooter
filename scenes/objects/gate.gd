extends StaticBody2D

signal player_enered_gate(body)


func _on_area_2d_body_entered(body):
	player_enered_gate.emit(body)
