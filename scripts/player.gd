extends CharacterBody2D
class_name Player

@export var anim_tree: AnimationTree
@export var animation_states: AnimationNodeStateMachinePlayback

@onready var movement: Movement = $Movement as Movement

enum STATES {
	IDLE,
	MOVE,
	JUMPING,
	ATTACK_1,
	ATTACK_2,
	ATTACK_3,
	DASH,
	DEAD,
	HURT
}

var state: STATES = STATES.IDLE
var dir_x := 0.0  # Solo dirección horizontal


func _ready() -> void:
	movement.setup(self)


func _input(event: InputEvent) -> void:
	dir_x = Input.get_axis("ui_left", "ui_right")

	if dir_x == 0:
		state = STATES.IDLE
	else:
		state = STATES.MOVE


func _physics_process(delta: float) -> void:
	_apply_gravity(delta)

	match state:
		STATES.MOVE:
			movement.move(dir_x)
		_:
			movement.stop_movement()

	move_and_slide()


func _apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y += get_gravity().y * delta
	else:
		velocity.y = 0


func _handle_jump():
	if is_on_floor():
		velocity.y = -300
		state = STATES.JUMPING
