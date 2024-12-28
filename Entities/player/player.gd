extends CharacterBody2D

@onready var animate: AnimatedSprite2D = $AnimatedSprite2D
@onready var transition_animation: Node2D = $transition

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
#death func
func Death():
	animate.play("death")
	
func _on_animated_sprite_2d_animation_finished() -> void:
	if animate.animation == "death":
		$transition.visible = true
		$transition/AnimationPlayer.play("scene_transition")
		await  get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_file("res://scene_not_main/death_scene.tscn")

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area is Pin:
		Death()
 
