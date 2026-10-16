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
		elif  Global.sequencia_players[Global.atual] == "Gado":
			Transicao.mudar_cena("res://scenes/locais/tribunal_interior.tscn")
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
		personagem.mouse_sobre = true
		personagem.atualizar_visual()
		return

	personagem_atual = personagem
	hover.play()
	atualizar_selecao()


func _on_personagem_mouse_exited(personagem: Control) -> void:
	if personagem.bloqueado:
		personagem.mouse_sobre = false
		personagem.atualizar_visual()
		return

	if personagem_atual == personagem:
		personagem_atual = null
		atualizar_selecao()

func atualizar_selecao() -> void:
	for personagem in [capivara, gado, pato]:
		if personagem.bloqueado:
			personagem.selecionado = false
			personagem.atualizar_visual()
		else:
			personagem.definir_selecionado(
				personagem == personagem_atual
			)

func aplicar_bloqueios() -> void:
	var personagens = {
		"Capivara": capivara,
		"Pato": pato,
		"Gado": gado
	}
	
	var verify = true
	for id in personagens:
		var personagem = personagens[id]

		personagem.morreu = id in Global.mortos
		personagem.fugiu = id in Global.fugiu

		if deve_bloquear(id):
			personagem.bloquear()
		else:
			personagem.desbloquear()
			verify = false
	
	if verify:
		Transicao.mudar_cena("res://scenes/cena_final.tscn")


func deve_bloquear(id: String) -> bool:
	if Global.esta_bloqueado(id):
		return true

	match id:
		"Capivara":
			if Global.capivaraAcoes <= 0:
				return true
		"Pato":
			if Global.patoAcoes <= 0:
				return true
		"Gado":
			if Global.gadoAcoes <= 0:
				return true

	if id in Global.mortos:
		return true

	if id in Global.fugiu:
		return true

	return false
