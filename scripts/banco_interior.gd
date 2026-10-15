extends Node2D

@onready var capivaraNPC: RigidBody2D = $YSort/CapivaraNPC
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.sequencia_players[Global.atual] == "Capivara" or "Capivara" in Global.presos:
		capivaraNPC.queue_free()
