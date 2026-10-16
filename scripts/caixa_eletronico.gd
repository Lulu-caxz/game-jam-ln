extends NPCBase


func _ready() -> void:
	super._ready()

	var jogador: String = Global.sequencia_players[Global.atual]

	if Global.bancoRoubado:
		id_dialogo = ["banco-roubado"]

	elif jogador == "Capivara":
		if Global.capivaraJaPegouDinheiroNoBanco:
			id_dialogo = ["banco-sem-dinheiro-capivara"]
		else:
			id_dialogo = ["banco-capivara"]

	elif jogador == "Pato":
		id_dialogo = ["banco-pato"]

	else:
		id_dialogo = ["banco-sem-dinheiro"]


func _ao_realizar_escolha(resultado: int) -> void:
	var jogador: String = Global.sequencia_players[Global.atual]

	# ROUBO DO PATO
	if id_dialogo == ["banco-pato"]:
		if resultado == 2:
			return

		if resultado != 1:
			return

		if Global.bancoRoubado:
			Global.resultadoBancoTexto = "O banco já foi roubado!"
			return

		Global.gastar_acao("Pato")
		Global.bancoRoubado = true
		Global.dinheiroPato = true

		Global.resultadoBancoTexto = "Você roubou o banco e conseguiu dinheiro."

	elif id_dialogo == ["banco-capivara"]:
		if resultado == 2:
			Global.resultadoBancoTexto = "Você decidiu não sacar dinheiro."
			return

		if resultado != 1:
			return

		if Global.bancoRoubado:
			Global.resultadoBancoTexto = "O banco já foi roubado!"
			return

		if Global.capivaraJaPegouDinheiroNoBanco:
			Global.resultadoBancoTexto = "Você já sacou seu dinheiro!"
			return

		if Global.capivaraAcoes <= 0:
			Global.resultadoBancoTexto = "Você não tem ações suficientes para sacar!"
			return

		Global.gastar_acao("Capivara")
		Global.dinheiroCapivara = true
		Global.capivaraJaPegouDinheiroNoBanco = true

		Global.resultadoBancoTexto = "Saque realizado! Você recebeu seu dinheiro."
