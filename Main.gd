extends Node
func _ready() -> void:
	# captures the mouse
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _process(delta):
	
	# make screen maximized when not already
	if DisplayServer.window_get_mode() != DisplayServer.WINDOW_MODE_MAXIMIZED and Input.is_action_pressed("Fullscreen"):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
	else: if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_MAXIMIZED and Input.is_action_pressed("Fullscreen"):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
