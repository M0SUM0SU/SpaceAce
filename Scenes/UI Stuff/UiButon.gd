extends TextureButton

class_name UIButton

@export var bt: String = "Jaja Mikołaja"

@onready var button_text: Label = $Button_text

func _ready() -> void:
	button_text.text = bt
