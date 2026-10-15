extends Control

@onready var bg = $BG
@onready var img = $IMG
@onready var nome: NinePatchRect = $NinePatchRect
@onready var texto_nome: Label = $NinePatchRect/Label

var shader_bloqueio: ShaderMaterial

var mouse_sobre: bool = false

var bloqueado: bool = false
var selecionado: bool = false

var morreu: bool = false
var fugiu: bool = false

var nomeTexto: String = str(name)


func _ready() -> void:
	shader_bloqueio = ShaderMaterial.new()
	shader_bloqueio.shader = preload("res://shaders/bloqueado.gdshader")
	atualizar_visual()


func atualizar_visual() -> void:
	if morreu:
		bg.modulate = Color(0.45, 0.05, 0.05, 1.0)
		img.material = shader_bloqueio
		shader_bloqueio.set_shader_parameter(
			"cor_bloqueio",
			Color(0.195, 0.0, 0.0, 1.0)
		)
		img.scale = Vector2.ONE
		nome.hide()
		texto_nome.text = "Morto"

	elif fugiu:
		bg.modulate = Color(0.02, 0.04, 0.25, 1.0)
		img.material = shader_bloqueio
		shader_bloqueio.set_shader_parameter(
			"cor_bloqueio",
			Color(0.01, 0.02, 0.12, 1.0)
		)
		img.scale = Vector2.ONE
		nome.hide()
		texto_nome.text = "Fugiu"

	elif bloqueado:
		bg.modulate = Color(0.2, 0.2, 0.2, 1.0)
		img.material = null
		img.modulate = Color.BLACK
		img.scale = Vector2.ONE
		nome.hide()

	elif selecionado:
		bg.modulate = Color.WHITE
		img.material = null
		img.modulate = Color.WHITE
		img.scale = Vector2(1.1, 1.1)
		nome.show()

	else:
		var cor_escura = Color(0.35, 0.35, 0.35, 1.0)
		bg.modulate = cor_escura
		img.material = null
		img.modulate = cor_escura
		img.scale = Vector2.ONE
		nome.hide()

	if morreu or fugiu:
		if mouse_sobre:
			nome.show()
		else:
			nome.hide()


func definir_selecionado(valor: bool) -> void:
	if bloqueado:
		return

	selecionado = valor
	atualizar_visual()


func bloquear() -> void:
	bloqueado = true
	selecionado = false
	mouse_filter = Control.MOUSE_FILTER_STOP
	atualizar_visual()


func desbloquear() -> void:
	bloqueado = false
	morreu = false
	fugiu = false
	mouse_filter = Control.MOUSE_FILTER_STOP
	atualizar_visual()
