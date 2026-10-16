extends NPCBase

@onready var colis: CollisionShape2D = $Area2D/CollisionShape2D
@export_enum("cima", "baixo", "direita", "esquerda") var direcao: String = "esquerda"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	id_dialogo = ["descanso"]
	
	match direcao:
		"cima":
			colis.position.y -= 20
			colis.position.x += 20
		"baixo":
			colis.position.y += 20
			colis.position.x += 20
		"esquerda":
			pass
		"direita":
			colis.position.x += 40


func _ao_realizar_escolha(resultado: int) -> void:

	var resposta: bool

	match resultado:
		1:
			resposta = true
		2:
			resposta = false

	if resposta:
		Global.descansar(Global.sequencia_players[Global.atual])
