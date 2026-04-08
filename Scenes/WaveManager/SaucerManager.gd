extends Node2D

const ENEMY_SAUCER = preload("uid://bg472huctv8ko")

const WAIT_TIME = 6.0
const WAIT_VARIATION = 1.0


@onready var spawn_timer: Timer = $SpawnTimer
@onready var paths: Node2D = $Paths





var _path2Ds: Array[Path2D] = []

func _ready() -> void:
	for path in paths.get_children():
		_path2Ds.append(path)
	reset_timer()


func reset_timer() -> void:
	SpaceUtils.set_and_start_timer(spawn_timer, WAIT_TIME, WAIT_VARIATION)


func spawn_saucer():
	var path: Path2D = _path2Ds.pick_random()
	path.add_child(ENEMY_SAUCER.instantiate())
	reset_timer()


func _on_spawn_timer_timeout() -> void:
	spawn_saucer()
