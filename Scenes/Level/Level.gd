extends Node2D


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Test"):
		SignalHub.on_create_bullet_emit(Vector2(315, 300), Vector2.DOWN, 120.0, BulletBase.BulletType.Enemy)
	elif Input.is_action_just_pressed("exit"):
		GameManager.load_main_scene()
