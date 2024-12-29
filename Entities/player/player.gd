extends CharacterBody2D

@onready var animate: AnimatedSprite2D = $AnimatedSprite2D
@onready var transition_animation: Node2D = $transition

const speed = 300.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

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
	Engine.time_scale = 0.5
	animate.play("death")
	
func _on_animated_sprite_2d_animation_finished() -> void:
	if animate.animation == "death":
		$transition.visible = true
		$transition/AnimationPlayer.play("scene_transition")
		await  get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_file("res://scene_not_main/death_scene.tscn")
		
		Engine.time_scale = 1.0


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area is Pin:
		Death()


func _on_entry_area_body_entered(_body: Node2D) -> void:
	$transition.visible = true
	$transition/AnimationPlayer.play("scene_transition")
	await  get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://Main Scenes/cut_scene.tscn")
