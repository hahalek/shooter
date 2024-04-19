extends CharacterBody2D

var player_nearby: bool = false
var can_laser: bool = true
var right_gun_use: bool = true
var can_take_damage: bool = true

var health: int = 20

signal laser(pos, direction)


func _process(_delta):
	if player_nearby:
		look_at(Globals.player_pos)
		if can_laser:
			var marker_node = $LaserSpawnPositions.get_child(right_gun_use)
			right_gun_use = not right_gun_use
			var pos: Vector2 = marker_node.global_position
			var direction: Vector2 = (Globals.player_pos - position).normalized()
			laser.emit(pos, direction)
			can_laser = false
			$Timers/LaserCooldown.start()


func _on_attack_area_body_entered(body):
	if body is CharacterBody2D:
		player_nearby = true


func _on_attack_area_body_exited(_body):
	player_nearby = false


func _on_laser_cooldown_timeout():
	can_laser = true


func hit():
	if can_take_damage:
		health -= 9
		can_take_damage = false
		$Timers/TakeDamageCooldown.start()
	if health <= 0:
		queue_free()


func _on_take_damage_cooldown_timeout():
	can_take_damage = true
