extends Area2D

var rotation_speed: int = 2
var available_types = ['laser', 'laser', 'laser', 'granade', 'health']
var type = available_types[randi()%len(available_types)]

var direction: Vector2
var distance: int = randi_range(150, 250)

func _ready():
	if type == 'laser':
		$Sprite2D.modulate = Color("6eebf5")
	if type == 'granade':
		$Sprite2D.modulate = Color("fb7e61")
	if type == 'health':
		$Sprite2D.modulate = Color("5cc15a")
		
	#tween
	var target_position = position + direction * distance
	var movement_tween = create_tween()
	movement_tween.tween_property(self, "position", target_position, 0.5)

func _process(delta):
	rotation += rotation_speed * delta

func _on_body_entered(body):
	body.add_item(type)
	queue_free()
