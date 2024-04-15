extends CanvasLayer

@onready var laser_label: Label = $AmmoContainer/AmmoControl/HBoxContainer/LaserCounter/VBoxContainer/Label
@onready var granade_label: Label = $AmmoContainer/AmmoControl/HBoxContainer/GranadeContainer/VBoxContainer/Label

# Called when the node enters the scene tree for the first time.
func _ready():
	update_laser_text()
	update_granade_text()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_laser_text():
	laser_label.text = str(Globals.laser_amount)

func update_granade_text():
	granade_label.text = str(Globals.granade_amount)
