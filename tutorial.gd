extends TextureButton

func _ready():
	pressed.connect(_on_pressed)
	
func _on_pressed():
	get_tree().root.get_node("Cenario/CanvasLayer/tutorial painel").visible = true
	get_tree().paused = true
	
