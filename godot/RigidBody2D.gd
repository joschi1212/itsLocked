extends RigidBody2D


signal clicked
var hand_open = load("res://assets/cursor_open.png")
var hand_closed = load("res://assets/cursor_closed.png")

var soundPlayer

var held = false

# Called when the node enters the scene tree for the first time.
func _ready():
	soundPlayer = "../AudioStreamPlayer"
	connect("body_entered", self, "_on_body_entered")
	pass # Replace with function body.


func _process(delta):
	pass


func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			emit_signal("clicked", self)
			Input.set_custom_mouse_cursor(hand_closed)
		if event.button_index == BUTTON_LEFT and !event.pressed:
			Input.set_custom_mouse_cursor(hand_open)


func _on_body_entered(body):
	var force = get_linear_velocity().length()
	print(force)

func _physics_process(delta):
	if held:
		global_transform.origin = get_global_mouse_position()

func pickup():
	if held:
		return
	mode = RigidBody2D.MODE_STATIC
	held = true

func drop(impulse = Vector2.ZERO):
	if held:
		mode = RigidBody2D.MODE_RIGID
		apply_central_impulse(10.0 * impulse)
		held = false
