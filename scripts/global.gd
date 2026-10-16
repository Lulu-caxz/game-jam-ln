extends Node

var sequencia_players = ["Capivara", "Pato", "Gado"]
var atual = 0

var dialogo_ativo: bool = false

var ultimaDirecao: String = "baixo"

var posicao_player: Vector2 = Vector2.ZERO
var definir_posicao: bool = false

var personagens_usados: Array[String] = []

const Nomes = [
	{"Capivara": "Capi Talista"},
	{"Pato": "Psico Pato"},
	{"Gado": "Advo Gado"}
]

const textures_dialogo = [
	{"Capivara": "res://sprites/iconDialogo/Capivara.png"},
	{"Capi Talista": "res://sprites/iconDialogo/Capivara.png"},
	
	{"Gado": "res://sprites/iconDialogo/Gado.png"},
	{"Advo Gado": "res://sprites/iconDialogo/Gado.png"},
	
	{"Pato": "res://sprites/iconDialogo/Pato.png"},
	{"Psico Pato": "res://sprites/iconDialogo/Pato.png"},
	
	{"Cobra Dora": "res://sprites/iconDialogo/CobraDoraDialogo.png"},
	{"Pombo Correio": "res://sprites/iconDialogo/PomboDialogo.png"},
	{"Tigrinho": "res://sprites/iconDialogo/TigrinhoDialogo.png"},
	{"Tigrão": "res://sprites/iconDialogo/TigrinhoDialogo.png"},
	{"Dele Gado": "res://sprites/iconDialogo/DeleGadoDialogo.png"},
	{"Ze Brava": "res://sprites/iconDialogo/ZeBravaDialogo.png"},
]

func bloquear_personagem(id: String) -> void:
	var id_formatado = id.capitalize()
	if not personagens_usados.has(id_formatado):
		personagens_usados.append(id_formatado)

func esta_bloqueado(id: String) -> bool:
	return personagens_usados.has(id.capitalize())

func desbloquear_personagem(id: String) -> void:
	personagens_usados.erase(id.capitalize())




#VARIAVEIS DA HISTORIA
var presos = []
var mortos = []
var fugiu = []

var resultadoCobraDoraTexto: String = ""

var capivaraAcoes = 3
var patoAcoes = 3
var gadoAcoes = 3

var capivaraForagida = false
var patoForagido = false
var gadoForagido = false

#so pode chegar em 1, se for preso dnv acaba o turno
var patoVezesPreso = 0
var capivaraVezesPreso = 0
var gadoVezesPreso = 0

#true = ter dinheiro, false n ter , começa sem dinheiro, tem q conseguir no banco ou aposta
var dinheiroCapivara = false
var dinheiroPato = false
var dinheiroGado = false

var capivaraJaPegouDinheiroNoBanco = false

var resultadoBancoTexto: String = ""

var bancoRoubado = false

var manifestaçãoAtiva = false

var statusApostaTigrinho: String = ""
var resultadoTigrinhoTexto: String = ""
var resultadoApostaTigrinho: bool = false

var capivaraJaApostou = false
var patoJaApostou = false
var gadoJaApostou = false

#tem q falar com o pombocorreio pra conseguir
var resultadoPomboTexto: String = ""

var capivaraTemEquipamentoPraFugir = false
var patoTemEquipamentoPraFugir = false
var gadoTemEquipamentoPraFugir = false

#apenas true para saber quer esta sendo perseguido(sla se vai usar isso)
var capivaraSendoPersiguido = false
var patoSendoPersiguido = false
var gadoSendoPerseguido = false

#carros roubados
var carrosRoubados = [] # 1 , 2 ,3 vai ser o id do carro fds



func tem_dinheiro(jogador: String) -> bool:
	match jogador:
		"Capivara":
			return Global.dinheiroCapivara
		"Pato":
			return Global.dinheiroPato
		"Gado":
			return Global.dinheiroGado

	return false


func gastar_dinheiro(jogador: String) -> void:
	match jogador:
		"Capivara":
			Global.dinheiroCapivara = false
		"Pato":
			Global.dinheiroPato = false
		"Gado":
			Global.dinheiroGado = false

func gastar_acao(jogador: String) -> void:
	match jogador:
		"Capivara":
			Global.capivaraAcoes -= 1
		"Pato":
			Global.patoAcoes -= 1
		"Gado":
			Global.gadoAcoes -= 1

func tem_equipamento(jogador: String) -> bool:
	match jogador:
		"Capivara":
			return Global.capivaraTemEquipamentoPraFugir
		"Pato":
			return Global.patoTemEquipamentoPraFugir
		"Gado":
			return Global.gadoTemEquipamentoPraFugir

	return false


func entregar_equipamento(jogador: String) -> void:
	match jogador:
		"Capivara":
			Global.capivaraTemEquipamentoPraFugir = true
		"Pato":
			Global.patoTemEquipamentoPraFugir = true
		"Gado":
			Global.gadoTemEquipamentoPraFugir = true
