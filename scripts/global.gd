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
	{"Veado": "AdVeado"}
]

const textures_dialogo = [
	{"Capivara": "res://sprites/iconDialogo/Capivara.png"},
	{"Veado": "res://sprites/iconDialogo/Veado.png"},
	{"Pato": "res://sprites/iconDialogo/Pato.png"},
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
