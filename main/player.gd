# warning-ignore-all:return_value_discarded
# warning-ignore-all:unused_signal
extends KinematicBody2D

signal gems_changed
signal moved

export var walk_speed := 100.0
export var power := 400.0
var gems := 0
var paused := false
var gooped := 0.0
var goop_shoes := false
var lantern := false
var upgrade_speed := 100.0

onready var directional_input: NC.DirectionalInput = $DirectionalInput
onready var goop_label = $Panel
onready var money_label = $Panel2/Label
onready var magnet = $Area2D/CollisionShape2D

onready var mask: Sprite = $Mask
var mask_size setget set_mask_size, get_mask_size
func get_mask_size() -> float:
	return mask.material.get_shader_param("size")
func set_mask_size(p_mask_size):
	mask_size = clamp(p_mask_size, 0.0, 1.0)
#	mask.self_modulate.a = 1.0 - mask_size
	if !lantern:
		mask.self_modulate.a = 1 - (0.0001) * exp(mask_size * (log(1 / 0.0001)))
	else:
		mask.self_modulate.a = 0.0
	mask.material.set_shader_param("size", mask_size)


func _ready():
	self.mask_size = 1.0
	if goop_shoes:
		goop_label.visible = true


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

	var velocity
	if gooped <= 0 || goop_shoes:
		velocity = dir * walk_speed
	else:
		velocity = dir * (walk_speed / 4.0)
	move_and_slide(velocity)

	for i in get_slide_count():
		var collider = get_slide_collision(i).collider
		if collider.is_in_group("wall"):
			collider.bash(power * _delta)

func add_gems(i):
	gems += i
	money_label.text = str(gems)
#	emit_signal("gems_changed")
