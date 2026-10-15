
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
			"texto": "Vai querer apostar? (Só pode uma vez por personagem, custa ação)",
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
			"quem": ["Npc", "Tigrão"],
			"texto": "Nãooo, aquele é meu irmão gêmeo eu sou o Tigrão."
		},
		{
			"quem": ["Npc", "Tigrão"],
			"texto": "Enfim... Bora tentar a sorte?"
		},
		{
			"tipo": "escolha",
			"texto": "Vai querer apostar? (Só pode uma vez por personagem, custa ação)",
			"opcoes": [
				{
					"texto": "Apostar",
					"proxima_fala": 4
				},
				{
					"texto": "Hoje não",
					"proxima_fala": 5
				}
			]
		},
		{
			"quem": ["Npc", "Tigrão"],
			"texto": "",
			"resultado_aposta": true,
			"fim": true
		},
		{
			"quem": ["Npc", "Tigrão"],
			"texto": "Suave então. Volta quando quiser!",
			"fim": true
		}
	],
	"pombo-correio": [
		{
			"quem": ["Player", ""],
			"texto": "Quem é você?"
		},
		{
			"quem": ["Npc", "Pombo Correio"],
			"texto": "Oi meu chapa, sou o pombo-correio, trago umas parada maneira aqui pra dentro. PRRUUU"
		},
		{
			"quem": ["Player", ""],
			"texto": "O que você tem de bom aí?"
		},
		{
			"tipo": "escolha",
			"texto": "Tenho um equipamento pra te ajudar a fugir daqui. (Custa dinheiro e ação)",
			"opcoes": [
				{
					"texto": "Comprar",
					"proxima_fala": 4
				},
				{
					"texto": "Hoje não",
					"proxima_fala": 5
				}
			]
		},
		{
			"quem": ["Npc", "Pombo Correio"],
			"texto": "",
			"resultado_compra_pombo": true,
			"fim": true
		},
		{
			"quem": ["Npc", "Pombo Correio"],
			"texto": "Tranquilo, tô sempre por aqui. PRRUUU",
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
	],
	
	"CobraDora-capivara": [
		{
			"quem": ["Player", "Capivara"],
			"texto": "Ô sua trambiqueira, que é que você tem a me oferecer?"
		},
		{
			"quem": ["Npc", "Cobra Dora"],
			"texto": "Ta querendo ferrar com alguem é?"
		},
		{
			"tipo": "escolha",
			"texto": "Vai querer que eu incrimine quem? (Custa dinheiro e ação)",
			"opcoes": [
				{
					"texto": "Psico Pato",
					"proxima_fala": 3
				},
				{
					"texto": "Advo Gado",
					"proxima_fala": 4
				}
			]
		},
		{
			"quem": ["Npc", "Cobra Dora"],
			"texto": "Vou botar o Psico Pato na prisão pra você",
			"resultado_cobra_dora": true,
			"fim": true
		},
		{
			"quem": ["Npc", "Cobra Dora"],
			"texto": "Entao beleza, esse Advo Gado vai ser preso",
			"resultado_cobra_dora": true,
			"fim": true
		}
	],
	"CobraDora-pato": [
		{
			"quem": ["Player", "Pato"],
			"texto": "Quack quack"
		},
		{
			"quem": ["Npc", "Cobra Dora"],
			"texto": "Ta querendo ferrar com alguem é?"
		},
		{
			"tipo": "escolha",
			"texto": "Vai querer que eu incrimine quem? (Custa dinheiro e ação)",
			"opcoes": [
				{
					"texto": "Capi Talista",
					"proxima_fala": 3
				},
				{
					"texto": "Advo Gado",
					"proxima_fala": 4
				}
			]
		},
		{
			"quem": ["Npc", "Cobra Dora"],
			"texto": "Vou botar o Capi Talista na prisão pra você",
			"resultado_cobra_dora": true,
			"fim": true
		},
		{
			"quem": ["Npc", "Cobra Dora"],
			"texto": "Entao beleza, esse Advo Gado vai ser preso",
			"resultado_cobra_dora": true,
			"fim": true
		}
	],
	"CobraDora-gado": [
		{
			"quem": ["Player", "Gado"],
			"texto": "Consegue prender alguem pra mim por favor?"
		},
		{
			"quem": ["Npc", "Cobra Dora"],
			"texto": "Ta querendo ferrar com alguem é?"
		},
		{
			"tipo": "escolha",
			"texto": "Vai querer que eu incrimine quem? (Custa dinheiro e ação)",
			"opcoes": [
				{
					"texto": "Psico Pato",
					"proxima_fala": 3
				},
				{
					"texto": "Capi Talista",
					"proxima_fala": 4
				}
			]
		},
		{
			"quem": ["Npc", "Cobra Dora"],
			"texto": "Vou botar o Psico Pato na prisão pra você",
			"resultado_cobra_dora": true,
			"fim": true
		},
		{
			"quem": ["Npc", "Cobra Dora"],
			"texto": "Entao beleza, esse Capi Talista vai ser preso",
			"resultado_cobra_dora": true,
			"fim": true
		}
	],
	
	
	"Buraco-bloqueado" : [
		{
			"texto": "A passagem precisa terminar de ser cavada. É necessário uma ferramenta.",
			"fim": true
		}
	],
	"Buraco-desbloqueado" : [
		{
			"texto": "Você cavou para fora e fugiu.",
			"fim": true
		}
	],
	
	"banco-capivara": [
		{
			"tipo": "escolha",
			"texto": "Deseja sacar dinheiro? (Custa 1 ação)",
			"opcoes": [
				{
					"texto": "Sim",
					"proxima_fala": 1
				},
				{
					"texto": "Não",
					"proxima_fala": 2
				}
			]
		},
		{
			"texto": "",
			"resultado_banco": true,
			"fim": true
		},
		{
			"texto": "",
			"resultado_banco": true,
			"fim": true
		}
	],

	"banco-roubado": [
		{
			"texto": "O banco foi roubado e não possui mais dinheiro.",
			"fim": true
		}
	],

	"banco-sem-dinheiro-capivara": [
		{
			"texto": "Você já sacou e não possui mais dinheiro guardado.",
			"fim": true
		}
	],

	"banco-sem-dinheiro" : [
		{
			"texto": "Você é pobre e não possui dinheiro guardado",
			"fim": true
		}
	],
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
