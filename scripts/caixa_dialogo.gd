extends Control

@onready var Player: Sprite2D = $Player
@onready var Npc: Sprite2D = $Npc
@onready var caixa: NinePatchRect = $NinePatchRect


#pra travar a camera qnd o dialogo aparecer
#so ativar o enabled dele 



func _ready() -> void:
	
	#isso é pra apagar ele dps de um tempo pra testar
	
	await get_tree().create_timer(3.0).timeout
	queue_free()
	pass

func _process(delta: float) -> void:
	Player.texture = load(Global.textures_dialogo[Global.sequencia_players[Global.atual]])
	pass
