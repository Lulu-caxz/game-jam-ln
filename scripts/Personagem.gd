extends Control

@onready var bg = $BG
@onready var img = $IMG
@onready var nome: NinePatchRect = $NinePatchRect

var bloqueado: bool = false
var selecionado: bool = false

func _ready() -> void:
	atualizar_visual()

func atualizar_visual() -> void:
	if bloqueado:
		img.modulate = Color.BLACK
		img.scale = Vector2(1,1) 
		nome.hide()
	elif selecionado:
		bg.modulate = Color.WHITE
		img.modulate = Color.WHITE
		img.scale = Vector2(1.1,1.1) 
		nome.show()
	else:
		var cor_escura = Color(0.35, 0.35, 0.35, 1.0)
		bg.modulate = cor_escura
		img.modulate = cor_escura
		img.scale = Vector2(1.0,1.0) 
		nome.hide()

func definir_selecionado(valor: bool) -> void:
	if bloqueado:
		return
	selecionado = valor
	atualizar_visual()

func bloquear() -> void:
	bloqueado = true
	selecionado = false
	atualizar_visual()

func desbloquear() -> void:
	bloqueado = false
	atualizar_visual()
