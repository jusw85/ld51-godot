extends Node2D

onready var timer = $Timer
onready var timer_label = $CanvasLayer/Label
onready var gem_label = $CanvasLayer/Label2
onready var player = $Player

func _ready():
	randomize()
	var spawn = get_tree().get_nodes_in_group("spawn")[0]
	player.position = spawn.position


func _on_Timer_timeout():
	print("kaboom")
	Globals.restart()


func _process(_delta):
	timer_label.text = str(stepify(timer.time_left, 0.01))


func _on_KinematicBody2D_gems_changed():
	gem_label.text = str(player.gems)
	pass # Replace with function body.
