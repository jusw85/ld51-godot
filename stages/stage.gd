extends Node2D


onready var tilemap = $TileMap

const Spawn := preload("res://main/spawn.tscn")
const Gem := preload("res://main/gem.tscn")
const Wall := preload("res://main/wall.tscn")
const Exit := preload("res://main/exit.tscn")
var difficulty_modifier = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var ts = tilemap.get_tileset()

	for pos in tilemap.get_used_cells():
		var id = tilemap.get_cell(pos.x, pos.y)
		match ts.tile_get_name(id):
			"player":
				_add_node(pos.y, pos.x, Spawn.instance())
			"gem":
				_add_node(pos.y, pos.x, Gem.instance())
			"wall":
				var obj = Wall.instance()
				if difficulty_modifier > 0:
					obj.hp += randi() % (10 * difficulty_modifier)
				_add_node(pos.y, pos.x, obj)
			"exit":
				_add_node(pos.y, pos.x, Exit.instance())

		tilemap.set_cell(pos.x, pos.y, TileMap.INVALID_CELL)


func _add_node(p_y: int, p_x: int, p_instance: Node, p_centred: bool = true):
	add_child(p_instance)
	var local_pos = tilemap.map_to_world(Vector2(p_x, p_y))
	if p_centred:
		local_pos += (tilemap.cell_size / 2.0)
	p_instance.position = local_pos

