extends CanvasLayer

# colors
var green: Color = Color("56ed71")
var red: Color = Color("e84530")

@onready var laser_label: Label = $AmmoContainer/AmmoControl/HBoxContainer/LaserCounter/VBoxContainer/Label
@onready var granade_label: Label = $AmmoContainer/AmmoControl/HBoxContainer/GranadeContainer/VBoxContainer/Label
@onready var laser_icon: TextureRect = $AmmoContainer/AmmoControl/HBoxContainer/LaserCounter/VBoxContainer/TextureRect
@onready var granade_icon: TextureRect = $AmmoContainer/AmmoControl/HBoxContainer/GranadeContainer/VBoxContainer/TextureRect
@onready var health_bar: TextureProgressBar = $HealthBarContainer/HealthProgressBar

# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.connect("health_changed", update_health_text)
	Globals.connect("laser_changed", update_laser_text)
	Globals.connect("granade_changed", update_granade_text)
	update_laser_text()
	update_granade_text()
	update_health_text()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func update_laser_text():
	laser_label.text = str(Globals.laser_amount)
	update_color(Globals.laser_amount, laser_label, laser_icon)

func update_granade_text():
	granade_label.text = str(Globals.granade_amount)
	update_color(Globals.granade_amount, granade_label, granade_icon)

func update_health_text():
	health_bar.value = Globals.health_amount

func update_color(amount: int, label: Label, icon: TextureRect) -> void:
	if amount == 0:
		label.modulate = red
		icon.modulate = red
	else:
		label.modulate = green
		icon.modulate = green

