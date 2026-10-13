class_name NPCBase
extends RigidBody2D

@onready var cena_dialogo: PackedScene = preload("res://scenes/caixa_dialogo.tscn")

@onready var area: Area2D = $Area2D
@export var botao: Sprite2D

@export var id_dialogo: String = "teste"

var onArea = false
var dialogo_ativo = false

func _ready() -> void:
	botao.visible = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if not dialogo_ativo:
		botao.visible = true
	onArea = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	botao.visible = false
	onArea = false

func _input(event: InputEvent) -> void:
	if onArea and event.is_action_pressed("e") and not dialogo_ativo:
		dialogo_ativo = true
		botao.visible = false 
		call_deferred("gerar_dialogo")

func gerar_dialogo() -> void:
	if cena_dialogo:
		var camada_tela = CanvasLayer.new()
		get_tree().current_scene.add_child(camada_tela)
		
		var instancia = cena_dialogo.instantiate()
		instancia.idDialogo = id_dialogo
		camada_tela.add_child(instancia)
		
		instancia.tree_exited.connect(func(): camada_tela.queue_free())
		instancia.tree_exited.connect(_ao_fechar_dialogo)
	else:
		dialogo_ativo = false
		if onArea:
			botao.visible = true

func _ao_fechar_dialogo() -> void:
	dialogo_ativo = false
	if onArea:
		botao.visible = true
