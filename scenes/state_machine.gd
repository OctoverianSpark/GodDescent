class_name State_Machine
extends Node

@export var current_state : State
var states: Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name] = child
			child.transition.connect(on_child_transition)
		else:
			push_warning("State machine contains incompatible children")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	current_state.update(delta)
	
func _physics_process(delta: float) -> void:
	current_state.physics_process(delta)
	
	
func on_child_transition(new_state_name: StringName) -> void:
	var new_state : State = states.get(new_state_name)
	if new_state != null:
		if new_state != current_state:
			current_state.exit()
			new_state.enter()
			current_state = new_state
	else:
		push_warning("State not exist")
