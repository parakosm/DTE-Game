extends TileMapLayer
@onready var walls = $"../Walls"
@onready var objects = $"../Objects"


func _use_tile_data_runtime_update(coords):
	if coords in walls.get_used_cells_by_id(0) or coords in objects.get_used_cells_by_id(0):
		return true
	return false
	
func _tile_data_runtime_update(coords, tile_data):
	if coords in walls.get_used_cells_by_id(0) or coords in objects.get_used_cells_by_id(0):
		tile_data.set_navigation_polygon(0, null)
