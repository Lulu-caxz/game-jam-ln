extends Control

@onready var Texto: RichTextLabel = $NinePatchRect/Texto
@onready var Sair: Sprite2D = $NinePatchRect/Sair

var id_dialogo: String = "Capivara-prisao"
var indice_fala: int = 0
var pode_fechar: bool = false # Trava para evitar fechar no mesmo frame que abriu

func _ready() -> void:
	print("Debug: CaixaTextoSimples foi instanciada e entrou em _ready()!")
	carregar_mensagem(id_dialogo, indice_fala)
	
	# Aguarda 1 frame do motor para liberar o fechamento por tecla
	await get_tree().process_frame
	pode_fechar = true

func carregar_mensagem(nome_dialogo: String, indice: int) -> void:
	if Dialogos.DIALOGOS.has(nome_dialogo):
		var falas = Dialogos.pegar_dialogo(nome_dialogo)
		
		if indice >= 0 and indice < falas.size():
			var dados_fala = falas[indice]
			var texto_encontrado = dados_fala.get("texto", "")
			Texto.text = texto_encontrado
			print("Debug: Texto definido com sucesso na caixa -> '", texto_encontrado, "'")
		else:
			Texto.text = "Índice inválido!"
	else:
		Texto.text = "Diálogo não encontrado!"

func _input(event: InputEvent) -> void:
	# Se a caixa acabou de abrir, ignora os inputs para não fechar sozinha
	if not pode_fechar:
		return

	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if is_instance_valid(Sair) and Sair.visible:
				var mouse_local = Sair.to_local(get_global_mouse_position())
				if Sair.get_rect().has_point(mouse_local):
					fechar_caixa()
					get_viewport().set_input_as_handled()
					return

	if event.is_action_pressed("e") or event.is_action_pressed("ui_accept"):
		fechar_caixa()
		get_viewport().set_input_as_handled()

func fechar_caixa() -> void:
	print("Debug: Fechando caixa de texto.")
	queue_free()
