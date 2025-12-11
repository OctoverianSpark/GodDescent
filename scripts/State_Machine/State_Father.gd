class_name State_Father extends Node

## Referencia del Nodo a Controlar.
@onready var Controller_Node:Node = self.owner

## Referencia StateMachine
var State_Machine:StateMachine

#region Metodos Comunes de los States

func START():
	pass
	
func END():
	pass
	
#endregion
