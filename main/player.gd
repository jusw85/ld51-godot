# warning-ignore-all:return_value_discarded
extends KinematicBody2D

signal gems_changed
signal moved

export var walk_speed := 100.0
export var power := 400.0
var gems := 0
var paused = false

onready var directional_input: NC.DirectionalInput = $DirectionalInput


func _physics_process(_delta) -> void:
	# collect input
	# simulate and update internal variables
	# transition state
	if paused:
		return
	var dir = directional_input.get_input_direction()
	if dir.length_squared() <= 0:
		return

	emit_signal("moved")

	var velocity = dir * walk_speed
	move_and_slide(velocity)

	for i in get_slide_count():
		var collider = get_slide_collision(i).collider
		if collider.is_in_group("wall"):
			collider.bash(power * _delta)

func add_gems(i):
	gems += i
	emit_signal("gems_changed")
