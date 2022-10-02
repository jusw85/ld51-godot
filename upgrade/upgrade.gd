extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var label = $Label
var player

# Called when the node enters the scene tree for the first time.
func _ready():
#	pass
	player = get_tree().get_nodes_in_group("player")[0]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
#	label.text = str(player.gems)


func _on_Button3_pressed():
	Events.emit_signal("upgrade_exited")
	queue_free()


func _on_Button_pressed():
	if player.gems >= 5:
		player.add_gems(-5)
		player.walk_speed += 50


func _on_Button2_pressed():
	if player.gems >= 5:
		player.add_gems(-5)
		player.power += 50
