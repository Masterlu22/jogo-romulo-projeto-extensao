extends TextureButton

@onready var label = $label_tempo
var tempo = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	tempo += delta
	var minutos = int(tempo / 60)
	var segundos = int(tempo) % 60
	label.text = "%02d:%02d" % [minutos, segundos]
	
	
