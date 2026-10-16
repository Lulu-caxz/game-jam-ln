extends NPCBase

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var colis: CollisionShape2D = $Area2D/CollisionShape2D
@export_enum("cima", "baixo", "direita", "esquerda") var direcao: String = "esquerda"

func _ready() -> void:
	super._ready()
	
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

# Sobrescrevemos o gerar_dialogo para definir o dialogo correto antes de chamar a base
func gerar_dialogo() -> void:
	var jogador_atual = Global.sequencia_players[Global.atual]

	# 1. Se a manifestação já aconteceu
	if Global.manifestacaoRealizada:
		id_dialogo = ["manifestacao-ja-feita"]
		dialogo_index = 0
	
	# 2. Se for a Capivara
	elif jogador_atual == "Capivara":
		id_dialogo = ["manifestante-capivara"]
		dialogo_index = 0
		
	# 3. Se for o Gado
	elif jogador_atual == "Gado":
		id_dialogo = ["manifestante-gado"]
		dialogo_index = 0
		
	# 4. Se for o Pato (pode fazer a manifestação)
	elif jogador_atual == "Pato":
		id_dialogo = ["fazer-manifestação"]
		dialogo_index = 0

	# Chama a função gerar_dialogo do NPCBase para criar a caixa de diálogo
	super.gerar_dialogo()
