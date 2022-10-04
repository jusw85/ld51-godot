# warning-ignore-all:return_value_discarded
extends Node

var final_unlocked := false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("restart"):
		restart()


func restart():
#	print(get_tree().current_scene)
#	get_tree().current_scene.queue_free()
	get_tree().change_scene(ProjectSettings.get_setting("application/run/main_scene"))
