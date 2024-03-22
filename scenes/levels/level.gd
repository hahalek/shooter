extends Node2D

var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var granade_scene: PackedScene = preload("res://scenes/projectiles/granade.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_gate_player_enered_gate(body):
	print("Player has entered gate: ", body)


func _on_player_laser_shot(pos):
	var laser = laser_scene.instantiate()
	# 1. update the laser position
	laser.position = pos
	# 2. we have to move the laser
	# 3. i want to add the laser scene to a Node2D
	$Projectiles.add_child(laser)
	print("Laser shot from the level")


func _on_player_granade_thrown(pos, direction):
	var granade = granade_scene.instantiate() as RigidBody2D
	granade.position = pos
	granade.linear_velocity = direction * 100
	$Projectiles.add_child(granade)
	print("Granade thrown from the level")
