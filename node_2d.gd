extends Area2D

var dragging := false
var drag_start := Vector2.ZERO
var selected := []
var select_rect = RectangleShape2D.new()

var make_selection := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


# Taken from https://github.com/godotrecipes/multi_unit_select, modified
func _unhandled_input(event):
	if event is InputEventMouseButton and event.is_action("click"):
		if event.pressed:
			# If the mouse was clicked and nothing is selected, start dragging
			#if selected.size() == 0:
				dragging = true
				drag_start = event.position
			# Otherwise a click tells the selected units to move
			#else:
				#for item in selected:
					#item.collider.target = event.position
					#item.collider.selected = false
				#selected = []
		# If the mouse is released and is dragging, stop dragging and select the units
		elif dragging:
			dragging = false
			queue_redraw()
			var drag_end = event.position
			
			$CollisionShape2D.position = (drag_start + drag_end) / 2
			$CollisionShape2D.shape.size = abs(drag_end - drag_start)
			
			
			make_selection = true
			#var colliders := get_overlapping_areas()
			#for collider in colliders:
				#if collider is Person:
					#selected.append(collider)
					#(collider as Person).selected = true
			#var space = get_world_2d().direct_space_state
			#var q = PhysicsShapeQueryParameters2D.new()
			#q.shape = select_rect
			#q.collision_mask = 2 # Put people on layer 2
			#q.transform = Transform2D(0, (drag_end + drag_start) / 2)
			#var selected_dicts = space.intersect_shape(q)
			#for dict in selected_dicts:
				#if dict.collider is Person:
					#selected.append(dict.collider)
					#dict.collider.selected = true
	if event is InputEventMouseMotion and dragging:
		queue_redraw()

func _physics_process(delta: float) -> void:
	if make_selection:
		for person in selected:
			person.selected = false
		selected.clear()
		make_selection = false
		var colliders := get_overlapping_areas()
		for collider in colliders:
			if collider is Person:
				selected.append(collider)
				(collider as Person).selected = true
		
func _draw():
	if dragging:
		draw_rect(Rect2(drag_start, get_global_mouse_position() - drag_start),
				Color.YELLOW, false, 2.0)
