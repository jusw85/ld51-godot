# warning-ignore-all:return_value_discarded
extends Node2D

onready var timer = $Timer
onready var timer_label = $CanvasLayer/Label
onready var gem_label = $CanvasLayer/Label2
#onready var upgrade = $CanvasLayer/upgrade
onready var canvas = $CanvasLayer
onready var player = $Player
onready var stage = $Stage

var _stage_number := 0

func _ready():
	randomize()

	var spawn = get_tree().get_nodes_in_group("spawn")[0]
	player.position = spawn.position

	timer_label.text = "%.2f" % timer.wait_time

	Events.connect("stage_exited", self, "_on_stage_exit")
	Events.connect("upgrade_exited", self, "_on_upgrade_exit")


func _on_Timer_timeout():
	var end = load("res://end/end.tscn").instance()
	get_tree().get_root().add_child(end)
	var label = end.get_node("Label")
	label.text = label.text % _stage_number
	get_tree().current_scene = end
	queue_free()


func _process(_delta):
	if !timer.is_stopped():
		timer_label.text = "%.2f" % timer.time_left


func _on_Player_gems_changed():
	gem_label.text = str(player.gems)


func _on_Player_moved():
	if timer.is_stopped():
		timer.start()


func _on_stage_exit():
	_stage_number += 1
	player.paused = true
	player.visible = false
	player.position = Vector2(-1000, -1000)

	timer_label.visible = false
	timer.stop()
	stage.get_child(0).queue_free()

	var upgrade = load("res://upgrade/upgrade.tscn").instance()
	canvas.add_child(upgrade)


func _on_upgrade_exit():
	player.paused = false
	player.visible = true

	timer_label.visible = true
	timer.start()
	timer.stop()
	timer_label.text = "%.2f" % timer.wait_time

	var stage_num = (randi() % 5) + 1
	var new_stage = load("res://stages/stage" + str(stage_num) + ".tscn").instance()
	new_stage.difficulty_modifier = _stage_number
	stage.add_child(new_stage)
	var spawn = get_tree().get_nodes_in_group("spawn")[0]
	player.position = spawn.position

const Levels = [
	preload("res://stages/stage1.tscn"),
	preload("res://stages/stage2.tscn"),
	preload("res://stages/stage3.tscn"),
	preload("res://stages/stage4.tscn"),
	preload("res://stages/stage5.tscn"),
]

const LevelUpgrade = preload("res://stages/stage_upgrade.tscn")
