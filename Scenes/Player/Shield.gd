extends Area2D

class_name Shield

@export var start_health: int = 5

@onready var timer: Timer = $Timer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sound: AudioStreamPlayer2D = $Sound

var _health: int = start_health

func _ready() -> void:
	disable_shield()
	
func enable_shield() -> void:
	animation_player.play("RESET")
	_health = start_health
	SpaceUtils.toggle_area2d(self, true)
	timer.start()
	show()
	sound.play()

func disable_shield() -> void:
	timer.stop()
	SpaceUtils.toggle_area2d(self, false)
	hide()

func hit() -> void:
	_health -= 1
	animation_player.play("Animation_hit")
	if _health <= 0:
		disable_shield()

func _on_area_entered(area: Area2D) -> void:
	hit()

func _on_timer_timeout() -> void:
	disable_shield()
