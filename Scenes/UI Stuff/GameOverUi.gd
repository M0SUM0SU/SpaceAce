extends Control


func _ready() -> void:
	hide()
	get_tree().paused = false
	SignalHub.on_player_died.connect(on_player_died)
	
func _on_game_over_pressed() -> void:
	GameManager.load_main_scene()

func on_player_died() -> void:
	get_tree().paused = true
	show()
