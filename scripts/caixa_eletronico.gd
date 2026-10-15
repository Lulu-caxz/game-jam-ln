extends NPCBase


func _ready() -> void:
	super._ready()

	match Global.sequencia_players[Global.atual]:
		"Capivara":
			if Global.capivaraJaPegouDinheiroNoBanco:
				id_dialogo = ["banco-sem-dinheiro-capivara"]
			elif Global.bancoRoubado:
				id_dialogo = ["banco-roubado"]
			else:
				id_dialogo = ["banco-capivara"]

		"Pato", "Gado":
			if Global.bancoRoubado:
				id_dialogo = ["banco-roubado"]
			else:
				id_dialogo = ["banco-sem-dinheiro"]


func _ao_realizar_escolha(resultado: int) -> void:
	if id_dialogo != ["banco-capivara"]:
		return

	# Opção 2: desistir do saque.
	if resultado == 2:
		Global.resultadoBancoTexto = "Você decidiu não sacar dinheiro."
		return

	# Opção 1: sacar dinheiro.
	if resultado != 1:
		return

	if Global.bancoRoubado:
		Global.resultadoBancoTexto = "O banco foi roubado! Não há dinheiro para sacar."
		return

	if Global.capivaraJaPegouDinheiroNoBanco:
		Global.resultadoBancoTexto = "Você já sacou seu dinheiro!"
		return

	if Global.capivaraAcoes <= 0:
		Global.resultadoBancoTexto = "Você não tem ações suficientes para sacar."
		return

	Global.gastar_acao("Capivara")
	Global.dinheiroCapivara = true
	Global.capivaraJaPegouDinheiroNoBanco = true

	Global.resultadoBancoTexto = "Saque realizado! (Você recebeu seu dinheiro e gastou 1 ação)"
