
extends NPCBase

func _ready() -> void:
	super._ready()
	id_dialogo = "pombo-correio"


func _ao_realizar_escolha(resultado: int) -> void:
	# 2 = escolheu "Hoje não".
	if resultado != 1:
		return

	var jogador: String = Global.sequencia_players[Global.atual]

	# Se já possui o equipamento, não compra novamente.
	if tem_equipamento(jogador):
		Global.resultadoPomboTexto = "Você já pegou seu equipamento, meu chapa! PRRUUU"
		return

	# Verifica se o personagem tem dinheiro.
	if not tem_dinheiro(jogador):
		Global.resultadoPomboTexto = "Sem dinheiro, sem equipamento, meu chapa! PRRUUU"
		return

	# Cobra o dinheiro e entrega o equipamento.
	gastar_dinheiro(jogador)
	entregar_equipamento(jogador)

	Global.resultadoPomboTexto = "Toma aqui, bom corre pra ti. PRRUUUU"


func tem_dinheiro(jogador: String) -> bool:
	match jogador:
		"Capivara":
			return Global.dinheiroCapivara
		"Pato":
			return Global.dinheiroPato
		"Gado":
			return Global.dinheiroGado

	return false


func gastar_dinheiro(jogador: String) -> void:
	match jogador:
		"Capivara":
			Global.dinheiroCapivara = false
		"Pato":
			Global.dinheiroPato = false
		"Gado":
			Global.dinheiroGado = false


func tem_equipamento(jogador: String) -> bool:
	match jogador:
		"Capivara":
			return Global.capivaraTemEquipamentoPraFugir
		"Pato":
			return Global.patoTemEquipamentoPraFugir
		"Gado":
			return Global.gadoTemEquipamentoPraFugir

	return false


func entregar_equipamento(jogador: String) -> void:
	match jogador:
		"Capivara":
			Global.capivaraTemEquipamentoPraFugir = true
		"Pato":
			Global.patoTemEquipamentoPraFugir = true
		"Gado":
			Global.gadoTemEquipamentoPraFugir = true
