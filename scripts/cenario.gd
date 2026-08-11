extends Node2D

@export var cena_sacola : PackedScene
@export var cena_garrafa : PackedScene

var timer_spawn := 0.0

func _ready():
	print("cenario iniciado!")

func _process(delta):
	timer_spawn += delta
	
	if timer_spawn >= intervalo_atual():
		timer_spawn = 0.0
		spawnar()

func intervalo_atual() -> float:
	return max(3.0, 15.0 - GameManager.tempo * 0.02)

func velocidade_atual() -> float:
	return min(200.0, 80.0 + GameManager.tempo * 0.1)

func spawnar():
	var inimigo
	var chance_garrafa = clamp(GameManager.tempo / 360.0, 0.0, 0.5)
	
	if randf() < chance_garrafa:
		inimigo = cena_garrafa.instantiate()
	else:
		inimigo = cena_sacola.instantiate()
	
	if inimigo == null:
		print("ERRO: inimigo é null!")
		return
	
	var viewport_size = get_viewport_rect().size
	inimigo.global_position = Vector2(randf_range(100, viewport_size.x - 100), -600)
	inimigo.velocidade = velocidade_atual()
	$inimigos.add_child(inimigo)
