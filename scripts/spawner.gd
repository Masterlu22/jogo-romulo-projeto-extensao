extends Node2D

@export var cena_sacola : PackedScene
@export var cena_garrafa : PackedScene

var timer_spawn := -5.0

func _ready():
	print("spawner iniciado!")
	
func _process(delta):
	timer_spawn += delta
	
	if timer_spawn >= intervalo_atual():
		timer_spawn = 0.0
		spawnar()

func intervalo_atual() -> float:
	# começa em 15s e vai diminuindo até no mínimo 3s
	return max(3.0, 15.0 - GameManager.tempo * 0.02)

func velocidade_atual() -> float:
	# começa em 80 e vai aumentando até no máximo 200
	return min(200.0, 80.0 + GameManager.tempo * 0.1)
	
var count = 0
func spawnar():
	count += 1
	print("spawn #", count)
	var inimigo
	var chance_garrafa = clamp(GameManager.tempo / 360.0, 0.0, 0.5)
	
	if randf() < chance_garrafa:
		inimigo = cena_garrafa.instantiate()
	else:
		inimigo = cena_sacola.instantiate()
	
	var viewport_size = get_viewport_rect().size
	inimigo.global_position = Vector2(randf_range(100, viewport_size.x - 100), -600)
	
	inimigo.velocidade = velocidade_atual()
	add_child(inimigo)
