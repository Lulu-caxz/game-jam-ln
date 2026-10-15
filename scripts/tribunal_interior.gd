extends Node2D

@onready var gadoNPC: RigidBody2D = $YSort/GadoNPC
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.sequencia_players[Global.atual] == "Gado" or "Gado" in Global.presos:
		gadoNPC.queue_free()
