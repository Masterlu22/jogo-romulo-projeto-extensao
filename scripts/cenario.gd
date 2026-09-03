extends Node2D

@export var cena_sacola : PackedScene
@export var cena_garrafa : PackedScene
@export var cena_canudo : PackedScene

var timer_spawn := 0.0

func _ready():
	print("cenario iniciado! tempo: ", GameManager.tempo)

func _process(delta):
	timer_spawn += delta
	
	if timer_spawn >= intervalo_atual():
		timer_spawn = 0.0
		spawnar()

func intervalo_atual() -> float:
	return max(3.0, 6.0 - GameManager.tempo * 0.05)

func velocidade_atual() -> float:
	return min(200.0, 80.0 + GameManager.tempo * 0.1)

func spawnar():
	var inimigo
	var tempo = GameManager.tempo
	
	if tempo < 60:
		inimigo = cena_canudo.instantiate()
	elif tempo < 180:
		if randf() < 0.5:
			inimigo = cena_canudo.instantiate()
		else:
			inimigo = cena_sacola.instantiate()
	else:
		var sorteio = randf()
		if sorteio < 0.2:
			inimigo = cena_canudo.instantiate()
		elif sorteio < 0.6:
			inimigo = cena_sacola.instantiate()
		else:
			inimigo = cena_garrafa.instantiate()
	
	if inimigo == null:
		print("ERRO: inimigo é null!!")
		return
	
	var viewport_size = get_viewport_rect().size
	inimigo.global_position = Vector2(randf_range(100, viewport_size.x - 100), -600)
	inimigo.velocidade = velocidade_atual()
	$inimigos.add_child(inimigo)		
