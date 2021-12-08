extends Sprite

var held_object = null

var hand_open = load("res://assets/cursor_open.png")
var hand_closed = load("res://assets/cursor_closed.png")

func _ready():
	Input.set_custom_mouse_cursor(hand_open)
	
	for node in get_tree().get_nodes_in_group("pickable"):
		node.connect("clicked", self, "_on_pickable_clicked")

func _on_pickable_clicked(object):
	if !held_object:
		held_object = object
		held_object.pickup()

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if held_object and !event.pressed:
			held_object.drop(Input.get_last_mouse_speed())
			held_object = null
