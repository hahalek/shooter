extends Sprite2D

var pos: Vector2 = Vector2.ZERO
const rot: int = 60
var test_scale: int = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	#pos = Vector2(300, 200)
	#position = pos
	#test_scale = 2
	#scale = Vector2(test_scale, test_scale)
	
	#var test_rotation = 45
	#rotation_degrees = test_rotation
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation_degrees += rot * delta

