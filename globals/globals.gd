extends Node

signal health_changed
signal laser_changed
signal granade_changed

var laser_amount: int = 900:
	get:
		return laser_amount
	set(value):
		laser_amount = value
		laser_changed.emit()
		
var granade_amount: int = 3:
	set(value):
		granade_amount = value
		granade_changed.emit()
		
var health_amount: int = 100:
	set(value):
		health_amount = value
		if health_amount > 100:
			health_amount = 100
		health_changed.emit()

var player_pos: Vector2
