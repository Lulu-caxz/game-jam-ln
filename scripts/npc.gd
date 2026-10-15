class_name NPCBase
extends RigidBody2D

@onready var cena_dialogo: PackedScene = preload("res://scenes/caixa_dialogo.tscn")

@onready var area: Area2D = $Area2D
@onready var botao: Sprite2D = $Botao

@export var id_dialogo: Array = ["teste"]
@export var dialogo_index: int = 0

var onArea = false
var dialogo_ativo = false

func _ready() -> void:
	botao.visible = false

	area.body_entered.connect(_on_area_2d_body_entered)
	area.body_exited.connect(_on_area_2d_body_exited)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if !body.is_in_group("player"):
		return
	if not dialogo_ativo:
		botao.visible = true
	onArea = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if !body.is_in_group("player"):
		return
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
		instancia.idDialogo = id_dialogo[dialogo_index]
		
		if id_dialogo.size() > dialogo_index + 1:
			dialogo_index += 1
		
		if instancia.has_signal("escolha_realizada"):
			instancia.escolha_realizada.connect(_ao_realizar_escolha)
		
		camada_tela.add_child(instancia)
		
		instancia.tree_exited.connect(func(): camada_tela.queue_free())
		instancia.tree_exited.connect(_ao_fechar_dialogo)
	else:
		dialogo_ativo = false
		if onArea:
			botao.visible = true
			

func _ao_realizar_escolha(resultado: int) -> void:
	pass

func _ao_fechar_dialogo() -> void:
	dialogo_ativo = false
	if onArea:
		botao.visible = true
