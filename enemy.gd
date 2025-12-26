extends CharacterBody2D
class_name Enemy
@onready var movement: Movement = $"Movement" as Movement


@export var patrol_points : Node2D
var player: CollisionObject2D
func _ready() -> void:
	movement.setup(self)

func _physics_process(delta: float) -> void:
	velocity.y += get_gravity().y * delta


func choose(array):
	array.shuffle()
	return array.front()
	
