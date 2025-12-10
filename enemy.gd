extends CharacterBody2D
class_name Enemy

@onready var movement: Movement = $"Movement" as Movement
@onready var sensor: Area2D = $Sensor

var player: CollisionObject2D


func _ready() -> void:
	movement.setup(self)
	
	
func _physics_process(delta: float) -> void:
	if player != null:
		var direction = (player.global_position - global_position) * delta
		var distance = global_position.distance_to(player.global_position)
		
		if distance > 100:
			movement.move(direction.x)
		
	


func _on_sensor_body_entered(body: Node2D) -> void:
	if body.name == 'Player':
		player = body
	pass
	


func _on_sensor_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
