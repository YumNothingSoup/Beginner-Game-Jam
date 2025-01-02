extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var subtitles: RichTextLabel = %Subtitles

var progress: int = 1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#$Timer.start()
	animation_player.play("Entry")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("left_mouse") or Input.is_action_just_pressed("enter") or Input.is_action_just_pressed("space"):
		
		if subtitles.visible_ratio < 1 and progress < 3:
			animation_player.stop()
			subtitles.visible_ratio = 1
		elif progress < 3:
			animation_player.play("RESET")
			progress += 1
		
			match progress:
				2:
					animation_player.play("Progress2")
				3:
					animation_player.play("Progress3")
				_:
					pass

func go_to_game_area():
	get_tree().change_scene_to_file("res://Main Scenes/game_area.tscn")
