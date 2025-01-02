extends Node2D

func _ready() -> void:
	MenuFx.stop_music()

func _on_writing_sign_body_entered(body: Node2D) -> void:
	if body is Player:
		$StaticBody2D/WritingSign/Sprite/Panel.visible = true


func _on_writing_sign_body_exited(body: Node2D) -> void:
	$StaticBody2D/WritingSign/Sprite/Panel.visible = false
