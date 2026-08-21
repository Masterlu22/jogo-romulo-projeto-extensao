extends Node

var tempo := 0.0
var pontuacao := 0
var vidas := 3
var especial := 0.0
var atordoado := false

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
	
func perder_vida():
	atordoado = true
	
	var tartarugas = Engine.get_main_loop().get_nodes_in_group("tartarugas")
	var inimigos = Engine.get_main_loop().get_nodes_in_group("inimigos")

	if tartarugas.size() > 0:
		var tartaruga_alvo = tartarugas[randi() % tartarugas.size()]
		var inimigo = inimigos[randi() % inimigos.size()]
		inimigo.set_alvo(tartaruga_alvo)		

func tartaruga_eliminada():
	atordoado = false
	
	var hud = Engine.get_main_loop().root.get_node("Cenario/CanvasLayer")
	var nome_vida = "icon_vida" + ("" if vidas == 1 else str(vidas))
	var nome_tartaruga = "icon_tartaruga" + ("" if vidas == 1 else str(vidas))
	
	hud.get_node("HBoxContainer3/" + nome_vida).visible = false
	hud.get_node("HBoxContainer4/" + nome_tartaruga).visible = false
	
	vidas -= 1
	print("vidas restantes ", vidas)
	
	if vidas <= 0:
		print("game over!!")
		Engine.get_main_loop().change_scene_to_file("res://game_over.tscn")
