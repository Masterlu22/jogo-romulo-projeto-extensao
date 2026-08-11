extends CharacterBody2D

const SPEED = 350.0

@onready var anim = $AnimatedSprite2D
@onready var hitbox = $hitbox_espada

var atacando = false
var vida := 100.0
var invencivel := false;

func _ready():
	pass
	
func _physics_process(delta: float) -> void:
	if not invencivel:
		var directionx := Input.get_axis("move_left", "move_right")
		var directiony := Input.get_axis("move_up", "move_down")
	
		if directionx:
			velocity.x = directionx * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		
		if directiony:
			velocity.y = directiony * SPEED
		else:
			velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()

	if Input.is_action_just_pressed("attack"):
		atacando = true
		anim.sprite_frames.set_animation_loop("attack", false)
		anim.play("attack")
		hitbox.monitoring = true

	if not atacando:
		if not invencivel:
			if velocity.length() > 0:
				anim.play("walk")
			else:
				anim.play("idle")

func _on_animated_sprite_2d_animation_finished() -> void:
	print("animação terminou")
	atacando = false
	hitbox.monitoring = false

func _on_hitbox_espada_body_entered(body):
	if body.is_in_group("inimigos"):
		GameManager.adicionar_pontos(15)
		var dano = 25.0
		
		if "Garrafa" in body.name:
			dano = 10.0
		var vida_antes = body.vida	
		body.tomar_dano(dano)
		if vida_antes <= 25.0:
			GameManager.adicionar_pontos(60)

func tomar_dano(origem: Vector2):
	print("romulo tomou dano!")
	if invencivel:
		return
	vida -= 7.0
	invencivel = true
	modulate = Color.RED
	
	var direcao = (global_position - origem).normalized()
	velocity = direcao * 300.0
	
	await get_tree().create_timer(0.5).timeout
	modulate = Color.WHITE
	await get_tree().create_timer(0.5).timeout
	invencivel = false
