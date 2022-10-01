static func is_lclick(event: InputEvent):
	return event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed
