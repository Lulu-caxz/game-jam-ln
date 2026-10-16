extends Node


@onready var delegadoCorredor: PackedScene = preload("res://scenes/npcs/dele_gado_corredor.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.sendoPersiguido:
		var instancia = delegadoCorredor.instantiate()
		instancia.position = Vector2(135, -400)
		get_tree().current_scene.add_child.call_deferred(instancia)
		
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
