extends Node2D

var test_array: Array[String] = ["Test", "Hello", "Pierozki"]
var speed: int = 300

var rot: float = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Logo.rotation_degrees = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
