extends Button

func _ready():
	pressed.connect(_on_pressed)
	
func _on_pressed():
	GameManager.reset()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/cenario.tscn")
