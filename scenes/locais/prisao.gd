extends Node2D

@onready var CapivaraNPC:RigidBody2D = $Personagens/CapivaraNPC
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	if !"Capivara" in Global.presos:
		CapivaraNPC.queue_free()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
