class_name PortaBase
extends Area2D

@export_file("*.tscn") var cena_destino: String
@export var posicaoSaida: Vector2
@export_enum("cima", "baixo", "direita", "esquerda") var direcao: String = "cima"


@onready var botao: Sprite2D = $Sprite2D

var onArea: bool = false

func _ready() -> void:
	if botao:
		botao.visible = false
		
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") or body.name == "Player":
		if botao:
			botao.visible = true
			print("entrou")
			
		else:
			print("n tem botao")
		onArea = true

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player") or body.name == "Player":
		if botao:
			botao.visible = false
		onArea = false

func _input(event: InputEvent) -> void:
	if onArea and event.is_action_pressed("e"):
		if cena_destino != "":
			
			if cena_destino == "uid://frraw5xikhqc":
				
				var jogador: String = Global.sequencia_players[Global.atual]
				
				match jogador:
					"Capivara":
						if Global.capivaraForagido:
							Global.presos.append(jogador)
							Global.capivaraForagido = false
							Global.capivaraVezesPreso += 1
							Transicao.mudar_cena("res://scenes/locais/policia_interior.tscn")
							body_entered.disconnect(_on_body_entered)
							body_exited.disconnect(_on_body_exited)
							Global.acoesJogadores[jogador].append("Foi preso.")
							return
					"Pato":
						if Global.patoForagido:
							Global.presos.append(jogador)
							Global.patoForagido = false
							Global.patoVezesPreso += 1
							Transicao.mudar_cena("res://scenes/locais/policia_interior.tscn")
							body_entered.disconnect(_on_body_entered)
							body_exited.disconnect(_on_body_exited)
							Global.acoesJogadores[jogador].append("Foi preso.")
							return
					"Gado":
						if Global.gadoForagido:
							Global.presos.append(jogador)
							Global.gadoForagido = false
							Global.gadoVezesPreso += 1
							Transicao.mudar_cena("res://scenes/locais/policia_interior.tscn")
							body_entered.disconnect(_on_body_entered)
							body_exited.disconnect(_on_body_exited)
							Global.acoesJogadores[jogador].append("Foi preso.")
							return
			
			onArea = false
			get_viewport().set_input_as_handled()
			
			Global.posicao_player = posicaoSaida
			Global.definir_posicao = true
			
			Global.ultimaDirecao = direcao     
			
			Transicao.mudar_cena(cena_destino)
			
			body_entered.disconnect(_on_body_entered)
			body_exited.disconnect(_on_body_exited)
		else:
			print("Erro: Nenhuma cena de destino foi definida para esta porta!")
