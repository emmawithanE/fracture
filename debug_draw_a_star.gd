extends Node2D

@onready var pathfinder: Pathfinder = %Pathfinder
@onready var tile_map_layer: TileMapLayer = %TileMapLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _draw() -> void:
	var coarse := pathfinder.coarse_pathfinder
	
	for id in coarse.get_point_ids():
		var point = coarse.get_point_position(id)
		draw_circle(tile_map_layer.map_to_local(point), 3.0, Color.GREEN)
		
		for connected_id in coarse.get_point_connections(id):
			if connected_id < id:
				draw_line(
					tile_map_layer.map_to_local(point), 
					tile_map_layer.map_to_local(coarse.get_point_position(connected_id)),
					Color.BLUE)
