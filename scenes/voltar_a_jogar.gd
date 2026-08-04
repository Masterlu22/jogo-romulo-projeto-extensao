extends Button

func _ready():
	pressed.connect(_on_pressed)

func _on_pressed():
	get_tree().root.get_node("Cenario/CanvasLayer/menu_painel").visible = false
	get_tree().paused = false
