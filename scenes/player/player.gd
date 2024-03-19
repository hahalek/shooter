extends Node2D

var speed: int = 500


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# input
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	position += direction * delta * speed
	
	# laser shooting input
	if Input.is_action_just_pressed("primary_action"):
		print("pew pew")
	
	if Input.is_action_just_released("secondary_action"):
		print("shoot granade")
