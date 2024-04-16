extends Area2D

var rotation_speed: int = 2
var available_types = ['laser', 'laser', 'laser', 'granade', 'health']
var type = available_types[randi()%len(available_types)]

func _ready():
	if type == 'laser':
		$Sprite2D.modulate = Color("6eebf5")
	if type == 'granade':
		$Sprite2D.modulate = Color("fb7e61")
	if type == 'health':
		$Sprite2D.modulate = Color("5cc15a")

func _process(delta):
	rotation += rotation_speed * delta


func _on_body_entered(body):
	body.add_item(type)
	if type == 'health':
		Globals.health_amount += 40
	queue_free()
