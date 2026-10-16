extends RigidBody2D

@onready var som: AudioStreamPlayer2D = $AudioStreamPlayer2D

@onready var anim1 = $AnimatedSprite2D
@onready var anim2 = $AnimatedSprite2D2


func _ready() -> void:
	anim1.stop()
	anim2.stop()
	quack()

func quack() -> void:
	await get_tree().create_timer(randf_range(0, 1)).timeout
	anim1.play("default")
	anim2.play("default")
	while true:
		await get_tree().create_timer(randf_range(3, 7)).timeout
		som.play()
		
		som.volume_db += randf_range(-5,1)
		
