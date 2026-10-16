extends NPCBase

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var colis: CollisionShape2D = $Area2D/CollisionShape2D

const SFXMorte = preload("res://sounds/somMorte.mp3")
@export_enum("cima", "baixo", "direita", "esquerda") var direcao: String = "esquerda"

func _ready() -> void:
	super._ready()
	if get_tree().current_scene.name == "policia_interior":
		id_dialogo = ["Capivara-prisao"]
	elif get_tree().current_scene.name == "Banco_interior":
		if Global.sequencia_players[Global.atual] == "Pato":
			id_dialogo = ["Capivara-banco", "Capivara-banco1", "pato-matar-capivara"]
		else:
			id_dialogo = ["Capivara-banco", "Capivara-banco1"]
	
	if Global.mortos.has("Capivara"):
		queue_free()
		return
	
	match direcao:
		"cima":
			anim.play("cima")
			colis.position.y -= 20
			colis.position.x += 20
		"baixo":
			anim.play("baixo")
			colis.position.y += 20
			colis.position.x += 20
		"esquerda":
			anim.play("esquerda")
		"direita":
			anim.play("direita")
			colis.position.x += 40

func _ao_realizar_escolha(resultado: int) -> void:
	if Global.sequencia_players[Global.atual] != "Pato":
		return

	if resultado != 1:
		return

	if id_dialogo_atual == "pato-matar-capivara":
		if Global.patoAcoes <= 0:
			return

		Global.patoAcoes -= 1
		morrer()

func morrer() -> void:
	Global.matar_personagem("Capivara")
	

	Transicao.executar_fade_morte(SFXMorte)
	
	await get_tree().create_timer(0.5).timeout
	queue_free()
