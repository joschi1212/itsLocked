extends RigidBody2D


signal clicked
var hand_open = load("res://assets/cursor_open.png")
var hand_closed = load("res://assets/cursor_closed.png")

var image
var chest_closed = load("res://assets/chest_closed.png")
var chest_open = load("res://assets/chest_open.png")

var wood_player
var voice_player
var specific_voice_sfx

var held = false
var broken = false

# Called when the node enters the scene tree for the first time.
func _ready():
	wood_player = get_node("../random_wood_sfx")
	voice_player = get_node("../random_voice_sfx")
	specific_voice_sfx = get_node("../specific_voice_sfx")

	image = get_node("Sprite")
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

	if(force > 100 and force < 2000 and !broken):
		wood_player.play_random(force)
		voice_player.play_random(force)
	if(force > 2000):
		broken = true
		image.set_texture(chest_open)
		specific_voice_sfx.play_specific(0)
		yield(get_tree().create_timer(5, false), "timeout")
		image.set_texture(chest_closed)
		specific_voice_sfx.play_specific(1)
		broken = false
	



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
