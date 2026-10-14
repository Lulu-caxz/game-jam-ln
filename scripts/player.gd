extends CharacterBody2D

@onready var camera: Camera2D = $Camera2D
@onready var somPassoPiso: AudioStreamPlayer = $PassoPiso
@onready var somQuack: AudioStreamPlayer = $Quack

@onready var dinheiroHUD: Sprite2D = get_tree().current_scene.get_node("HUD/Dinheiro")

const VELOCIDADE = 80.0
const INTERVALO_PASSO = 0.35

var passo_timer: float = 0.0

# Temporizadores para o Quack aleatório
var quack_timer: float = 0.0
var tempo_proximo_quack: float = 0.0

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
	
	# Quando muda de personagem para o Pato, gera o primeiro tempo aleatório
	if Global.sequencia_players[Global.atual] == "Pato":
		quack_timer = 0.0
		tempo_proximo_quack = randf_range(10.0, 30.0)

func _enter_tree() -> void:
	if Global.definir_posicao:
		global_position = Global.posicao_player
		Global.definir_posicao = false

func _ready() -> void:
	player_atual = Global.sequencia_players[Global.atual]
	ultima_direcao_nome = Global.ultimaDirecao
	
	dinheiroHUD.position = Vector2(15, 15)
	
	dinheiroHUD.modulate.a = 0.2
	mudarAnimacao()

func _physics_process(delta: float) -> void:
	
	if not Global.dialogo_ativo and Global.sequencia_players[Global.atual] == "Pato":
		quack_timer += delta
		if quack_timer >= tempo_proximo_quack:
			somQuack.play()
			quack_timer = 0.0
			tempo_proximo_quack = randf_range(10.0, 30.0)
	
	if Global.dialogo_ativo:
		velocity = Vector2.ZERO
		animacao.play(ultima_direcao_nome + "_idle")
		passo_timer = 0.0
		return 
	
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if input_dir != Vector2.ZERO:
		var dir_chave := input_dir.round()
		
		if dir_chave in ANIMACOES_DIRECAO:
			ultima_direcao_nome = ANIMACOES_DIRECAO[dir_chave]
		
		animacao.play(ultima_direcao_nome + "_move")
		velocity = input_dir * VELOCIDADE
		
		passo_timer += delta
		if passo_timer >= INTERVALO_PASSO and Global.dialogo_ativo == false:
			somPassoPiso.play()
			passo_timer = 0.0
	else:
		animacao.play(ultima_direcao_nome + "_idle")
		velocity = Vector2.ZERO
		passo_timer = INTERVALO_PASSO 
		somPassoPiso.stop()
	
	atualizar_HUD()
	move_and_slide()


func atualizar_HUD():
	match player_atual:
		"Capivara":
			if Global.dinheiroCapivara:
				dinheiroHUD.modulate.a = 1
			else:
				dinheiroHUD.modulate.a = 0.2
		"Pato":
			if Global.dinheiroPato:
				dinheiroHUD.modulate.a = 1
			else:
				dinheiroHUD.modulate.a = 0.2
		"Veado":
			if Global.dinheiroVeado:
				dinheiroHUD.modulate.a = 1
			else:
				dinheiroHUD.modulate.a = 0.2
