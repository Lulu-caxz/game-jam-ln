extends RigidBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var colis: CollisionShape2D = $Area2D/CollisionShape2D
@onready var area: Area2D = $Area2D
@export_enum("cima", "baixo", "direita", "esquerda") var direcao: String = "baixo"

func _ready() -> void:
	area.body_entered.connect(_on_area_2d_body_entered)
	
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

func _on_area_2d_body_entered(body: Node2D) -> void:
	if !body.is_in_group("player"):
		return
	
	var jogador: String = Global.sequencia_players[Global.atual]
	
	Global.presos.append(jogador)
	Global.acoesJogadores[jogador].append("Pego tentando fugir.")
	match jogador:
		"Capivara":
			Global.capivaraForagido = false
			Global.capivaraVezesPreso += 1
		"Pato":
			Global.patoForagido = false
			Global.patoVezesPreso += 1
		"Gado":
			Global.gadoForagido = false
			Global.gadoVezesPreso += 1
	
	Global.sendoPersiguido = false
	Transicao.mudar_cena("res://scenes/locais/policia_interior.tscn")
