extends RigidBody2D

var speed = 550
signal granade_exploded(pos)

var explosion_active: bool = false
var explosion_radius: int = 400


func _process(_delta):
	if explosion_active:
		var targets = get_tree().get_nodes_in_group("Container") + get_tree().get_nodes_in_group("Entity")
		for target in targets:
			var in_range = target.global_position.distance_to(global_position) < explosion_radius
			if "hit" in target and in_range:
				target.hit()

func explosion():
	explosion_active = true
	$AnimationPlayer.play("Explosion")



		
