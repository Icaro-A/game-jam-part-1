extends Node
func _ready() -> void:
	# captures the mouse
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _process(delta):
	
	# make window maximized when F pressed and not already maximized
	if DisplayServer.window_get_mode() != DisplayServer.WINDOW_MODE_MAXIMIZED and Input.is_action_pressed("Fullscreen"):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
	else: if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_MAXIMIZED and Input.is_action_pressed("Fullscreen"):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
