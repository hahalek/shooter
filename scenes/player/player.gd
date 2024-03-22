extends CharacterBody2D

signal laser_shot(pos, direction)
signal granade_thrown(pos, direction)

var speed: int = 500
var can_laser: bool = true
var can_granade: bool = true


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# input
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	move_and_slide()
	
	# rotate player
	look_at(get_global_mouse_position())
	
	# laser shooting input
	if Input.is_action_just_pressed("primary_action") and can_laser:
		# randomly select Marker2D for the laser start
		var gun_markers = $LaserStartPositions.get_children()
		var selected_laser = gun_markers[randi() % gun_markers.size()]
		# emit the position of Marker2D we selected
		var pos = selected_laser.global_position
		var laser_direction = (get_global_mouse_position() - pos).normalized()
		laser_shot.emit(pos, laser_direction)
		can_laser = false
		$LaserCooldownTimer.start()
	
	if Input.is_action_just_released("secondary_action") and can_granade:
		var pos = $LaserStartPositions/Marker2D.global_position
		var granade_direction = (get_global_mouse_position() - pos).normalized()
		granade_thrown.emit(pos, granade_direction)
		can_granade = false
		$GranadeReloadTimer.start()


func _on_laser_cooldown_timer_timeout():
	can_laser = true


func _on_granade_reload_timer_timeout():
	can_granade = true
