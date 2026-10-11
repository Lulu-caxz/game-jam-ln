extends RigidBody2D

@onready var area: Area2D = $Area2D
@onready var botao:Sprite2D = $Botao


func _ready() -> void:
	botao.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_area_2d_body_entered(body: Node2D) -> void:
	botao.visible = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	botao.visible = false
