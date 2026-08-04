extends CharacterBody2D

const SPEED = 350.0

@onready var anim = $AnimatedSprite2D
@onready var hitbox = $hitbox_espada

var atacando = false

func _ready():
	pass
	
func _physics_process(delta: float) -> void:
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
		if directionx != 0 or directiony != 0:
			anim.play("walk")
		else:
			anim.play("idle")

func _on_animated_sprite_2d_animation_finished() -> void:
	print("animação terminou")
	atacando = false
	hitbox.monitoring = false
