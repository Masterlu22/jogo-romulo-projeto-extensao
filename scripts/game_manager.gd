extends Node

var tempo := 0.0
var pontuacao := 0
var vidas := 3
var especial := 0.0

func _process(delta):
	tempo += delta

func reset():
	print("reset chamado")
	tempo = 0.0
	pontuacao = 0
	vidas = 3
	especial = 0.0

func adicionar_pontos(valor: int):
	pontuacao += valor
	especial = min(100.0, especial + valor * 0.1)
