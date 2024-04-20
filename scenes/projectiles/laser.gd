extends Area2D

@export var speed: int = 2300
var direction: Vector2 = Vector2.UP
@export var damage_amount: int = 7


# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(3.0).timeout
	queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += direction * speed * delta


func _on_body_entered(body):
	if "hit" in body:
		body.hit(damage_amount)
	queue_free()
