extends CharacterBody2D

const VELOCIDADE = 80.0

const ANIMACOES_DIRECAO = {
	Vector2.UP: "cima",
	Vector2.DOWN: "baixo",
	Vector2.LEFT: "esquerda",
	Vector2.RIGHT: "direita",
	Vector2(-1, -1): "esquerda",  # cima-esquerda
	Vector2(1, -1): "direita",    # cima-direita
	Vector2(-1, 1): "esquerda",   # baixo-esquerda
	Vector2(1, 1): "direita"      # baixo-direita
}

var animacao: AnimatedSprite2D
var player_atual: String
var ultima_direcao_nome: String = "baixo"

func mudarAnimacao() -> void:
	for player in Global.sequencia_players:
		var no = get_node_or_null("Animacao" + player)
		if no: no.hide()
	
	animacao = get_node("Animacao" + Global.sequencia_players[Global.atual])
	animacao.show()

func _ready() -> void:
	player_atual = Global.sequencia_players[0]
	mudarAnimacao()

func _physics_process(_delta: float) -> void:
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if input_dir != Vector2.ZERO:
		var dir_chave := input_dir.round()
		
		if dir_chave in ANIMACOES_DIRECAO:
			ultima_direcao_nome = ANIMACOES_DIRECAO[dir_chave]
		
		animacao.play(ultima_direcao_nome + "_move")
		velocity = input_dir * VELOCIDADE
	else:
		animacao.play(ultima_direcao_nome + "_idle")
		velocity = Vector2.ZERO
		
	move_and_slide()
	
	
	
	#trocar de animal
	if Input.is_action_just_pressed("1"):
		Global.atual = 0
		mudarAnimacao()
	if Input.is_action_just_pressed("2"):
		Global.atual = 1
		mudarAnimacao()
	if Input.is_action_just_pressed("3"):
		Global.atual = 2
		mudarAnimacao()
