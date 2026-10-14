extends Node2D

@onready var CapivaraNPC:RigidBody2D = $Personagens/CapivaraNPC
@onready var PatoNPC:RigidBody2D = $Personagens/PatoNPC
@onready var GadoNPC:RigidBody2D = $Personagens/GadoNPC

# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	if !"Capivara" in Global.presos or Global.sequencia_players[Global.atual] == "Capivara":
		CapivaraNPC.queue_free()
	if !"Pato" in Global.presos or Global.sequencia_players[Global.atual] == "Pato":
		PatoNPC.queue_free()
	if !"Gado" in Global.presos or Global.sequencia_players[Global.atual] == "Gado":
		GadoNPC.queue_free()
