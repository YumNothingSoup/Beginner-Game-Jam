extends Area2D

@export var enemy_scene = preload("res://Entities/enemies/enemy.tscn")

@export var enemy_spawn_area: CollisionShape2D
@export var player_preventation_area: Area2D

@export var enemy_container: Node

@export var start_enemy_count: int = 5
@export var enemy_increment_turn_interval: int = 4
@export var enemy_spawn_turn_interval: int = 2
@export var enemy_count_incrementation_value: int = 1

var turn_count: int = 0

func _ready():
	Events.player_turn_started.connect(on_player_turn_start)
	spawn_enemies()

func on_player_turn_start():
	turn_count += 1
	
	if turn_count % enemy_increment_turn_interval == 0:
		start_enemy_count += enemy_count_incrementation_value
	if turn_count % enemy_spawn_turn_interval == 0:
		spawn_enemies()

func spawn_enemies() -> void:
	for i in range(start_enemy_count):
		var enemy_instance = enemy_scene.instantiate()
		enemy_instance.position = get_random_point_in_area()
		enemy_container.add_child(enemy_instance)

func get_random_point_in_area() -> Vector2:
	var rng = RandomNumberGenerator.new()
	
	var shape = enemy_spawn_area.shape as RectangleShape2D

	var x = rng.randf_range(enemy_spawn_area.position.x - shape.extents.x, enemy_spawn_area.position.x + shape.extents.x)
	var y = rng.randf_range(enemy_spawn_area.position.y - shape.extents.y, enemy_spawn_area.position.y + shape.extents.y)
	
	var random_point = position + Vector2(x, y)
	
	if is_point_in_player_preventation_area(random_point):
		return get_random_point_in_area()
	
	return position + Vector2(x, y)

func is_point_in_player_preventation_area(point: Vector2) -> bool:
	# Ensure the area has a CollisionPolygon2D child
	var collision_polygon = player_preventation_area.get_node("CollisionPolygon2D") as CollisionPolygon2D
	if collision_polygon == null:
		push_error("The specified area does not have a CollisionPolygon2D child.")
		return false
	
	# Convert the global point to the local coordinates of the area
	var local_point = player_preventation_area.to_local(point)
	
	# Check if the point is inside the polygon
	return Geometry2D.is_point_in_polygon(local_point, collision_polygon.polygon)
