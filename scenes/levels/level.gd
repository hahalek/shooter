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


func _on_player_laser_shot(pos, laser_direction):
	var laser = laser_scene.instantiate() as Area2D
	# 1. update the laser position
	laser.position = pos
	laser.direction = laser_direction
	laser.rotation = laser_direction.angle() + PI / 2
	# 2. we have to move the laser
	# 3. i want to add the laser scene to a Node2D
	$Projectiles.add_child(laser)
	print("Laser shot from the level")


func _on_player_granade_thrown(pos, granade_direction):
	var granade = granade_scene.instantiate() as RigidBody2D
	granade.position = pos
	granade.linear_velocity = granade_direction * granade.speed
	$Projectiles.add_child(granade)
	print("Granade thrown from the level")


func _on_house_player_entered():
	var tween = get_tree().create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(0.6, 0.6), 1)


func _on_house_player_exited():
	var tween = get_tree().create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(0.55, 0.55), 1)
