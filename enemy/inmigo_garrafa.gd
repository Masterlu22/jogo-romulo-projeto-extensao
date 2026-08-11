extends CharacterBody2D

var velocidade := 80.0
var player: Node2D
var vida := 100.0

@onready var barra_vida = $Barra_vida_garrafa

func _ready():
	# pega automaticamente o primeiro nó no grupo "player"
	player = get_tree().get_first_node_in_group("player")

func _physics_process(delta: float) -> void:
	if player:
		var direcao := (player.global_position - global_position).normalized()
		velocity = direcao * velocidade
		move_and_slide()
		
		for i in get_slide_collision_count():
			var colisao = get_slide_collision(i)
			if colisao.get_collider() == player:
				velocity = Vector2.ZERO

func tomar_dano(quantidade: float):
	vida -= quantidade
	barra_vida.value = vida
	
	modulate = Color.RED
	await get_tree().create_timer(0.2).timeout
	modulate = Color.WHITE
	
	if vida <= 0:
		queue_free()
