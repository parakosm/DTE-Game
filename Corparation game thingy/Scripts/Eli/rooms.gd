extends Node2D

var Room = preload("res://Scenes/Room.tscn")

var tile_size = 32  # size of a tile in the TileMap
var num_rooms = 50  # number of rooms to generate
var min_size = 4  # minimum room size (in tiles)
var max_size = 10  # maximum room size (in tiles)

func make_rooms():
	for i in range(num_rooms):
		var pos = Vector2(0, 0)
		var r = Room.instance()
		var w = min_size + randi() % (max_size - min_size)
		var h = min_size + randi() % (max_size - min_size)
		r.make_room(pos, Vector2(w, h) * tile_size)
		$Rooms.add_child(r)

func _ready():
	randomize()
	make_rooms()
