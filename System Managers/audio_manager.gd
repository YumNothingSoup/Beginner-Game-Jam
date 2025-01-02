extends Node2D

var audio_queue: Array = []

func _process(_delta: float) -> void:
	if audio_queue.size() > 5:
		audio_queue.pop_back()

func add_audio(audio_player):
	audio_queue.append(audio_player)
	
func play_audio():
	var audio = audio_queue.pop_back()
	if audio != null:
		audio.play()

func _on_audio_delay_timeout() -> void:
	if audio_queue.size() >= 1:
		play_audio()
