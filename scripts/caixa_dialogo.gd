extends Control

@onready var Player: Sprite2D = $NinePatchRect/Player
@onready var Npc: Sprite2D = $NinePatchRect/Npc
@onready var caixa: NinePatchRect = $NinePatchRect
@onready var PlayerName: Label = $NinePatchRect/CaixaPlayerName/PlayerName
@onready var NpcName: Label = $NinePatchRect/CaixaNpcName/NpcName
@onready var Texto: RichTextLabel = $NinePatchRect/Texto

const velocidade_texto = 0.03
var texto_completo: bool = false

var dialogo = []
var exibindo_texto: bool = false
var i_fala = 0

var nomeNpc = ""
var iNpc: int
var iPlayer: int


func _ready() -> void:
	carregar_dialogo("teste")

func pegar_indice() -> void:
	iNpc = -1
	iPlayer = -1
	
	var jogador_atual = Global.sequencia_players[Global.atual]
	
	for i in range(Global.textures_dialogo.size()):
		var dict_atual = Global.textures_dialogo[i]
		
		if dict_atual.has(nomeNpc):
			iNpc = i
			
		if dict_atual.has(jogador_atual):
			iPlayer = i


func carregar_dialogo(nome_dialogo: String) -> void:
	if Dialogos.DIALOGOS.has(nome_dialogo):
		dialogo = Dialogos.DIALOGOS[nome_dialogo].duplicate()
		i_fala = 0
		
		if nomeNpc == "":
			for i in range(dialogo.size()):
				if dialogo[i]["quem"][0] == "Npc":
					nomeNpc = dialogo[i]["quem"][1]
		pegar_indice()
		mostrar_texto()
	else:
		print("n tem esse dialogo n")
		queue_free()


func mostrar_texto() -> void:
	var dialogo_data = dialogo[i_fala]
	var quem_dialogo = dialogo_data["quem"][0]
	var quem_nome = dialogo_data["quem"][1]
	var texto_dialogo = dialogo_data["texto"]
	
	Texto.text = texto_dialogo
	Texto.visible_characters = 0
	exibindo_texto = true
	texto_completo = false
	
	atualizar_interface(quem_dialogo, quem_nome)
	mostrar_letras()

func mostrar_letras() -> void:
	Texto.visible_characters = 0
	
	
	while Texto.visible_characters < Texto.get_total_character_count() and Texto.visible_characters != -1:
		Texto.visible_characters += 1
		await get_tree().create_timer(velocidade_texto).timeout


	exibindo_texto = false
	texto_completo = true

func atualizar_interface(quem: String, Nome) -> void:
	var jogador_atual = Global.sequencia_players[Global.atual]
	
	# 1. Carrega a textura do Player e ajusta a origem para o centro inferior
	if iPlayer != -1 and Global.textures_dialogo[iPlayer].has(jogador_atual):
		Player.texture = load(Global.textures_dialogo[iPlayer][jogador_atual])
		if Player.texture:
			Player.offset.x = 0
			Player.offset.y = (-Player.texture.get_height() / 2.0)
	
	# 2. Carrega a textura do Npc e ajusta a origem para o centro inferior
	if iNpc != -1 and Global.textures_dialogo[iNpc].has(nomeNpc):
		Npc.texture = load(Global.textures_dialogo[iNpc][nomeNpc])
		if Npc.texture:
			Npc.offset.x = 0
			Npc.offset.y = (-Npc.texture.get_height() / 2.0)

	if quem == "Player":
		PlayerName.visible = true
		NpcName.visible = false
		
		Player.modulate = Color(1, 1, 1)
		Npc.modulate = Color(0.4, 0.4, 0.4)
		
		PlayerName.text = Nome
	else:
		PlayerName.visible = false
		NpcName.visible = true
		
		Player.modulate = Color(0.4, 0.4, 0.4)
		Npc.modulate = Color(1, 1, 1)
		
		NpcName.text = Nome



func _input(event: InputEvent) -> void:
	if event.is_action_pressed("e"):
		if exibindo_texto:
			Texto.visible_characters = -1
			exibindo_texto = false
		else:
			avancar_dialogo()



func avancar_dialogo():
	i_fala += 1
	if i_fala < dialogo.size():
		mostrar_texto()
	else:
		queue_free()
