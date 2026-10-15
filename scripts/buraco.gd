extends NPCBase

var viajando: bool = false


func _ready() -> void:
	super._ready()
	atualizar_id_dialogo()


func atualizar_id_dialogo() -> void:
	if jogador_tem_equipamento():
		id_dialogo = ["Buraco-desbloqueado"]
	else:
		id_dialogo = ["Buraco-bloqueado"]


func gerar_dialogo() -> void:
	if viajando:
		return

	atualizar_id_dialogo()
	super.gerar_dialogo()
	
	if jogador_tem_equipamento():
		viajando = true
		agendar_viagem_apos_dialogo()


func jogador_tem_equipamento() -> bool:
	var jogador: String = Global.sequencia_players[Global.atual].to_lower()
	var nome_propriedade: String = jogador + "TemEquipamentoPraFugir"
	
	return Global.get(nome_propriedade) == true


func agendar_viagem_apos_dialogo() -> void:
	await get_tree().process_frame
	
	while Global.dialogo_ativo:
		await get_tree().process_frame
	
	viajar_para_cidade()


func viajar_para_cidade() -> void:
	Global.posicao_player = Vector2(340, -330)
	Global.definir_posicao = true
	Global.ultimaDirecao = "baixo"
	
	var jogador: String = Global.sequencia_players[Global.atual]
	
	match jogador:
		"Capivara":
			Global.capivaraVezesPreso += 1
			Global.capivaraForagido = true
		"Pato":
			Global.patoVezesPreso += 1
			Global.patoForagido = true
		"Gado":
			Global.gadoVezesPreso += 1
			Global.gadoForagido = true
	
	Transicao.mudar_cena("res://scenes/cidade.tscn")
