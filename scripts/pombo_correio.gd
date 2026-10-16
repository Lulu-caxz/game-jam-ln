
extends NPCBase

func _ready() -> void:
	super._ready()
	id_dialogo = ["pombo-correio"]


func _ao_realizar_escolha(resultado: int) -> void:
	# 2 = escolheu "Hoje não".
	if resultado != 1:
		return

	var jogador: String = Global.sequencia_players[Global.atual]

	# Se já possui o equipamento, não compra novamente.
	if Global.tem_equipamento(jogador):
		Global.resultadoPomboTexto = "Você já pegou seu equipamento, meu chapa! PRRUUU"
		return

	# Verifica se o personagem tem dinheiro.
	if not Global.tem_dinheiro(jogador):
		Global.resultadoPomboTexto = "Sem dinheiro, sem equipamento, meu chapa! PRRUUU"
		return

	# Cobra o dinheiro e entrega o equipamento.
	Global.gastar_dinheiro(jogador)
	Global.entregar_equipamento(jogador)
	
	Global.acoesJogadores[jogador].append("Negociou com pombo correio.")

	Global.resultadoPomboTexto = "Toma aqui, bom corre pra ti. PRRUUUU"
