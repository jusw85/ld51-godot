extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var upgrading := false
var hp := 500.0
var player
onready var label = $Label
onready var label2 = $Label2
#export var upgrade_speed := 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player == null:
		player = get_tree().get_nodes_in_group("player")[0]
		if player.goop_shoes:
			hp = 0
			label2.text = "Bought!"

	label.text = str("%d" % hp)
	if upgrading && player.gems >= 20 && !player.goop_shoes:
		hp = clamp(hp - (delta * player.upgrade_speed), 0, hp)
		if hp <= 0:
			player.goop_shoes = true
			player.add_gems(-20)
			player.goop_label.visible = true
			label2.text = "Bought!"


func _on_Area2D_body_entered(_body):
	upgrading = true


func _on_Area2D_body_exited(_body):
	upgrading = false
