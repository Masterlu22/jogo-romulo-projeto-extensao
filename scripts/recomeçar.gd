extends Button

func _ready():
	pressed.connect(_on_pressed)

func _on_pressed():
	GameManager.reset()
	get_tree().paused = false
	get_tree().reload_current_scene()
