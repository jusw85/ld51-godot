# warning-ignore-all:return_value_discarded
extends KinematicBody2D

signal gems_changed()

export var walk_speed := 300.0
export var power := 100.0
var gems := 0

onready var directional_input: NC.DirectionalInput = $DirectionalInput


func _physics_process(_delta) -> void:
	# collect input
	# simulate and update internal variables
	# transition state
	var dir = directional_input.get_input_direction()
	var velocity = dir * walk_speed
	move_and_slide(velocity)

	for i in get_slide_count():
		var collider = get_slide_collision(i).collider
		if collider.is_in_group("wall"):
			collider.bash(power * _delta)

func add_gems(i):
	gems += i
	emit_signal("gems_changed")
