extends AudioStreamPlayer

func _ready():
	pass

func _process(delta):
    if is_playing() == false:
        print("loop")
        play()
