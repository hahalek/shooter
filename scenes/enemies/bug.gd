extends CharacterBody2D

var speed: int = 300
var health: int = 60
var player_nearby: bool = false
var player_in_attack_area: bool = false
var can_take_damage: bool = true
var can_bite: bool = true

signal bite


func _process(_delta):
	if player_in_attack_area:
		$AnimatedSprite2D.play("attack")
		if can_bite:
			bite.emit()
			can_bite = false
			$Timers/BiteCooldown.start()
	elif player_nearby:
		$AnimatedSprite2D.play("walk")
		look_at(Globals.player_pos)
		velocity = (Globals.player_pos - global_position).normalized() * speed
		move_and_slide()

func hit(damage_amount: int):
	if can_take_damage:
		$AnimatedSprite2D.material.set_shader_parameter("progress", 1)
		$Particles/HitParticles.emitting = true
		health -= damage_amount
		if health <= 0:
			$Particles/HitParticles.emitting = true
			await get_tree().create_timer(0.5).timeout
			queue_free()
		can_take_damage = false
		$Timers/TakeDamageCooldown.start()


func _on_notice_area_body_entered(body):
	if body.is_in_group("MainCharacter"):
		player_nearby = true


func _on_notice_area_body_exited(body):
	if body.is_in_group("MainCharacter"):
		player_nearby = false


func _on_attack_area_body_entered(body):
	if body.is_in_group("MainCharacter"):
		player_in_attack_area = true


func _on_attack_area_body_exited(body):
	if body.is_in_group("MainCharacter"):
		player_in_attack_area = false


func _on_bite_cooldown_timeout():
	can_bite = true


func _on_take_damage_cooldown_timeout():
	can_take_damage = true
	$AnimatedSprite2D.material.set_shader_parameter("progress", 0)
