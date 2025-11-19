class_name HitboxComponent
extends Area2D


@export var dmg: int= 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	area_entered.connect(hit)
	pass # Replace with function body.


func hit(area):
	if area is HealthComponent:
		print('HIT')
