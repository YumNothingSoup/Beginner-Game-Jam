extends CharacterBody2D
class_name Player

@onready var animation: AnimatedSprite2D = $AnimatedSprite2D
@onready var transition_animation: Node2D = $transition
@onready var death_sfx: AudioStreamPlayer2D = $DeathSFX
var bowling_ball: BowlingBall

var is_dead: bool = false

const speed = 300.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.player_turn_started.connect(animate_player_start)
	if get_tree().get_current_scene().get_name() == "Main":
		bowling_ball = %BowlingBall
		if bowling_ball != null:
			bowling_ball.ball_thrown.connect(animate_no_ball)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func get_input():
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down") 	
	velocity = input_direction * speed 
	
func _physics_process(_delta):
	if get_tree().get_current_scene().get_name() == "Main":
		pass
	else:
		get_input() 	
		move_and_slide()
	
#death func
func Death():
	is_dead = true
	death_sfx.play()
	Engine.time_scale = 0.5
	Events.player_died.emit()
	
	$transition.visible = true
	$transition/AnimationPlayer.play("scene_transition")
	await  get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://Environment/death_scene.tscn")
		
	Engine.time_scale = 1.0
	
func animate_player_start():
	if get_tree().get_current_scene().get_name() != "Main":
		return
	
	animation.stop()
	animation.play("has_ball")

func animate_no_ball():
	if get_tree().get_current_scene().get_name() != "Main":
		return
	
	animation.stop()
	animation.play("no_ball")


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area is Pin:
		Death()

func _on_entry_area_body_entered(_body: Node2D) -> void:
	$transition.visible = true
	$transition/AnimationPlayer.play("scene_transition")
	$HoleSFX.play()
	await get_tree().create_timer(1.6).timeout
	get_tree().change_scene_to_file("res://Main Scenes/cut_scene.tscn")
