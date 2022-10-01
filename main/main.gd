extends Node2D

onready var timer = $Timer
onready var timer_label = $CanvasLayer/Label
onready var gem_label = $CanvasLayer/Label2
onready var player = $Player

func _ready():
	randomize()
	var spawn = get_tree().get_nodes_in_group("spawn")[0]
	player.position = spawn.position
	timer_label.text = "%.2f" % timer.wait_time


func _on_Timer_timeout():
	print("kaboom")
	Globals.restart()

func _process(_delta):
	if !timer.is_stopped():
		timer_label.text = "%.2f" % timer.time_left


func _on_KinematicBody2D_gems_changed():
	gem_label.text = str(player.gems)
	pass # Replace with function body.


func _on_Player_moved():
	if timer.is_stopped():
		timer.start()
