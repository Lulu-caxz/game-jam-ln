extends NPCBase

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var colis: CollisionShape2D = $Area2D/CollisionShape2D
@export_enum("cima", "baixo", "direita", "esquerda") var direcao: String = "esquerda"

func _ready() -> void:
	super._ready()
	if get_tree().current_scene.name == "policia_interior":
		id_dialogo = ["Capivara-prisao"]
	elif get_tree().current_scene.name == "Banco_interior":
<<<<<<< HEAD
		id_dialogo = ["Capivara-banco", "Capivara-banco1"]
=======
		id_dialogo = ["Capivara-banco" , "Capivara-banco1"]
>>>>>>> 7ee254d9b07d257cbd7502b6b8d3ebd60611fd5f
	
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
