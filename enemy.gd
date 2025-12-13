extends CharacterBody2D
class_name Enemy
@onready var patrol_timer: Timer = $PatrolTimer
@onready var movement: Movement = $"Movement" as Movement
@onready var sensor: Area2D = $Sensor
var is_roaming := true
var is_chasing:=false

var player: CollisionObject2D
var dir: Vector2

func _ready() -> void:
	movement.setup(self)
	
	
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += get_gravity().y * delta
	movement.move(dir.x)


func _on_patrol_timer_timeout() -> void:
	$PatrolTimer.wait_time = choose([1.5,2.0,2.5])
	if !is_chasing:
		dir = choose([Vector2.RIGHT,Vector2.LEFT])
		velocity.x = 0
		
	pass # Replace with function body.
	
	
func choose(array):
	array.shuffle()
	return array.front()
