class_name State
extends Node

signal transition(new_state: StringName)

var father:CharacterBody2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await owner.ready
	father = owner
	pass # Replace with function body.

func enter() -> void:
	pass

func exit() -> void:
	pass
	
func update(delta: float) -> void:
	pass
	
func physics_update(delta: float) -> void:
	pass
