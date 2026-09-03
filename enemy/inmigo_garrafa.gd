extends CharacterBody2D

var velocidade := 80.0
var player: Node2D
var vida := 100.0
var alvo_especial = null
var indo_para_tartaruga := false


@onready var barra_vida = $Barra_vida_garrafa
var knockback := Vector2.ZERO

func _ready():
	player = get_tree().get_first_node_in_group("player")

func _physics_process(delta: float) -> void:
	if knockback.length() > 0:
		velocity = knockback
		knockback = knockback.move_toward(Vector2.ZERO, 20.0)
	elif alvo_especial and is_instance_valid(alvo_especial):
		var direcao: Vector2 = (alvo_especial.global_position - global_position).normalized()
		velocity = direcao * velocidade
	elif GameManager.atordoado and not indo_para_tartaruga:
		velocity = Vector2.ZERO
	elif player:
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
	
	if player:
		var direcao = (global_position - player.global_position).normalized()
		knockback = direcao * 200.0
	
	modulate = Color.RED
	await get_tree().create_timer(0.2).timeout
	modulate = Color.WHITE
	
	if vida <= 0:
		queue_free()
		
func set_alvo(alvo):
	alvo_especial = alvo
	indo_para_tartaruga = true
	$area_dano.collision_mask |= 8
	
func _on_area_dano_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.tomar_dano(global_position)
	elif body.is_in_group("tartarugas"):
		body.ser_eliminada()
		alvo_especial = null	
		indo_para_tartaruga = false
		$area_dano.collision_mask &= ~8
		GameManager.tartaruga_eliminada()
