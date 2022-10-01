extends StaticBody2D


export var hp := 100.0
onready var label = $Label

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	update_label()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func bash(dmg):
	hp = clamp(hp - dmg, 0, hp)
	update_label()
	if hp <= 0:
		queue_free()


func update_label():
	label.text = str(int(hp))
