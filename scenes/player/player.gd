extends CharacterBody2D

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
	
	# laser shooting input
	if Input.is_action_just_pressed("primary_action") and can_laser:
		print("pew pew")
		can_laser = false
		$laser_timer.start()
	
	if Input.is_action_just_released("secondary_action") and can_granade:
		print("shoot granade")
		can_granade = false
		$granade_timer.start()


func _on_laser_timer_timeout():
	can_laser = true


func _on_granade_timer_timeout():
	can_granade = true
