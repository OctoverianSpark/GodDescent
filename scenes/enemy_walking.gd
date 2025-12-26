class_name EnemyPatrol
extends State

@onready var patrol_points: Node2D = $"../../PatrolPoints"
var points_length : int
var point_positions: Array[Vector2]
var current_point : Vector2
var current_point_position : int
var dir : Vector2 =Vector2.LEFT


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	await owner.ready
	father = owner
	if patrol_points != null:
		points_length = patrol_points.get_children().size()
		for point in patrol_points.get_children():
			point_positions.append(point.global_position)
		current_point = point_positions[current_point_position]
	else:
		print("No patrol points")
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_update(delta: float) -> void:
	if abs(father.position.x - current_point.x) > 0.5:
		print(abs(father.position.x - current_point.x))
		father.movement.move(dir.x)
	else:
		current_point_position+=1
		if current_point_position >=patrol_points.get_children().size():
			current_point_position=0
		current_point = point_positions[current_point_position]	
		
		if current_point.x > father.position.x:
			dir = Vector2.RIGHT
			
		else:
			
			dir = Vector2.LEFT
			
		$"../../Sprite2D".flip_h = dir.x>0
	
	
