extends Control

@onready var capivara = $Capivara
@onready var veado = $Veado
@onready var pato = $Pato

@onready var hover: AudioStreamPlayer = $Hover
@onready var select: AudioStreamPlayer = $Select

var personagem_atual: Control = null

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("mbl") and personagem_atual != null:
		get_viewport().set_input_as_handled()
		if personagem_atual == capivara:
			Global.atual = 0
		if personagem_atual == veado:
			Global.atual = 2
		if personagem_atual == pato:
			Global.atual = 1
		
		select.play()
		get_tree().change_scene_to_file("res://scenes/cidade.tscn")
		

func _ready() -> void:
	for personagem in [capivara, veado, pato]:
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
	for personagem in [capivara, veado, pato]:
		personagem.definir_selecionado(
			personagem == personagem_atual
		)

func aplicar_bloqueios() -> void:
	var personagens = {
		"Capivara": capivara,
		"Veado": veado,
		"Pato": pato
	}

	for id in personagens:
		var personagem = personagens[id]
		if Global.esta_bloqueado(id):
			personagem.bloquear()
