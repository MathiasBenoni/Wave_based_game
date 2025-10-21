extends Control

var is_loading = false

@onready var start_button = $VBoxContainer/VBoxContainer/start

func _on_start_pressed() -> void:
	if is_loading:
		return
	
	is_loading = true
	start_button.text = "Loading..."
	start_button.disabled = true
	
	# Start threaded loading
	ResourceLoader.load_threaded_request("res://scenes/main.tscn")
	
	# Wait for it to load
	_wait_for_load()

func _wait_for_load():
	var progress = []
	var status = ResourceLoader.load_threaded_get_status("res://scenes/main.tscn", progress)
	
	if status == ResourceLoader.THREAD_LOAD_LOADED:
		# Loading complete!
		var main_scene = ResourceLoader.load_threaded_get("res://scenes/main.tscn")
		get_tree().change_scene_to_packed(main_scene)
	elif status == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
		# Still loading, check again next frame
		await get_tree().process_frame
		_wait_for_load()
	else:
		# Error
		print("Failed to load scene")
		start_button.text = "Start"
		start_button.disabled = false
		is_loading = false

func _on_settings_pressed() -> void:
	pass

func _on_quit_pressed() -> void:
	get_tree().quit()
	print("Quit")
