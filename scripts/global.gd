extends Node

var sequencia_players = ["Capivara", "Pato", "Veado"]
var atual = 0

var dialogo_ativo: bool = false

var ultimaDirecao: String = "baixo"

var posicao_player: Vector2 = Vector2.ZERO
var definir_posicao: bool = false

var personagens_usados: Array[String] = []

const Nomes = [
	{"Capivara": "CapiTalista"},
	{"Pato": "PsicoPato"},
	{"Gado": "Advo Gado"}
]

const textures_dialogo = [
	{"Capivara": "res://sprites/iconDialogo/Capivara.png"},
	{"Capi Talista": "res://sprites/iconDialogo/Capivara.png"},
	{"Gado": "res://sprites/iconDialogo/Veado.png"},
	{"Advo Gado": "res://sprites/iconDialogo/Veado.png"},
	{"Pato": "res://sprites/iconDialogo/Pato.png"},
	{"Psico Pato": "res://sprites/iconDialogo/Pato.png"},
	{"Cobra Dora": "res://sprites/iconDialogo/Capivara.png"}
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
var presos = ["Pato", "Capivara"]
var mortos = []

var capivaraAcoes = 3
var patoAcoes = 3
var veadoAcoes = 3

var capivaraForagida = false
var patoForagido = false
var veadoForagido = false

#so pode chegar em 1, se for preso dnv acaba o turno
var patoVezesPreso = 0
var capivaraVezesPreso = 0
var veadoVezesPreso = 0

#true = ter dinheiro, false n ter , começa sem dinheiro, tem q conseguir no banco ou aposta
var dinheiroCapivara = false
var dinheiroPato = false
var dinheiroVeado = false

var bancoRoubado = false

var manifestaçãoAtiva = false

var statusApostaTigrinho: String = ""
var resultadoTigrinhoTexto: String = ""
var resultadoApostaTigrinho: bool = false

var capivaraJaApostou = false
var patoJaApostou = false
var veadoJaApostou = false

#tem q falar com o pombocorreio pra conseguir
var capivaraTemEquipamentoPraFugir = false
var patoTemEquipamentoPraFugir = false
var veadoTemEquipamentoPraFugir = false

#apenas true para saber quer esta sendo perseguido(sla se vai usar isso)
var capivaraSendoPersiguido = false
var patoSendoPersiguido = false
var veadoSendoPerseguido = false

#carros roubados
var carrosRoubados = [] # 1 , 2 ,3 vai ser o id do carro fds
