class_name ScorePopup
extends Node2D

@onready var score_popup: Label = $ScorePopup
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var text: String = ""

func popup(type: String) -> void:
	if type != "Score" and type != "Combo":
		return
	
	score_popup.text = text
	if type == "Score":
		animation_player.play("PopupAnim")
	if type == "Combo":
		animation_player.play("ComboPopup")
		
	await animation_player.animation_finished
	queue_free()
