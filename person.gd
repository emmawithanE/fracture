extends Area2D
class_name Person

var selected := false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if selected:
		#print("selected")
		modulate = Color.RED
	else:
		modulate = Color.WHITE
