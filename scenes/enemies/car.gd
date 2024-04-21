extends PathFollow2D

var player_nearby: bool = false

@onready var line1: Line2D = $Turret/RayCast2D/Line2D
@onready var line2: Line2D = $Turret/RayCast2D2/Line2D

func _ready():
	line2.add_point($Turret/RayCast2D2.target_position)
	$Turret/RayCast2D/Sprite2D.modulate = "ffffff00"
	$Turret/RayCast2D2/Sprite2D.modulate = "ffffff00"
	$Turret/RayCast2D/Line2D.width = 0
	$Turret/RayCast2D2/Line2D.width = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	progress_ratio += 0.02 * delta
	if player_nearby:
		$Turret.look_at(Globals.player_pos)


func fire():
	Globals.health_amount -= 20


func _on_notice_area_body_entered(body):
	if body.is_in_group("MainCharacter"):
		player_nearby = true
		$AnimationPlayer.play("laser_loading")


func _on_notice_area_body_exited(body):
	if body.is_in_group("MainCharacter"):
		player_nearby = false
		$AnimationPlayer.stop()
