extends Node
class_name Movement

@export var character : CharacterBody2D
@export var speed: float = 32.0

func setup(character2D: CharacterBody2D):
	character = character2D
	
func move(dir:float):
	character.velocity.x = dir * speed
	character.move_and_slide()
	
func stop_movement():
	character.velocity.x = 0
