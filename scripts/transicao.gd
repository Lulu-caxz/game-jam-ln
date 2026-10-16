extends CanvasLayer

@onready var color_rect: ColorRect = $ColorRect

func _ready() -> void:
	color_rect.color.a = 0.0
	color_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE

func mudar_cena(caminho_cena: String) -> void:
	color_rect.mouse_filter = Control.MOUSE_FILTER_STOP
	
	var tween = create_tween()
	tween.tween_property(color_rect, "color:a", 1.0, 0.4)
	await tween.finished
	
	get_tree().change_scene_to_file(caminho_cena)
	
	await get_tree().create_timer(0.5).timeout
	tween = create_tween()
	tween.tween_property(color_rect, "color:a", 0.0, 0.4)
	await tween.finished
	
	color_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE

func executar_fade_morte(som_morte: AudioStream = null) -> void:
	color_rect.mouse_filter = Control.MOUSE_FILTER_STOP
	
	

	
	var tween = create_tween()
	tween.tween_property(color_rect, "color:a", 1.0, 0.4)
	await tween.finished
	
	if som_morte:
		var audio_player = AudioStreamPlayer.new()
		audio_player.stream = som_morte
		audio_player.volume_db -= 5
		audio_player.bus = "SFX"
		add_child(audio_player)
		
		audio_player.play()
		audio_player.finished.connect(audio_player.queue_free)
	
	await get_tree().create_timer(2).timeout
	
	tween = create_tween()
	tween.tween_property(color_rect, "color:a", 0.0, 0.4)
	await tween.finished
	
	color_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
