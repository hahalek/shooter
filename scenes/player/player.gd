extends CharacterBody2D

signal laser_shot(pos, direction)
signal granade_thrown(pos, direction)

@export var max_speed: int = 700
var speed: int = max_speed
var can_laser: bool = true
var can_granade: bool = true
var can_take_damage: bool = true


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# input
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	
	# rotate player
	look_at(get_global_mouse_position())
	
	# laser shooting input
	if Input.is_action_just_pressed("primary_action") and can_laser and Globals.laser_amount > 0:
		Globals.laser_amount -= 1
		# randomly select Marker2D for the laser start
		var gun_markers = $LaserStartPositions.get_children()
		var selected_laser = gun_markers[randi() % gun_markers.size()]
		# emit the position of Marker2D we selected
		var pos = selected_laser.global_position
		var laser_direction = (get_global_mouse_position() - pos).normalized()
		$GPUParticles2D.emitting = true
		velocity = -laser_direction * speed * 1.2
		laser_shot.emit(pos, laser_direction)
		can_laser = false
		$Timers/LaserCooldownTimer.start()
	
	if Input.is_action_just_released("secondary_action") and can_granade and Globals.granade_amount > 0:
		Globals.granade_amount -= 1
		var pos = $LaserStartPositions/Marker2D.global_position
		var granade_direction = (get_global_mouse_position() - pos).normalized()
		granade_thrown.emit(pos, granade_direction)
		can_granade = false
		$Timers/GranadeReloadTimer.start()
	
	move_and_slide()
	Globals.player_pos = global_position


func _on_laser_cooldown_timer_timeout():
	can_laser = true


func _on_granade_reload_timer_timeout():
	can_granade = true


func add_item(type: String) -> void:
	if type == 'laser':
		Globals.laser_amount += 5
	if type == 'granade':
		Globals.granade_amount += 1
	if type == 'health':
		Globals.health_amount += 40


func hit(damage_amount: int):
	if can_take_damage:
		$PlayerSprite.material.set_shader_parameter("progress", 1)
		Globals.health_amount -= damage_amount
		$AudioStreamPlayer2D.play()
		can_take_damage = false
		$Timers/TakeDamageCooldown.start()


func _on_take_damage_cooldown_timeout():
	can_take_damage = true
	$PlayerSprite.material.set_shader_parameter("progress", 0)
