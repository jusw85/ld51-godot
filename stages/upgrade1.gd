extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var upgrading := false
var hp := 100.0
var player
onready var label = $Label
export var upgrade_speed := 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	label.text = str("%d" % hp)
	if upgrading:
		hp = clamp(hp - (delta * upgrade_speed), 0, hp)
		if hp <= 0:
			hp = 100
			player.walk_speed += 50
			player.add_gems(-5)


func _on_Area2D_body_entered(body):
	player = body
	upgrading = true


func _on_Area2D_body_exited(_body):
	upgrading = false
