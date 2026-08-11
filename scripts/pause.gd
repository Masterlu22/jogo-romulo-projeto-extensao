extends TextureButton

@export var texture_pause : Texture2D
@export var texture_play : Texture2D

@onready var fundo = get_tree().root.get_node("Cenario/CanvasLayer/pause_fundo")

func _ready():
	pressed.connect(_on_pressed)
	texture_normal = texture_pause

func _on_pressed():
	get_tree().paused = !get_tree().paused
	fundo.visible = get_tree().paused

	if get_tree().paused:
		texture_normal = texture_play
	else:
		texture_normal = texture_pause	
