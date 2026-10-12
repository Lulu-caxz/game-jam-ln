class_name PortaBase
extends Area2D

@export_file("*.tscn") var cena_destino: String

@onready var botao: Sprite2D = $Botao

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
		onArea = true

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player") or body.name == "Player":
		if botao:
			botao.visible = false
		onArea = false

func _input(event: InputEvent) -> void:
	if onArea and event.is_action_pressed("e"):
		if cena_destino != "":
			get_viewport().set_input_as_handled()
			get_tree().change_scene_to_file(cena_destino)
		else:
			print("Erro: Nenhuma cena de destino foi definida para esta porta!")
