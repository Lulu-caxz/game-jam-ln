
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
			"texto": "Tenho um equipamento pra te ajudar a fugir daqui. (Custa dinheiro)",
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
	
	"pato-praca-gado": [
		{
			"quem": ["Npc", "Psico Pato"],
			"texto": "Quaack"
		},
		{
			"quem": ["Player", ""],
			"texto": "Que? Como assim?"
		},
		{
			"quem": ["Npc", "Psico Pato"],
			"texto": "Quack Quack"
		},
		{
			"quem": ["Player", ""],
			"texto": "De fato estamos vivendo em um mundo muito complexo."
		},
		{
			"quem": ["Npc", "Psico Pato"],
			"texto": "Quack"
		},
		{
			"quem": ["Player", ""],
			"texto": "Mas que solução extrema!!!!"
		},
		{
			"quem": ["Npc", "Psico Pato"],
			"texto": "Quack..."
		}
	],
	"pato-praca-gado1": [
		{
			"quem": ["Npc", "Psico Pato"],
			"texto": "Quack"
		},
		{
			"quem": ["Player", ""],
			"texto": "Não sei se é assim que resolveremos as coisas"
		},
		{
			"quem": ["Npc", "Psico Pato"],
			"texto": "Quack Quack"
		}
	],
	"pato-praca-capivara": [
		{
			"quem": ["Npc", "Psico Pato"],
			"texto": "Quaaaaaaaaack"
		},
		{
			"quem": ["Player", ""],
			"texto": "Saia de perto de mim, você é um perigo!!"
		},
		{
			"quem": ["Npc", "Psico Pato"],
			"texto": "Quack Quack quaaaack"
		},
		{
			"quem": ["Player", ""],
			"texto": "Você deveria era estar preso!"
		},
		{
			"quem": ["Npc", "Psico Pato"],
			"texto": "Quacckk"
		}
	],
	"pato-praca-capivara1": [
		{
			"quem": ["Npc", "Psico Pato"],
			"texto": "Quaaaack"
		},
		{
			"quem": ["Player", ""],
			"texto": "Não conversarei mais com você!!"
		}
	],
	
	"fugir-prisao": [
		{
			"quem": ["Player", ""],
			"texto": "Acho que da para fugir por aqui, mas provavelmete vão me perseguir"
		},
		{
			"tipo": "escolha",
			"texto": "Fugir pela grade?",
			"opcoes": [
				{
					"texto": "Fugir",
					"proxima_fala": 4
				},
				{
					"texto": "Melhor não",
					"proxima_fala": 3
				}
			]
		},
		{
			"texto": "",
			"fim": true
		},
		{
			"texto": "Melhor evitar uma perseguição",
			"fim": true
		}
	],
	
	"Capivara-banco": [
		{
			"quem": ["Npc", "Capi Talista"],
			"texto": "Ola, como você está?"
		},
		{
			"quem": ["Npc", "Capi Talista"],
			"texto": "Um lindo dia para roub.. digo lucrar não é??"
		},
		{
			"quem": ["Player", ""],
			"texto": "!?.."
		},
		{
			"quem": ["Player", ""],
			"texto": "Estou bem sim, é um dia lindo mesmo.."
		}
	],
	"Capivara-banco1": [
		{
			"quem": ["Npc", "Capi Talista"],
			"texto": "Já nos falamos hoje, termine o que tem para fazer"
		},
		{
			"quem": ["Npc", "Capi Talista"],
			"texto": "Meu tempo é dinheiro"
		},
		{
			"quem": ["Player", ""],
			"texto": ">:("
		}
	],
	"delegado": [
		{
			"quem": ["Npc", "Dele Gado"],
			"texto": "Bom dia!!"
		},
		{
			"quem": ["Player", ""],
			"texto": "Bom dia!"
		},
		{
			"quem": ["Npc", "Dele Gado"],
			"texto": "Olha bem, aqui não tem para niguem."
		},
		{
			"quem": ["Npc", "Dele Gado"],
			"texto": "quando vejo um ladrão, coloco direto na prisão."
		},
		{
			"quem": ["Player", ""],
			"texto": "?!!"
		},
		{
			"quem": ["Player", ""],
			"texto": "Bem, com você aqui na cidade, estamos seguros em."
		},
	],
	"delegado1": [
		{
			"quem": ["Npc", "Dele Gado"],
			"texto": "Vira e meche alguem rouba o banco."
		},
		{
			"quem": ["Npc", "Dele Gado"],
			"texto": "sempre que um espertinho pisa aqui é GRADE!!"
		},
		{
			"quem": ["Player", ""],
			"texto": "Nossa que medo!"
		}
	],
	"delegado2": [
		{
			"quem": ["Npc", "Dele Gado"],
			"texto": "Se cuida e anda sempre na linha em!"
		},
		{
			"quem": ["Player", ""],
			"texto": "Com você aqui é claro"
		},
		{
			"quem": ["Npc", "Dele Gado"],
			"texto": "MUUUU!!!"
		},
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
			"quem": ["Player", "Capi Talista"],
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
	
	"banco-pato": [
		{
			"tipo": "escolha",
			"texto": "O banco está cheio de dinheiro... O que você vai fazer?",
			"opcoes": [
				{
					"texto": "Roubar o banco",
					"proxima_fala": 1
				},
				{
					"texto": "Deixar quieto",
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
			"texto": "Melhor não arriscar hoje...",
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
	
		"pato-matar-capivara": [
		{
			"quem": ["Player", "Psico Pato"],
			"texto": "Quack quack."
		},
		{
			"tipo": "escolha",
			"texto": "O Pato está perdendo a paciência. (Custa uma ação)",
			"opcoes": [
				{
					"texto": "Matar-lo",
					"proxima_fala": 2
				},
				{
					"texto": "Deixar para lá",
					"proxima_fala": 3
				}
			]
		},
		{
			"quem": ["Player", "Psico Pato"],
			"texto": "QUAAAAACK!!!",
			"matar_personagem": "Capivara",
			"fim": true
		},
		{
			"quem": ["Player", "Psico Pato"],
			"texto": "Quack quack...",
			"fim": true
		}
	],

	"pato-matar-gado": [
		{
			"quem": ["Player", "Psico Pato"],
			"texto": "Quack quack."
		},
		{
			"tipo": "escolha",
			"texto": "O Pato está perdendo a paciência. (Custa uma ação)",
			"opcoes": [
				{
					"texto": "Matar-lo",
					"proxima_fala": 2
				},
				{
					"texto": "Deixar para lá",
					"proxima_fala": 3
				}
			]
		},
		{
			"quem": ["Player", "Psico Pato"],
			"texto": "QUAAAAACK!!!",
			"matar_personagem": "Gado",
			"fim": true
		},
		{
			"quem": ["Player", "Psico Pato"],
			"texto": "Quack quack...",
			"fim": true
		}
	],
	
	"gado-zebra": [
		{
			"quem": ["Player", "Advo Gado"],
			"texto": "O que temos hoje chefe?"
		},
		{
			"quem": ["Player", "Advo Gado"],
			"texto": "Temos dois casos para você analisar."
		},
		{
			"quem": ["Npc", "Ze Brava"],
			"texto": "O Capi Talista e seus escandalos de roubo"
		},
		{
			"quem": ["Npc", "Ze Brava"],
			"texto": "E o Psico Pato com suas loucuras."
		},
		{
			"tipo": "escolha",
			"texto": "Prender quem (Custa uma ação)",
			"opcoes": [
				{
					"texto": "Capi Talista",
					"proxima_fala": 5,
					"texto_se_preso": "O Capi Talista já está preso. Não posso prendê-lo novamente."
				},
				{
					"texto": "Psico Pato",
					"proxima_fala": 6,
					"texto_se_preso": "O Psico Pato já está preso. Não posso prendê-lo novamente."
				}
			]
		},
		{
			"quem": ["Npc", "Ze Brava"],
			"texto": "Certo então",
			"prender": "Capivara",
			"fim": true
		},
		{
			"quem": ["Npc", "Ze Brava"],
			"texto": "Certo então",
			"prender": "Pato",
			"fim": true
		}
	],
	
	"zebra": [
		{
			"quem": ["Npc", "Ze Brava"],
			"texto": "Não tenho nada o que conversar com você."
		}
	],
	"descanso": [
		{
			"tipo": "escolha",
			"texto": "Parece confortavel, deseja descansar? (Gasta todas as suas ações)",
			"opcoes": [
				{
					"texto": "Descansar",
					"proxima_fala": 1
				},
				{
					"texto": "Deixar quieto",
					"proxima_fala": 2
				}
			]
		},
		{
			"texto": "Você descansou",
			"descansar": true,
			"fim": true
		},
		{
			"texto": "Você decidiu continuar sua vida.",
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
