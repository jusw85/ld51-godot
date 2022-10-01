# warning-ignore-all:return_value_discarded
extends Node2D


var _player
onready var _tween: Tween = $Tween


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		body.add_gems(1)
		queue_free()


func _on_Area2D_area_entered(area):
	if _player == null:
		_player = area.get_parent()
		_tween.follow_method(
			self, "set_global_position", global_position, _player, "get_global_position", 0.1
		)
		_tween.start()
