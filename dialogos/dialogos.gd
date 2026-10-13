
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
			"quem": ["Npc", "Veado"],
			"texto": "Você decidiu investigar o banco!",
			"proxima_fala": 3
		},
		{
			"quem": ["Npc", "Veado"],
			"texto": "Você encontrou pistas importantes!",
			"fim": true
		},
		{
			"quem": ["Npc", "Veado"],
			"texto": "Você decidiu arquivar o caso!",
			"proxima_fala": 5
		},
		{
			"quem": ["Npc", "Veado"],
			"texto": "O caso foi encerrado.",
			"fim": true
		}
	],
	
	"tigrinho": [
		{
			"quem": ["Npc", "Tigrinho"],
			"texto": "E aí, meu cria! Bora testar a sorte?"
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
