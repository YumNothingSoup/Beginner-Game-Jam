extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label2.text = str(GlobalData.score)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_texture_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Main Scenes/main_menu.tscn")
