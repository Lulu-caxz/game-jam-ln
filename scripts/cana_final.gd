extends Node

@onready var capi_acoes = $CapiAcoes/texto
@onready var pato_acoes = $PatoAcoes/texto
@onready var gado_acoes = $GadoAcoes/texto

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for text in Global.acoesJogadores["Capivara"]:
		capi_acoes.text += text + "\n \n"
	for text in Global.acoesJogadores["Pato"]:
		pato_acoes.text += text + "\n \n"
	for text in Global.acoesJogadores["Gado"]:
		gado_acoes.text += text + "\n \n"
	
	
	pass # Replace with function body.
