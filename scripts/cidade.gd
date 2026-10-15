extends Node2D

@onready var patoNPC: RigidBody2D = $YSort/PatoNPC
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.sequencia_players[Global.atual] == "Pato" or "Pato" in Global.presos:
		patoNPC.queue_free()
