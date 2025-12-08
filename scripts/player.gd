extends CharacterBody2D
class_name Player

@export var anim_tree: AnimationTree
@export var animation_states: AnimationNodeStateMachinePlayback
@export var JUMP_SPEED = -300
@onready var movement: Movement = $Movement as Movement
@onready var sprite: Sprite2D = $Sprite

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

func _apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y += get_gravity().y * delta
	else:
		velocity.y = 0


func _handle_jump():
	if is_on_floor():
		velocity.y = JUMP_SPEED
		state = STATES.JUMPING
		
func _set_anim(name: String) -> void:
	if animation_states:
		animation_states.travel(name)
	else:
		print("Playback no asignado")



func _ready() -> void:
	movement.setup(self)
	print(animation_states)





func _input(event: InputEvent) -> void:
	dir_x = Input.get_axis("ui_left", "ui_right")

	if dir_x == 0:
		state = STATES.IDLE
	else:
		state = STATES.MOVE
	
	if Input.is_action_just_pressed('accept'):
		state = STATES.JUMPING
func _update_anim_state():
	
	match state:
		STATES.IDLE:
			_set_anim("idle")

		STATES.MOVE:
			_set_anim("walk")



func _physics_process(delta: float) -> void:
	_apply_gravity(delta)
	_update_anim_state()

	match state:
		STATES.MOVE:
			sprite.flip_h = dir_x < 0
			movement.move(dir_x)
		STATES.JUMPING:
			_handle_jump()
		_:
			movement.stop_movement()

	move_and_slide()
