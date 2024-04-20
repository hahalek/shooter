extends CharacterBody2D

var max_speed: int = 600
var speed: int = 0
var speed_multiplier: int = 1
var active: bool = false
var can_take_damage: bool = true
var health: int = 10


# Called when the node enters the scene tree for the first time.
func _ready():
	$Explosion.hide()
	$Sprite2D.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if active:
		look_at(Globals.player_pos)
		var direction = (Globals.player_pos - global_position).normalized()
		velocity = direction * speed * delta * speed_multiplier
		var collision = move_and_collide(velocity)
		if collision:
			$AnimationPlayer.play("explosion")


func stop_movement():
	speed_multiplier = 0


func hit(damage_amount: int):
	if can_take_damage:
		$Sprite2D.material.set_shader_parameter("progress", 1)
		health -= damage_amount
		can_take_damage = false
		$TakeDamageCooldown.start()
	if health <= 0:
		$AnimationPlayer.play("explosion")


func _on_notice_area_body_entered(_body):
	active = true
	var tween = create_tween()
	tween.tween_property(self, "speed", max_speed, 5)


func _on_take_damage_cooldown_timeout():
	can_take_damage = true
	$Sprite2D.material.set_shader_parameter("progress", 0)


func do_damage():
	for entity in $BlastArea.get_overlapping_bodies():
		if "hit" in entity:
			var damage_amount = 30
			entity.hit(damage_amount)
