extends NPCBase

func _ready() -> void:
	super._ready()

	var jogador = Global.sequencia_players[Global.atual]

	if jogador == "Gado":
		id_dialogo = ["gado-zebra"]
	else:
		id_dialogo = ["zebra"]


func _ao_realizar_escolha(resultado: int) -> void:
	if Global.sequencia_players[Global.atual] != "Gado":
		return

	if id_dialogo_atual != "gado-zebra":
		return

	if Global.gadoAcoes <= 0:
		return

	
	Global.gastar_acao("Gado")

	var alvo = ""

	match resultado:
		1:
			alvo = "Capivara"
		2:
			alvo = "Pato"

	if alvo != "":
		if not Global.presos.has(alvo):
			Global.presos.append(alvo)
