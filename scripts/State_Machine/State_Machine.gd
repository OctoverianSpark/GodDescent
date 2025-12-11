class_name StateMachine extends Node

## Referencia del Nodo a Controlar.
@onready var Controller_Node = self.owner

## Estado por defecto
@export var Default_State:State_Father

## Estado en ejecucion constante
var current_State:State_Father = null

## Funcion de preparacion de variables para New_State y activa su START
func _state_START() -> void:
	print("StateMachine", Controller_Node.name, "state_START", current_State.name)
	## Configuramos el estado
	current_State.Controller_Node = Controller_Node
	current_State.State_Machine = self
	current_State.START()
