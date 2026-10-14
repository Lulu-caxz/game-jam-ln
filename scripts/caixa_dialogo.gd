
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

	# Eventos de hover
	escolha1.mouse_entered.connect(_on_escolha1_mouse_entered)
	escolha1.mouse_exited.connect(_on_escolha1_mouse_exited)

	escolha2.mouse_entered.connect(_on_escolha2_mouse_entered)
	escolha2.mouse_exited.connect(_on_escolha2_mouse_exited)

	# Eventos de clique
	escolha1.gui_input.connect(_on_escolha1_input)
	escolha2.gui_input.connect(_on_escolha2_input)

	# Os textos não devem bloquear os cliques
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

		if nomeNpc == "":
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
	Player.show()
	Npc.show()
	escolhas_visiveis = false
	escolha_selecionada = 0
	atualizar_hover()

	if dialogo_data.get("tipo", "fala") == "escolha":
		mostrar_escolhas(dialogo_data)
		return

	var quem_dialogo = dialogo_data["quem"][0]
	var quem_nome = dialogo_data["quem"][1]
	var texto_dialogo = dialogo_data["texto"]
	
	if dialogo_data.get("resultado_aposta", false):
		texto_dialogo = Global.resultadoTigrinhoTexto

	Texto.text = texto_dialogo
	Texto.visible_characters = 0

	exibindo_texto = true
	texto_completo = false

	atualizar_interface(quem_dialogo, quem_nome)
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
		PlayerName.visible = true
		NpcName.visible = false
		caixaPlayerName.visible = true
		caixaNpcName.visible = false

		Player.modulate = Color(1, 1, 1)
		Npc.modulate = Color(0.4, 0.4, 0.4)

		PlayerName.text = Nome
	else:
		PlayerName.visible = false
		NpcName.visible = true
		caixaPlayerName.visible = false
		caixaNpcName.visible = true
		
		Player.modulate = Color(0.4, 0.4, 0.4)
		Npc.modulate = Color(1, 1, 1)

		NpcName.text = Nome


func _input(event: InputEvent) -> void:
	# Fechar ao clicar no Sprite2D Sair.
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if is_instance_valid(Sair) and Sair.visible:
				var mouse_local = Sair.to_local(get_global_mouse_position())

				if Sair.get_rect().has_point(mouse_local):
					encerrar_dialogo()
					get_viewport().set_input_as_handled()
					return

	# Controles normais do diálogo.
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

	var fala_atual = dialogo[i_fala]

	if fala_atual.get("fim", false):
		encerrar_dialogo()
		return

	i_fala += 1

	mostrar_texto()



# HOVER DA PRIMEIRA OPÇÃO
func _on_escolha1_mouse_entered() -> void:
	if not escolhas_visiveis:
		return

	escolha_selecionada = 1
	atualizar_hover()


func _on_escolha1_mouse_exited() -> void:
	if escolha_selecionada == 1:
		escolha_selecionada = 0

	atualizar_hover()


# HOVER DA SEGUNDA OPÇÃO
func _on_escolha2_mouse_entered() -> void:
	if not escolhas_visiveis:
		return

	escolha_selecionada = 2
	atualizar_hover()


func _on_escolha2_mouse_exited() -> void:
	if escolha_selecionada == 2:
		escolha_selecionada = 0

	atualizar_hover()


# ATUALIZA O VISUAL DAS OPÇÕES
func atualizar_hover() -> void:
	escolha1.modulate = cor_normal
	escolha2.modulate = cor_normal

	if escolha_selecionada == 1:
		escolha1.modulate = cor_hover
	elif escolha_selecionada == 2:
		escolha2.modulate = cor_hover


# CLIQUE NA PRIMEIRA OPÇÃO
func _on_escolha1_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			selecionar_escolha(0)


# CLIQUE NA SEGUNDA OPÇÃO
func _on_escolha2_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			selecionar_escolha(1)


# RETORNA 1 OU 2 E MUDA A PRÓXIMA FALA

func selecionar_escolha(indice: int) -> void:
	if not escolhas_visiveis:
		return

	var opcao = dialogo[i_fala]["opcoes"][indice]

	escolhas_visiveis = false
	escolha_selecionada = 0

	escolha1.hide()
	escolha2.hide()

	resultado_escolha = indice + 1

	# O NPC processa a escolha e atualiza o resultado global.
	escolha_realizada.emit(resultado_escolha)

	# Vai para a próxima fala definida na opção.
	i_fala = int(opcao["proxima_fala"])

	mostrar_texto()



func encerrar_dialogo() -> void:
	Global.dialogo_ativo = false
	som.playing = false
	queue_free()
