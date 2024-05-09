extends CharacterBody2D

var active: bool = false
var speed: int = 500

func _ready():
	$NavigationAgent2D.target_position = Globals.player_pos


func _physics_process(_delta):
	if active:
		var next_path_position: Vector2 = $NavigationAgent2D.get_next_path_position()
		var direction: Vector2 = (next_path_position - global_position).normalized()
		velocity = direction * speed
		look_at(Globals.player_pos)
		$AnimationPlayer.play("walk")
		move_and_slide()
	


func _on_notice_area_body_entered(body):
	if body.is_in_group("MainCharacter"):
		active = true


func _on_notice_area_body_exited(body):
	if body.is_in_group("MainCharacter"):
		active = false


func _on_navigation_timer_timeout():
	if active:
		$NavigationAgent2D.target_position = Globals.player_pos
