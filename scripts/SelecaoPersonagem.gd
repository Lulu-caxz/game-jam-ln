extends Control

@onready var capivara = $Capivara
@onready var gado = $Gado
@onready var pato = $Pato

@onready var hover: AudioStreamPlayer = $Hover
@onready var select: AudioStreamPlayer = $Select

var personagem_atual: Control = null

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("mbl") and personagem_atual != null:
		get_viewport().set_input_as_handled()
		if personagem_atual == capivara:
			Global.atual = 0
		if personagem_atual == gado:
			Global.atual = 2
		if personagem_atual == pato:
			Global.atual = 1
		
		select.play()
		if Global.sequencia_players[Global.atual] in Global.presos:
			Transicao.mudar_cena("res://scenes/locais/policia_interior.tscn")
		elif Global.sequencia_players[Global.atual] == "Capivara":
			Transicao.mudar_cena("res://scenes/locais/banco_interior.tscn")
			
		elif  Global.sequencia_players[Global.atual] == "Pato":
			Transicao.mudar_cena("res://scenes/cidade.tscn")
		else:
			Transicao.mudar_cena("res://scenes/cidade.tscn")
		

func _ready() -> void:
	for personagem in [capivara, gado, pato]:
		personagem.mouse_entered.connect(
			_on_personagem_mouse_entered.bind(personagem)
		)
		personagem.mouse_exited.connect(
			_on_personagem_mouse_exited.bind(personagem)
		)

	aplicar_bloqueios()
	atualizar_selecao()

func _on_personagem_mouse_entered(personagem: Control) -> void:
	if personagem.bloqueado:
		return

	personagem_atual = personagem
	hover.play()
	atualizar_selecao()

func _on_personagem_mouse_exited(personagem: Control) -> void:
	if personagem_atual == personagem:
		personagem_atual = null
		atualizar_selecao()

func atualizar_selecao() -> void:
	for personagem in [capivara, gado, pato]:
		personagem.definir_selecionado(
			personagem == personagem_atual
		)

func aplicar_bloqueios() -> void:
	var personagens = {
		"Capivara": capivara,
		"Gado": gado,
		"Pato": pato
	}

	for id in personagens:
		var personagem = personagens[id]
		if Global.esta_bloqueado(id):
			personagem.bloquear()
