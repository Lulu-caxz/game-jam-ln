extends NPCBase

func _ready() -> void:
	super._ready()

	var jogador: String = Global.sequencia_players[Global.atual]

	match jogador:
		"Capivara":
			id_dialogo = ["CobraDora-capivara"]
		"Pato":
			id_dialogo = ["CobraDora-pato"]
		"Gado":
			id_dialogo = ["CobraDora-gado"]


func _ao_realizar_escolha(resultado: int) -> void:
	if resultado != 1 and resultado != 2:
		return

	var jogador: String = Global.sequencia_players[Global.atual]
	var alvo: String = ""

	match jogador:
		"Capivara":
			alvo = "Pato" if resultado == 1 else "Gado"
		"Pato":
			alvo = "Capivara" if resultado == 1 else "Gado"
		"Gado":
			alvo = "Pato" if resultado == 1 else "Capivara"

	if alvo == "":
		return

	if not Global.tem_dinheiro(jogador):
		Global.resultadoCobraDoraTexto = "Você nem tem dinheiro pra me pagar"
		return

	var acoes: int = 0

	match jogador:
		"Capivara":
			acoes = Global.capivaraAcoes
		"Pato":
			acoes = Global.patoAcoes
		"Gado":
			acoes = Global.gadoAcoes

	var nome_alvo: String = alvo

	for nome in Global.Nomes:
		if nome.has(alvo):
			nome_alvo = nome[alvo]
			break
		
	if acoes <= 0:
		Global.resultadoCobraDoraTexto = "Você não tem ações suficientes!"
		return

	if Global.presos.has(alvo):
		Global.resultadoCobraDoraTexto = nome_alvo + " já está preso!"
		return
		
	if Global.mortos.has(alvo):
		Global.resultadoCobraDoraTexto = nome_alvo + " está morto!"
		return
	
	Global.gastar_dinheiro(jogador)
	Global.gastar_acao(jogador)
	Global.presos.append(alvo)
	Global.acoesJogadores[jogador].append("Pagou Cobra Dora para ferra com" + alvo + ".")

	match alvo:
		"Capivara":
			Global.capivaraForagido = false
			Global.capivaraVezesPreso += 1
		"Pato":
			Global.patoForagido = false
			Global.patoVezesPreso += 1
		"Gado":
			Global.gadoForagido = false
			Global.gadoVezesPreso += 1

	

	Global.resultadoCobraDoraTexto = "Vou botar o " + nome_alvo + " na prisão!"
