extends Node
class_name Pathfinder

@onready var tile_map_layer: TileMapLayer = %TileMapLayer

@onready var coarse_pathfinder := AStar2D.new()



func _ready() -> void:
	var used_tiles := tile_map_layer.get_used_cells()
	var used_area := tile_map_layer.get_used_rect()
	
	# AStar index = tile_coord.x + tile_coord.y * width
	# Fill in connections based on corners, but later
	
	for tile in used_tiles:
		coarse_pathfinder.add_point(tile_pos_to_id(tile, used_area), tile)
	
	for tile in used_tiles:
		# Connect to tiles in top left, left, top, top right positions
		var tile_data := tile_map_layer.get_cell_tile_data(tile)
		var tile_terrain := tile_data.terrain
		if tile_data.get_terrain_peering_bit(TileSet.CELL_NEIGHBOR_LEFT_SIDE) == tile_terrain:
			# Connect to left
			coarse_pathfinder.connect_points(
				tile_pos_to_id(tile, used_area),
				tile_pos_to_id(tile + Vector2i.LEFT, used_area)
			)
		if tile_data.get_terrain_peering_bit(TileSet.CELL_NEIGHBOR_TOP_LEFT_CORNER) == tile_terrain:
			# Connect to top left
			coarse_pathfinder.connect_points(
				tile_pos_to_id(tile, used_area),
				tile_pos_to_id(tile + Vector2i.LEFT + Vector2i.UP, used_area)
			)
		if tile_data.get_terrain_peering_bit(TileSet.CELL_NEIGHBOR_TOP_SIDE) == tile_terrain:
			# Connect to top
			coarse_pathfinder.connect_points(
				tile_pos_to_id(tile, used_area),
				tile_pos_to_id(tile + Vector2i.UP, used_area)
			)
		if tile_data.get_terrain_peering_bit(TileSet.CELL_NEIGHBOR_TOP_RIGHT_CORNER) == tile_terrain:
			# Connect to top right
			coarse_pathfinder.connect_points(
				tile_pos_to_id(tile, used_area),
				tile_pos_to_id(tile + Vector2i.RIGHT + Vector2i.UP, used_area)
			)


func tile_pos_to_id(pos : Vector2i, used : Rect2i) -> int:
	return pos.x + pos.y * used.size.x


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
