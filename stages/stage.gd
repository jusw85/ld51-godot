extends Node2D


onready var tm = $TileMap

const Spawn := preload("res://main/spawn.tscn")
const Gem := preload("res://main/gem.tscn")
const Wall := preload("res://main/wall.tscn")
const Exit := preload("res://main/exit.tscn")
const Goop := preload("res://main/goop.tscn")
const Unbreakable := preload("res://main/unbreakable.tscn")
const Toll := preload("res://main/toll.tscn")
var difficulty_modifier = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	process_tilemap(tm)
	var tm2 = get_node_or_null("TileMap2")
	if tm2 != null:
		process_tilemap(tm2)


func process_tilemap(tilemap):
	var ts = tilemap.get_tileset()
	for pos in tilemap.get_used_cells():
		var id = tilemap.get_cell(pos.x, pos.y)
		var tile_name = ts.tile_get_name(id)
		match tile_name:
			"player":
				_add_node(pos.y, pos.x, Spawn.instance())
			"gem":
				_add_node(pos.y, pos.x, Gem.instance())
			"wall":
				var obj = Wall.instance()
				if difficulty_modifier > 0:
#					obj.hp += randi() % (10 * difficulty_modifier)
					obj.hp += (7 * difficulty_modifier) + ((randi() % 51) - 50)
				_add_node(pos.y, pos.x, obj)
			"exit":
				_add_node(pos.y, pos.x, Exit.instance())
			"goop":
				_add_node(pos.y, pos.x, Goop.instance())
			"unbreakable":
				_add_node(pos.y, pos.x, Unbreakable.instance())
			"toll":
				_add_node(pos.y, pos.x, Toll.instance())

		tilemap.set_cell(pos.x, pos.y, TileMap.INVALID_CELL)
	pass


func _add_node(p_y: int, p_x: int, p_instance: Node, p_centred: bool = true):
	var local_pos = tm.map_to_world(Vector2(p_x, p_y))
	if p_centred:
		local_pos += (tm.cell_size / 2.0)
	p_instance.position = local_pos
	add_child(p_instance)

