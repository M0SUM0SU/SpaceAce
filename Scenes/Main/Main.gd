extends Control


func _on_start_button_pressed() -> void:
	GameManager.load_level_scene()

func _on_exit_button_pressed() -> void:
	get_tree().quit()
