extends Node

@onready var texto = $nodecraditos

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if texto.position.y > -490:
		texto.position += Vector2(0, -0.2)
	pass
