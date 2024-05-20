extends CharacterBody2D

var active: bool = false
var player_nearby: bool = false
var speed: int = 550
var can_take_damage: bool = true
var health: int = 400

func _ready():
	$NavigationAgent2D.path_desired_distance = 14.0
	$NavigationAgent2D.target_desired_distance = 14.0
	$NavigationAgent2D.target_position = Globals.player_pos


func _physics_process(_delta):
	if active:
		var next_path_position: Vector2 = $NavigationAgent2D.get_next_path_position()
		var direction: Vector2 = (next_path_position - global_position).normalized()
		velocity = direction * speed
		look_at(next_path_position)
		if not player_nearby:
			move_and_slide()
	


func _on_notice_area_body_entered(body):
	if body.is_in_group("MainCharacter"):
		active = true
		$AnimationPlayer.play("walk")


func _on_notice_area_body_exited(body):
	if body.is_in_group("MainCharacter"):
		active = false
		$AnimationPlayer.stop()


func _on_navigation_timer_timeout():
	if active:
		$NavigationAgent2D.target_position = Globals.player_pos


func _on_attack_area_body_entered(body):
	if body.is_in_group("MainCharacter"):
		player_nearby = true
		$AnimationPlayer.play("attack")


func _on_attack_area_body_exited(body):
	if body.is_in_group("MainCharacter"):
		player_nearby = false
		$AnimationPlayer.play("walk")


func attack():
	if player_nearby:
		Globals.health_amount -= 20


func hit(damage_amount: int):
	if can_take_damage:
		health -= damage_amount
		$Timers/HitTimer.start()
		$Skeleton2D/Torso/Torso.material.set_shader_parameter("progress", 1)
		$Skeleton2D/Torso/FrontRightLeg/Sprite2D.material.set_shader_parameter("progress", 1)
		$Skeleton2D/Torso/FrontRightLeg/FrontRightClaw/Sprite2D.material.set_shader_parameter("progress", 1)
		$Skeleton2D/Torso/FrontLeftLeg/Sprite2D.material.set_shader_parameter("progress", 1)
		$Skeleton2D/Torso/FrontLeftLeg/FrontLeftClaw/Sprite2D.material.set_shader_parameter("progress", 1)
		$Skeleton2D/Torso/Head/Sprite2D.material.set_shader_parameter("progress", 1)
		$Skeleton2D/Torso/Head/RightMouthClaw/Sprite2D.material.set_shader_parameter("progress", 1)
		$Skeleton2D/Torso/Head/LeftMouthClaw/Sprite2D.material.set_shader_parameter("progress", 1)
		$Skeleton2D/Torso/BackLeftLeg/Sprite2D.material.set_shader_parameter("progress", 1)
		$Skeleton2D/Torso/BackLeftLeg/BackLeftClaw/Sprite2D.material.set_shader_parameter("progress", 1)
		$Skeleton2D/Torso/BackRightLeg/Sprite2D.material.set_shader_parameter("progress", 1)
		$Skeleton2D/Torso/BackRightLeg/BackRightClaw/Sprite2D.material.set_shader_parameter("progress", 1)
		
	if health <=0:
		queue_free()


func _on_hit_timer_timeout():
	can_take_damage = true
	$Skeleton2D/Torso/Torso.material.set_shader_parameter("progress", 0)
	$Skeleton2D/Torso/FrontRightLeg/Sprite2D.material.set_shader_parameter("progress", 0)
	$Skeleton2D/Torso/FrontRightLeg/FrontRightClaw/Sprite2D.material.set_shader_parameter("progress", 0)
	$Skeleton2D/Torso/FrontLeftLeg/Sprite2D.material.set_shader_parameter("progress", 0)
	$Skeleton2D/Torso/FrontLeftLeg/FrontLeftClaw/Sprite2D.material.set_shader_parameter("progress", 0)
	$Skeleton2D/Torso/Head/Sprite2D.material.set_shader_parameter("progress", 0)
	$Skeleton2D/Torso/Head/RightMouthClaw/Sprite2D.material.set_shader_parameter("progress", 0)
	$Skeleton2D/Torso/Head/LeftMouthClaw/Sprite2D.material.set_shader_parameter("progress", 0)
	$Skeleton2D/Torso/BackLeftLeg/Sprite2D.material.set_shader_parameter("progress", 0)
	$Skeleton2D/Torso/BackLeftLeg/BackLeftClaw/Sprite2D.material.set_shader_parameter("progress", 0)
	$Skeleton2D/Torso/BackRightLeg/Sprite2D.material.set_shader_parameter("progress", 0)
	$Skeleton2D/Torso/BackRightLeg/BackRightClaw/Sprite2D.material.set_shader_parameter("progress", 0)
