extends Control

signal escolha_realizada(resultado: int)

@onready var Player: Sprite2D = $NinePatchRect/Player
@onready var Npc: Sprite2D = $NinePatchRect/Npc
@onready var caixa: NinePatchRect = $NinePatchRect
@onready var PlayerName: Label = $NinePatchRect/CaixaPlayerName/PlayerName
@onready var NpcName: Label = $NinePatchRect/CaixaNpcName/NpcName
@onready var caixaNpcName: NinePatchRect = $NinePatchRect/CaixaNpcName
@onready var caixaPlayerName: NinePatchRect = $NinePatchRect/CaixaPlayerName

@onready var Texto: RichTextLabel = $NinePatchRect/Texto
@onready var som: AudioStreamPlayer = $Typing

@onready var escolha1: NinePatchRect = $NinePatchRect/Escolha1
@onready var escolha2: NinePatchRect = $NinePatchRect/Escolha2

@onready var textoEscolha1: Label = $NinePatchRect/Escolha1/texto
@onready var textoEscolha2: Label = $NinePatchRect/Escolha2/texto

@onready var Sair: Sprite2D = $NinePatchRect/Sair

var idDialogo = "teste"

const velocidade_texto = 0.04

var texto_completo: bool = false
var dialogo = []
var exibindo_texto: bool = false
var i_fala = 0

var nomeNpc = ""
var iNpc: int
var iPlayer: int

var escolhas_visiveis: bool = false
var resultado_escolha: int = 0
var escolha_selecionada: int = 0

var cor_normal = Color(1, 1, 1)
var cor_hover = Color(1.3, 1.3, 1.3)


func _ready() -> void:
	escolha1.hide()
	escolha2.hide()

	escolha1.mouse_entered.connect(_on_escolha1_mouse_entered)
	escolha1.mouse_exited.connect(_on_escolha1_mouse_exited)

	escolha2.mouse_entered.connect(_on_escolha2_mouse_entered)
	escolha2.mouse_exited.connect(_on_escolha2_mouse_exited)

	escolha1.gui_input.connect(_on_escolha1_input)
	escolha2.gui_input.connect(_on_escolha2_input)

	textoEscolha1.mouse_filter = Control.MOUSE_FILTER_IGNORE
	textoEscolha2.mouse_filter = Control.MOUSE_FILTER_IGNORE

	Global.dialogo_ativo = true
	carregar_dialogo(idDialogo)


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
		dialogo = Dialogos.pegar_dialogo(nome_dialogo)
		i_fala = 0
		nomeNpc = ""

		for fala in dialogo:
			if fala.has("quem") and fala["quem"][0] == "Npc":
				nomeNpc = fala["quem"][1]
				break

		pegar_indice()
		mostrar_texto()
	else:
		encerrar_dialogo()


func mostrar_texto() -> void:
	if i_fala < 0 or i_fala >= dialogo.size():
		encerrar_dialogo()
		return

	var dialogo_data = dialogo[i_fala]

	escolha1.hide()
	escolha2.hide()
	escolhas_visiveis = false
	escolha_selecionada = 0
	atualizar_hover()

	# Restaura os elementos visuais antes de cada fala.
	Player.show()
	Npc.show()
	PlayerName.show()
	NpcName.show()
	caixaPlayerName.show()
	caixaNpcName.show()

	if dialogo_data.get("tipo", "fala") == "escolha":
		mostrar_escolhas(dialogo_data)
		return

	var quem_dialogo = ""
	var quem_nome = ""
	var texto_dialogo = dialogo_data.get("texto", "")

	if dialogo_data.has("quem"):
		quem_dialogo = dialogo_data["quem"][0]
		quem_nome = dialogo_data["quem"][1]

	if dialogo_data.get("resultado_aposta", false):
		texto_dialogo = Global.resultadoTigrinhoTexto

	if dialogo_data.get("resultado_compra_pombo", false):
		texto_dialogo = Global.resultadoPomboTexto

	if dialogo_data.get("resultado_cobra_dora", false):
		texto_dialogo = Global.resultadoCobraDoraTexto
	
	if dialogo_data.get("resultado_banco", false):
		texto_dialogo = Global.resultadoBancoTexto

	Texto.text = texto_dialogo
	Texto.visible_characters = 0

	exibindo_texto = true
	texto_completo = false

	if quem_dialogo == "Player" or quem_dialogo == "Npc":
		atualizar_interface(quem_dialogo, quem_nome)
	else:
		Player.hide()
		Npc.hide()
		PlayerName.hide()
		NpcName.hide()
		caixaPlayerName.hide()
		caixaNpcName.hide()

	mostrar_letras()


func mostrar_letras() -> void:
	Texto.visible_characters = 0

	while Texto.visible_characters < Texto.get_total_character_count():
		if not exibindo_texto:
			som.playing = false
			return

		Texto.visible_characters += 1
		som.playing = true

		await get_tree().create_timer(velocidade_texto).timeout

	som.playing = false
	exibindo_texto = false
	texto_completo = true


func mostrar_escolhas(dados: Dictionary) -> void:
	var opcoes = dados["opcoes"]

	Texto.text = dados.get("texto", "Escolha uma opção:")
	Texto.visible_characters = -1

	textoEscolha1.text = opcoes[0]["texto"]
	textoEscolha2.text = opcoes[1]["texto"]

	escolha1.modulate = cor_normal
	escolha2.modulate = cor_normal

	escolha1.show()
	escolha2.show()

	Player.hide()
	Npc.hide()
	PlayerName.hide()
	NpcName.hide()
	caixaPlayerName.hide()
	caixaNpcName.hide()

	escolhas_visiveis = true
	exibindo_texto = false
	texto_completo = true


func atualizar_interface(quem: String, Nome: String) -> void:
	var jogador_atual = Global.sequencia_players[Global.atual]

	if iPlayer != -1 and Global.textures_dialogo[iPlayer].has(jogador_atual):
		Player.texture = load(Global.textures_dialogo[iPlayer][jogador_atual])

		if Player.texture:
			Player.offset.x = 0
			Player.offset.y = -Player.texture.get_height() / 2.0

	if iNpc != -1 and Global.textures_dialogo[iNpc].has(nomeNpc):
		Npc.texture = load(Global.textures_dialogo[iNpc][nomeNpc])

		if Npc.texture:
			Npc.offset.x = 0
			Npc.offset.y = -Npc.texture.get_height() / 2.0

	if quem == "Player":
		PlayerName.text = Nome

		PlayerName.show()
		caixaPlayerName.show()

		NpcName.hide()
		caixaNpcName.hide()

		Player.modulate = Color(1, 1, 1)
		Npc.modulate = Color(0.4, 0.4, 0.4)

	elif quem == "Npc":
		NpcName.text = Nome

		NpcName.show()
		caixaNpcName.show()

		PlayerName.hide()
		caixaPlayerName.hide()

		Player.modulate = Color(0.4, 0.4, 0.4)
		Npc.modulate = Color(1, 1, 1)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if is_instance_valid(Sair) and Sair.visible:
				var mouse_local = Sair.to_local(get_global_mouse_position())

				if Sair.get_rect().has_point(mouse_local):
					encerrar_dialogo()
					get_viewport().set_input_as_handled()
					return

	if event.is_action_pressed("e"):
		if escolhas_visiveis:
			return

		if exibindo_texto:
			Texto.visible_characters = -1
			exibindo_texto = false
			texto_completo = true
			som.playing = false
		else:
			avancar_dialogo()


func avancar_dialogo() -> void:
	if escolhas_visiveis or exibindo_texto:
		return

	if i_fala < 0 or i_fala >= dialogo.size():
		encerrar_dialogo()
		return

	var fala_atual = dialogo[i_fala]

	if fala_atual.get("fim", false):
		encerrar_dialogo()
		return

	i_fala += 1
	mostrar_texto()


func _on_escolha1_mouse_entered() -> void:
	if not escolhas_visiveis:
		return

	escolha_selecionada = 1
	atualizar_hover()


func _on_escolha1_mouse_exited() -> void:
	if escolha_selecionada == 1:
		escolha_selecionada = 0

	atualizar_hover()


func _on_escolha2_mouse_entered() -> void:
	if not escolhas_visiveis:
		return

	escolha_selecionada = 2
	atualizar_hover()


func _on_escolha2_mouse_exited() -> void:
	if escolha_selecionada == 2:
		escolha_selecionada = 0

	atualizar_hover()


func atualizar_hover() -> void:
	escolha1.modulate = cor_normal
	escolha2.modulate = cor_normal

	if escolha_selecionada == 1:
		escolha1.modulate = cor_hover
	elif escolha_selecionada == 2:
		escolha2.modulate = cor_hover


func _on_escolha1_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			selecionar_escolha(0)


func _on_escolha2_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			selecionar_escolha(1)


func selecionar_escolha(indice: int) -> void:
	if not escolhas_visiveis:
		return

	var opcao = dialogo[i_fala]["opcoes"][indice]

	escolhas_visiveis = false
	escolha_selecionada = 0

	escolha1.hide()
	escolha2.hide()

	resultado_escolha = indice + 1
	escolha_realizada.emit(resultado_escolha)

	i_fala = int(opcao["proxima_fala"])
	mostrar_texto()


func encerrar_dialogo() -> void:
	Global.dialogo_ativo = false
	som.playing = false
	queue_free()
