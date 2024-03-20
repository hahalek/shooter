extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_gate_player_enered_gate(body):
	print("Player has entered gate: ", body)


func _on_player_laser_shot():
	print("Laser shot from the level")


func _on_player_granade_thrown():
	print("Granade thrown from the level")
