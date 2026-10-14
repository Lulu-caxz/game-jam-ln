
class_name Dialogos

const DIALOGOS = {
	"teste": [
		{
			"quem": ["Player", ""],
			"texto": "O que você vai fazer?"
		},
		{
			"tipo": "escolha",
			"texto": "Escolha uma opção:",
			"opcoes": [
				{
					"texto": "Investigar o banco",
					"proxima_fala": 2
				},
				{
					"texto": "Arquivar o caso",
					"proxima_fala": 4
				}
			]
		},
		{
			"quem": ["Npc", "Gado"],
			"texto": "Você decidiu investigar o banco!",
			"proxima_fala": 3
		},
		{
			"quem": ["Npc", "Gado"],
			"texto": "Você encontrou pistas importantes!",
			"fim": true
		},
		{
			"quem": ["Npc", "Gado"],
			"texto": "Você decidiu arquivar o caso!",
			"proxima_fala": 5
		},
		{
			"quem": ["Npc", "Gado"],
			"texto": "O caso foi encerrado.",
			"fim": true
		}
	],
	
	"tigrinho": [
		{
			"quem": ["Npc", "Tigrinho"],
			"texto": "Opa, amigo! To pagando hoje, bora?"
		},
		{
			"tipo": "escolha",
			"texto": "Vai querer apostar? (Só pode uma vez por personagem)",
			"opcoes": [
				{
					"texto": "Apostar",
					"proxima_fala": 2
				},
				{
					"texto": "Hoje não",
					"proxima_fala": 3
				}
			]
		},
		{
			"quem": ["Npc", "Tigrinho"],
			"texto": "",
			"resultado_aposta": true,
			"fim": true
		},
		{
			"quem": ["Npc", "Tigrinho"],
			"texto": "Suave então. Volta quando quiser!",
			"fim": true
		}
	],
	"tigrinho-prisao": [
		{
			"quem": ["Player", ""],
			"texto": "Oxi, você não tava lá fora?"
		},
		{
			"quem": ["Npc", "Tigrinho"],
			"texto": "Nãooo, aquele é meu irmão gêmeo"
		},
		{
			"quem": ["Npc", "Tigrinho"],
			"texto": "Enfim... Bora tentar a sorte?"
		},
		{
			"tipo": "escolha",
			"texto": "Vai querer apostar? (Só pode uma vez por personagem)",
			"opcoes": [
				{
					"texto": "Apostar",
					"proxima_fala": 2
				},
				{
					"texto": "Hoje não",
					"proxima_fala": 3
				}
			]
		},
		{
			"quem": ["Npc", "Tigrinho"],
			"texto": "",
			"resultado_aposta": true,
			"fim": true
		},
		{
			"quem": ["Npc", "Tigrinho"],
			"texto": "Suave então. Volta quando quiser!",
			"fim": true
		}
	],
	
	"Capivara-prisao": [
		{
			"quem": ["Npc", "Capi Talista"],
			"texto": "Sai pra lá imundo, me deixa!"
		},
	],
	"Pato-prisao": [
		{
			"quem": ["Npc", "Psico Pato"],
			"texto": "quack"
		},
		{
			"quem": ["Player", ""],
			"texto": "Que?"
		},
		{
			"quem": ["Npc", "Psico Pato"],
			"texto": "QUAAAAAAAACKKKKKKKK!!!!!!"
		},
	],
	"Gado-prisao": [
		{
			"quem": ["Npc", "Advo Gado"],
			"texto": "Não é possivel que meu irmão me prendeu"
		}
	]
}



static func pegar_dialogo(nome_dialogo: String) -> Array:
	var falas = DIALOGOS[nome_dialogo].duplicate(true)

	for fala in falas:
		if fala.has("quem") and fala["quem"][0] == "Player":
			if fala["quem"][1] == "":
				var jogador_atual = Global.sequencia_players[Global.atual]

				for nome in Global.Nomes:
					if nome.has(jogador_atual):
						fala["quem"][1] = nome[jogador_atual]
						break

	return falas
