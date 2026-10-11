extends CharacterBody2D

@onready var animacao: AnimatedSprite2D = $AnimatedSprite2D 

const velocidade = 200.0

const direcoes = ["cima", "baixo", "direita", "esquerda", "cima-esquerda", "baixo-esquerda", "cima-direita", "baixo-direita"]
#	0-^  1-V  2-> 3-<  4-^<  5- V<  6-^>  7-V>
var ultima_direcao;

func _ready() -> void:
	ultima_direcao = direcoes[1]

func _physics_process(delta: float) -> void:
	var direction = Vector2.ZERO
	
	if Input.is_action_pressed("ui_up"):
		direction.y -= velocidade
		ultima_direcao = direcoes[0]
		animacao.play(ultima_direcao + "_move")
	if Input.is_action_pressed("ui_down"):
		direction.y += velocidade
		ultima_direcao = direcoes[1]
		animacao.play(ultima_direcao + "_move")
	if Input.is_action_pressed("ui_left"):
		direction.x -= velocidade
		ultima_direcao = direcoes[3]
		animacao.play(ultima_direcao + "_move")
	if Input.is_action_pressed("ui_right"):
		direction.x += velocidade
		ultima_direcao = direcoes[2]
		animacao.play(ultima_direcao + "_move")
	
	
	if direction != Vector2.ZERO:
		direction = direction.normalized()
	else:
		animacao.play(ultima_direcao + "_move")
	
	velocity = direction * velocidade
	move_and_slide()
