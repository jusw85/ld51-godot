# warning-ignore-all:return_value_discarded
extends Node


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("restart"):
		restart()


func restart():
	get_tree().change_scene(ProjectSettings.get_setting("application/run/main_scene"))
