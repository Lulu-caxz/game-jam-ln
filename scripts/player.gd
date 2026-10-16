extends CharacterBody2D

@onready var camera: Camera2D = $Camera2D
@onready var somPassoPiso: AudioStreamPlayer = $PassoPiso
@onready var somQuack: AudioStreamPlayer = $Quack

@onready var poeira: GPUParticles2D = $GPUParticles2D

@onready var dinheiroHUD: Sprite2D = get_tree().current_scene.get_node("HUD/Dinheiro")
@onready var paHUD: Sprite2D = get_tree().current_scene.get_node_or_null("HUD/Pa")
@onready var acoesHUD: Label = get_tree().current_scene.get_node_or_null("HUD/Acoes/Label")
@onready var caixaAcoesHUD: NinePatchRect = get_tree().current_scene.get_node_or_null("HUD/Acoes")

@onready var botaoE: Sprite2D = $Botao
@onready var foragidoHUD: Sprite2D = get_tree().current_scene.get_node_or_null("HUD/Foragido")

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
	
	if Global.sequencia_players[Global.atual] == "Pato":
		quack_timer = 0.0
		tempo_proximo_quack = randf_range(10.0, 30.0)

func _enter_tree() -> void:
	if Global.definir_posicao:
		global_position = Global.posicao_player
		Global.definir_posicao = false

var timer := Timer.new()

func _ready() -> void:
	player_atual = Global.sequencia_players[Global.atual]
	ultima_direcao_nome = Global.ultimaDirecao
	
	dinheiroHUD.position = Vector2(15, 15)
	caixaAcoesHUD.position = Vector2(325, 10)
	if paHUD != null:
		paHUD.position = Vector2(45, 15)
		paHUD.modulate.a = 0.2
	
	if foragidoHUD != null:
		foragidoHUD.position = Vector2(15, 45)
		foragidoHUD.modulate.a = 0.2
	
	
	poeira.emitting = false
	
	dinheiroHUD.modulate.a = 0.2
	mudarAnimacao()
	
	# Cria um timer
	timer.wait_time = 0.5
	timer.one_shot = true 
	add_child(timer) 
	timer.timeout.connect(pode_clicar)
	
	botaoE.visible = false

var taAndando = false
var podeClicar = true

func _physics_process(delta: float) -> void:
	
	print(Global.manifestacaoRealizada)
	
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
		poeira.emitting = false
		somPassoPiso.stop()
		return
	
	var input_dir = Vector2.ZERO
	if !Global.sendoPersiguido:
		botaoE.visible = false
	elif Global.sendoPersiguido and podeClicar and get_tree().current_scene.name == "Jogo":
		botaoE.visible = true
	if !Global.sendoPersiguido:
		input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	elif (Input.is_action_just_pressed("e") and podeClicar and get_tree().current_scene.name == "Jogo") or taAndando:
		input_dir = Vector2(0, 1)
		taAndando = true
		podeClicar = false
		botaoE.visible = false
		parar_andar()
		
		timer.start() # Inicia o timer
	elif Input.is_action_just_pressed("e") and !podeClicar:
		timer.start() # Reinicia o timer
	
	if taAndando and get_tree().current_scene.name == "Jogo" and position.y > 125 and Global.sendoPersiguido:
		Global.ultimaDirecao = "baixo"
		Global.sendoPersiguido = false
		
		await Transicao.mudar_cena("res://scenes/cidade.tscn")
	
	if input_dir != Vector2.ZERO:
		var dir_chave := input_dir.round()

		if dir_chave in ANIMACOES_DIRECAO:
			ultima_direcao_nome = ANIMACOES_DIRECAO[dir_chave]

		velocity = input_dir * VELOCIDADE
		move_and_slide()

		var velocidade_real = get_real_velocity()
		var movimento_na_direcao = velocidade_real.dot(input_dir.normalized())

		if movimento_na_direcao > 5.0:
			animacao.play(ultima_direcao_nome + "_move")
			poeira.emitting = true

			passo_timer += delta

			if passo_timer >= INTERVALO_PASSO:
				if not somPassoPiso.playing:
					somPassoPiso.play()
				passo_timer = 0.0
		else:
			animacao.play(ultima_direcao_nome + "_idle")
			poeira.emitting = false
			passo_timer = 0.0
			somPassoPiso.stop()
	else:
		velocity = Vector2.ZERO
		animacao.play(ultima_direcao_nome + "_idle")
		passo_timer = INTERVALO_PASSO
		somPassoPiso.stop()
		poeira.emitting = false
		move_and_slide()
	
	atualizar_HUD()
	verificarNumeroAcoes()

func parar_andar():
	await get_tree().create_timer(0.2).timeout
	taAndando = false
func pode_clicar():
	podeClicar = true
	botaoE.visible = true

func atualizar_HUD():
	player_atual = Global.sequencia_players[Global.atual]
	
	var tem_pa: bool = false
	var tem_dinheiro: bool = false
	var esta_foragido: bool = false
	var acoes: String
	
	match player_atual:
		"Capivara":
			tem_pa = Global.capivaraTemEquipamentoPraFugir
			tem_dinheiro = Global.dinheiroCapivara
			esta_foragido = Global.capivaraForagido
			acoes = str(Global.capivaraAcoes)
		"Pato":
			tem_pa = Global.patoTemEquipamentoPraFugir
			tem_dinheiro = Global.dinheiroPato
			esta_foragido = Global.patoForagido
			acoes = str(Global.patoAcoes)
		"Gado":
			tem_pa = Global.gadoTemEquipamentoPraFugir
			tem_dinheiro = Global.dinheiroGado
			esta_foragido = Global.gadoForagido
			acoes = str(Global.gadoAcoes)

	if paHUD != null:
		paHUD.modulate.a = 1.0 if tem_pa else 0.2
		
	if dinheiroHUD != null:
		dinheiroHUD.modulate.a = 1.0 if tem_dinheiro else 0.2
	
	if foragidoHUD != null:
		foragidoHUD.modulate.a = 1.0 if esta_foragido else 0.2
	
	acoesHUD.text = "Ações: " + acoes


func verificarNumeroAcoes():
	var jogador = Global.sequencia_players[Global.atual]
	
	match jogador:
		"Capivara":
			if Global.capivaraAcoes == 0:
				Transicao.mudar_cena("res://scenes/selecao_personagem.tscn")
		"Pato":
			if Global.patoAcoes == 0:
				Transicao.mudar_cena("res://scenes/selecao_personagem.tscn")
		"Gado":
			if Global.gadoAcoes == 0:
				Transicao.mudar_cena("res://scenes/selecao_personagem.tscn")
