extends CharacterBody2D
class_name Enemy
@onready var patrol_timer: Timer = $PatrolTimer
@onready var movement: Movement = $"Movement" as Movement
var is_roaming := true
var is_chasing:=false
@export var patrol_points : Node2D
var points_length : int
var point_positions: Array[Vector2]
var current_point : Vector2
var current_point_position : int

var player: CollisionObject2D
func _ready() -> void:
	movement.setup(self)
	
	if patrol_points != null:
		points_length = patrol_points.get_children().size()
		for point in patrol_points.get_children():
			point_positions.append(point.global_position)
		current_point = point_positions[current_point_position]
	else:
		print("No patrol points")
	
	
func _physics_process(delta: float) -> void:
	
	if player != null:
		var dir = player.global_position - global_position
		var dis= global_position.distance_to(player.global_position)
		
		if dis > 100 :
			movement.move(dir.x)
		
	if not is_on_floor():
		velocity.y += get_gravity().y * delta
	#movement.move(dir.x)


func choose(array):
	array.shuffle()
	return array.front()
	
