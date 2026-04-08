extends Area2D


class_name Player


const GROUP_NAME: String = "Player"
const MARGIN: float = 16.0

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var shield: Shield = $Shield
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var health_boost: int = 25
@export var speed: float = 250.0
@export var bullet_speed: float = 250.0
@export var bullet_dir: Vector2 = Vector2.UP

var _upper_left: Vector2
var _lower_right: Vector2

func set_limits() -> void:
	var vp: Rect2 = get_viewport_rect()
	_lower_right = Vector2(vp.end.x - MARGIN, vp.end.y - MARGIN)
	_upper_left = Vector2(MARGIN, MARGIN)

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("shoot"):
		SignalHub.on_create_bullet_emit(global_position, bullet_dir, bullet_speed, BulletBase.BulletType.Player)

func _ready() -> void:
	set_limits()


func _enter_tree() -> void:
	add_to_group(GROUP_NAME)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var input = get_input()
	global_position+= input * delta * speed
	global_position = global_position.clamp(_upper_left,_lower_right)

func get_input() -> Vector2:
	var v = Vector2(Input.get_axis("left","right"), Input.get_axis("up", "down"))
	
	if v.x != 0:
		animation_player.play("turn")
		sprite_2d.flip_h = true if v.x > 0 else false
	else:
		animation_player.play("Fly")
	
	return v.normalized()

func _on_area_entered(area: Area2D) -> void:
	if area is PowerUp:
		match area.power_up_type:
			PowerUp.PowerUpType.Shield:
				shield.enable_shield()
			PowerUp.PowerUpType.Health:
				SignalHub.on_player_health_bonus_emit(health_boost)
	elif area is Projectile:
		SignalHub.emit_on_player_hit(area.get_damage())
	elif area.get_parent() is EnemyBase:
		SignalHub.emit_on_player_hit(area.get_parent().crash_damage)
