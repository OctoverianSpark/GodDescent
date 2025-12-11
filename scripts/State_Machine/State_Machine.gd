class_name StateMachine extends Node

## Referencia del Nodo a Controlar.
@onready var Controller_Node = self.owner

## Estado por defecto
@export var Default_State:State_Father

## Estado en ejecucion constante
var current_State:State_Father = null

func _ready() -> void:
	call_deferred("_Defaul_State_STSRT")
	
func _Defauld_State_START() -> void:
	current_State = Default_State
	_state_START()

## Funcion de preparacion de variables para New_State y activa su START
func _state_START() -> void:
	print("StateMachine", Controller_Node.name, "state_START", current_State.name)
	## Configuramos el estado
	current_State.Controller_Node = Controller_Node
	current_State.State_Machine = self
	current_State.START()
	
## Metodo para Chage_State
func Change_To(NEW_State:String) -> void:
	if current_State and current_State.has_method("END"): current_State.END()
	current_State = get_node(NEW_State)
	_state_START()
	
#region Metodos de AutoEjecucion 

func _process(delta: float) -> void:
	if current_State and current_State.has_method("ON_process"): 
		current_State.ON_process(delta)
	
func _physics_process(delta: float) -> void:
	if current_State and current_State.has_method("ON_physics_process"): 
		current_State.ON_physics_process(delta)
		
func _input(event: InputEvent) -> void:
	if current_State and current_State.has_method("ON_input"): 
		current_State.ON_input(event)
	
func _unhandled_input(event: InputEvent) -> void:
	if current_State and current_State.has_method("ON_unhandled_input"): 
		current_State.ON_unhandled_input(event)

func _unhandled_key_input(event: InputEvent) -> void:
	if current_State and current_State.has_method("ON_unhandled_key_input"): 
		current_State.ON_unhandled_key_input(event)
