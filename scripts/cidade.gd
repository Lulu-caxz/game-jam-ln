extends Node2D

@onready var patoNPC: RigidBody2D = $YSort/PatoNPC
@onready var player: Node2D = $YSort/Player # Ajuste o caminho até o nó do seu Player se necessário

const manifestação = preload("res://scenes/npcs/manifestação.tscn")

func _ready() -> void:
	# 1. Se salvamos uma posição antes do fade/transição, move o player para ela
	if Global.definir_posicao:
		player.global_position = Global.posicao_player
		Global.definir_posicao = false # Reseta a flag
	
	# 2. Garante que o diálogo e os controles do player estejam destravados
	Global.dialogo_ativo = false

	# 3. Trata o NPC do Pato
	if Global.sequencia_players[Global.atual] == "Pato" or "Pato" in Global.presos:
		if is_instance_valid(patoNPC):
			patoNPC.queue_free()
	
	# 4. Instancia a manifestação se ela foi realizada e move para o início da raiz
	if Global.manifestacaoRealizada:
		var manifestacaoInstancia = manifestação.instantiate()
		manifestacaoInstancia.position = Vector2(-119.0, -205.0)
		
		# Adiciona como filho da raiz
		add_child(manifestacaoInstancia)
		
		# Move o nó para o primeiro lugar (índice 0) na ordem da árvore de nós
		move_child(manifestacaoInstancia, 2)
