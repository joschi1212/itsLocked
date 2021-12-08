extends AudioStreamPlayer

export(Array, AudioStream) var audio_files: Array
export var interrupting: bool

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	pass # Replace with function body.

func play_random() -> void:
	if(interrupting):
		var random_index: = randi() % audio_files.size()
		stop()
		stream = audio_files[random_index]
		play()
	else:
		if(is_playing()):
			return
		else:
			var random_index: = randi() % audio_files.size()
			stop()
			stream = audio_files[random_index]
			play()
		
		
		

