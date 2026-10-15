extends NPCBase

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var colis: CollisionShape2D = $Area2D/CollisionShape2D
@export_enum("cima", "baixo", "direita", "esquerda") var direcao: String = "esquerda"

func _ready() -> void:
	super._ready()
	
	var jogador: String = Global.sequencia_players[Global.atual]
	
	if get_tree().current_scene.name == "policia_interior":
		id_dialogo = ["Pato-prisao"]
	elif get_tree().current_scene.name == "Jogo":
		
		id_dialogo = ["Pato-prisao"]
		match jogador:
			"Capivara":
				id_dialogo = ["pato-praca-capivara", "pato-praca-capivara1"]
			"Gado":
				id_dialogo = ["pato-praca-gado", "pato-praca-gado1"]
	
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
