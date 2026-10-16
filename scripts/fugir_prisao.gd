extends NPCBase

var viajando: bool = false


func _ready() -> void:
	super._ready()
	id_dialogo = ["fugir-prisao"]



func gerar_dialogo() -> void:
	if viajando or Global.sendoPersiguido:
		return
	
	super.gerar_dialogo()


func _ao_realizar_escolha(resultado: int) -> void:
	if resultado != 1 or Global.sendoPersiguido:
		return
	var jogador: String = Global.sequencia_players[Global.atual]
	Global.gastar_acao(jogador)
	viajando = true
	agendar_viagem_apos_dialogo()

func agendar_viagem_apos_dialogo() -> void:
	if Global.sendoPersiguido:
		return
	await get_tree().process_frame
	
	while Global.dialogo_ativo:
		await get_tree().process_frame
	
	viajar_para_cidade()


func viajar_para_cidade() -> void:
	if Global.sendoPersiguido:
		return
	Global.posicao_player = Vector2(135, -300)
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
			
	
	Global.sendoPersiguido = true
	Transicao.mudar_cena("res://scenes/cidade.tscn")
	
