
extends NPCBase

func _ready() -> void:
	super._ready()
	id_dialogo = "tigrinho"


func _ao_realizar_escolha(resultado: int) -> void:
	if resultado != 1:
		return

	var jogador: String = Global.sequencia_players[Global.atual]

	if tem_dinheiro(jogador):
		Global.statusApostaTigrinho = "bloqueado"
		Global.resultadoTigrinhoTexto = "Cê ja ta cheio da grana ai, sai fora."
		return

	if ja_apostou(jogador):
		Global.statusApostaTigrinho = "bloqueado"
		Global.resultadoTigrinhoTexto = "Tu já apostou! Não dá pra apostar de novo não."
		return

	marcar_aposta(jogador)
	Global.statusApostaTigrinho = "apostou"

	Global.resultadoApostaTigrinho = apostar(jogador)

	if Global.resultadoApostaTigrinho:
		Global.resultadoTigrinhoTexto = "É o Tigrinho! Te falei que eu pagava, você ganhou!"
	else:
		Global.resultadoTigrinhoTexto = "Ixi, fiote... dessa vez não foi! Você perdeu!"


func tem_dinheiro(jogador: String) -> bool:
	match jogador:
		"Capivara":
			return Global.dinheiroCapivara
		"Pato":
			return Global.dinheiroPato
		"Gado":
			return Global.dinheiroGado

	return false


func ja_apostou(jogador: String) -> bool:
	match jogador:
		"Capivara":
			return Global.capivaraJaApostou
		"Pato":
			return Global.patoJaApostou
		"Gado":
			return Global.gadoJaApostou

	return false


func marcar_aposta(jogador: String) -> void:
	match jogador:
		"Capivara":
			Global.capivaraJaApostou = true
		"Pato":
			Global.patoJaApostou = true
		"Gado":
			Global.gadoJaApostou = true


func apostar(jogador: String) -> bool:
	var chance = randf()

	if chance < 0.5:
		match jogador:
			"Capivara":
				Global.dinheiroCapivara = true
			"Pato":
				Global.dinheiroPato = true
			"Gado":
				Global.dinheiroGado = true

		return true

	return false
