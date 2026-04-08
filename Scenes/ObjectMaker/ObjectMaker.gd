extends Node2D


const ADD_OBJECT: String = "add_object"
const EXPLOSION = preload("uid://6xl0qmd4n4s3")
const POWER_UP = preload("uid://8qmv44n5qroo")
const BULLET_BOMB = preload("uid://cexlg2gut3vwn")
const BULLET_ENEMY = preload("uid://dgbf3cv7r4nnj")
const BULLET_PLAYER = preload("uid://cxaxtsbt18imq")
const HOMING_MISSILE = preload("res://Scenes/Misc/HomingMissle.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalHub.on_create_explosion.connect(on_create_explosion)
	SignalHub.on_create_powerup.connect(on_create_powerup)
	SignalHub.on_create_powerup_random.connect(on_create_powerup_random)
	SignalHub.on_create_bullet.connect(on_create_bullet)
	SignalHub.on_create_homing_missile.connect(on_create_homing_missile)
	
func add_object(obj: Node, pos: Vector2) -> void:
	add_child(obj)
	obj.global_position = pos

func on_create_explosion(pos: Vector2, anim_name: String) -> void:
	var scene: Explosion = EXPLOSION.instantiate()
	scene.setup(anim_name)
	call_deferred(ADD_OBJECT, scene, pos)

func on_create_powerup(pos: Vector2, power_up_type: PowerUp.PowerUpType) -> void:
	var pu: PowerUp = POWER_UP.instantiate()
	pu.power_up_type = power_up_type
	call_deferred(ADD_OBJECT, pu, pos)

func on_create_powerup_random(pos: Vector2) -> void:
	var rpu: PowerUp.PowerUpType = PowerUp.PowerUpType.values().pick_random()
	on_create_powerup(pos, rpu)
	
func on_create_bullet(pos: Vector2, dir: Vector2, speed: float, bullet_type: BulletBase.BulletType) -> void:
	var scene: BulletBase
	match bullet_type:
		BulletBase.BulletType.Player:
			scene = BULLET_PLAYER.instantiate()
		BulletBase.BulletType.Enemy:
			scene = BULLET_ENEMY.instantiate()
		BulletBase.BulletType.Bomb:
			scene = BULLET_BOMB.instantiate()
	if scene:
		scene.setup(dir, speed)
		call_deferred(ADD_OBJECT, scene, pos)

func on_create_homing_missile(start_pos: Vector2) -> void:
	var hm: HomingMissile = HOMING_MISSILE.instantiate()
	call_deferred(ADD_OBJECT, hm, start_pos)
