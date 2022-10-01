# warning-ignore-all:return_value_discarded
extends KinematicBody2D


export var walk_speed := 300.0

onready var directional_input: NC.DirectionalInput = $DirectionalInput


func _physics_process(_delta) -> void:
	# collect input
	# simulate and update internal variables
	# transition state
	var dir = directional_input.get_input_direction()
	var velocity = dir * walk_speed
	move_and_slide(velocity)
