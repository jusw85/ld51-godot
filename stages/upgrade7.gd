extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var upgrading := false
var hp := 2000.0
var player
onready var label = $Label
onready var label2 = $Label2
#export var upgrade_speed := 100

# Called when the node enters the scene tree for the first time.
func _ready():
	if Globals.final_unlocked:
		print("!")
		var inst = load("res://end/exit_extra.tscn").instance()
		get_parent().call_deferred("add_child", inst)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player == null:
		player = get_tree().get_nodes_in_group("player")[0]

	if Globals.final_unlocked:
		hp = 0
		label2.text = "Bought!"

	label.text = str("%d" % hp)
	if upgrading && player.gems >= 100 && !Globals.final_unlocked:
		hp = clamp(hp - (delta * player.upgrade_speed), 0, hp)
		if hp <= 0:
			Globals.final_unlocked = true
			player.add_gems(-100)
			label2.text = "Bought!"
			var inst = load("res://end/exit_extra.tscn").instance()
			get_parent().add_child(inst)


func _on_Area2D_body_entered(_body):
	upgrading = true


func _on_Area2D_body_exited(_body):
	upgrading = false
