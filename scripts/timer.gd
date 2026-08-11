extends TextureButton

@onready var label = $"../label_tempo"

func _process(delta):
	var minutos = int(GameManager.tempo / 60)
	var segundos = int(GameManager.tempo) % 60
	label.text = "%02d:%02d" % [minutos, segundos]
