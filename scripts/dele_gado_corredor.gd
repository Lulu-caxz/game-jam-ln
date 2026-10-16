extends RigidBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var colis: CollisionShape2D = $Area2D/CollisionShape2D
@export_enum("cima", "baixo", "direita", "esquerda") var direcao: String = "baixo"

func _ready() -> void:
	
	match direcao:
		"cima":
			anim.play("cima")
		"baixo":
			anim.play("baixo")
		"esquerda":
			anim.play("esquerda")
		"direita":
			anim.play("direita")
			colis.position.x += 40


func _physics_process(delta: float) -> void:
	if position.y < 100:
		linear_velocity = Vector2(0, 20)
	else:
		linear_velocity = Vector2.ZERO
