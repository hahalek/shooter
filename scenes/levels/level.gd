extends Node2D
class_name LevelParent

var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var granade_scene: PackedScene = preload("res://scenes/projectiles/granade.tscn")
var item_scene: PackedScene = preload("res://scenes/items/item.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	for container in get_tree().get_nodes_in_group("Container"):
		container.connect("item_opened", _on_container_opened)

# Called every frame. 'delta' is the elapsed time since the previous frame.

func _on_container_opened(pos, direction):
	var item = item_scene.instantiate()
	item.position = pos
	item.direction = direction
	$Items.call_deferred('add_child', item)

func _on_player_laser_shot(pos, laser_direction):
	var laser = laser_scene.instantiate() as Area2D
	# 1. update the laser position
	laser.position = pos
	laser.direction = laser_direction
	laser.rotation = laser_direction.angle() + PI / 2
	# 2. we have to move the laser
	# 3. i want to add the laser scene to a Node2D
	$Projectiles.add_child(laser)
	$UI.update_laser_text()

func _on_player_granade_thrown(pos, granade_direction):
	var granade = granade_scene.instantiate() as RigidBody2D
	granade.position = pos
	granade.linear_velocity = granade_direction * granade.speed
	$Projectiles.add_child(granade)
	$UI.update_granade_text()

