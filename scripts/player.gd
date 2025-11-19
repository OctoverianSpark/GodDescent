extends CharacterBody2D
@export var SPEED = 300.0
@export var RUN_SPEED = 500.0
@export var DASH_SPEED = 700.0
@export var JUMP_VELOCITY = -400.0
@export var JUMPS = 2
@export var DASHES = 1
@export var DASH_TIME := 0.15     # Duración del dash en segundos
@export var health_component: HealthComponent
var can_interact = false

enum STATES {
	IDLE,
	WALKING,
	RUNNING,
	JUMPING,
	ATTACK,
	DASH,
	DEAD,
	HURT
}

var state: STATES = STATES.IDLE
var jumps_left: int = JUMPS
var dashes_left: int = DASHES

var dash_timer := 0.0
var dash_direction := 1  # dirección del dash


func _ready()->void:
	health_component.onHit.connect(func(): change_state(STATES.HURT))
	health_component.onDead.connect(func(): change_state(STATES.DEAD))
	


func change_state(new_state: STATES) -> void:
	state = new_state


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("accept"):
		_handle_jump()
		
				
		

	if event.is_action_pressed("left_thumb"):
		_handle_dash()


	

func _physics_process(delta: float) -> void:
	_apply_gravity(delta)
	_state_logic(delta)
	move_and_slide()


func _state_logic(delta):
	var dir := Input.get_axis("ui_left", "ui_right")

	match state:

		# ---------------- IDLE ----------------
		STATES.IDLE:
			velocity.x = move_toward(velocity.x, 0, SPEED)

			if dir != 0:
				change_state(STATES.WALKING)

			if not is_on_floor():
				change_state(STATES.JUMPING)

			if is_on_floor():
				_reset_resources()


		# ---------------- WALKING ----------------
		STATES.WALKING:
			velocity.x = dir * SPEED

			if dir == 0:
				change_state(STATES.IDLE)

			if Input.is_action_pressed("cancel"):
				change_state(STATES.RUNNING)

			if not is_on_floor():
				change_state(STATES.JUMPING)


		# ---------------- RUNNING ----------------
		STATES.RUNNING:
			velocity.x = dir * RUN_SPEED

			if dir == 0:
				change_state(STATES.IDLE)

			if not Input.is_action_pressed("cancel"):
				change_state(STATES.WALKING)

			if not is_on_floor():
				change_state(STATES.JUMPING)


		# ---------------- JUMPING ----------------
		STATES.JUMPING:
			velocity.x = dir * SPEED

			if is_on_floor():
				jumps_left = JUMPS
				change_state(STATES.IDLE)


		# ---------------- DASH ----------------
		STATES.DASH:
			dash_timer -= delta

			# Sin gravedad mientras dura el dash
			velocity.y = 0
			velocity.x = dash_direction * DASH_SPEED
			
	
			if dash_timer <= 0:
				change_state(STATES.IDLE)
				
		STATES.HURT:
			print('Hurt')
		
		STATES.DEAD:
			print('DEAD')



# -----------------------------
#     FUNCIONES DE MOVIMIENTO
# -----------------------------

func _apply_gravity(delta):
	if state != STATES.DASH: # sin gravedad durante dash
		if not is_on_floor():
			velocity += get_gravity() * delta


func _handle_jump():
	if jumps_left > 0 and state != STATES.DASH:
		velocity.y = JUMP_VELOCITY
		jumps_left -= 1
		change_state(STATES.JUMPING)


func _handle_dash():
	if dashes_left > 0 and state != STATES.DASH:
		dashes_left -= 1
		
		# Direccion según input
		var dir := Input.get_axis("ui_left", "ui_right")
		dash_direction = dir if dir != 0 else dash_direction

		dash_timer = DASH_TIME
		change_state(STATES.DASH)
		


func _reset_resources():
	jumps_left = JUMPS
	dashes_left = DASHES

# -----------------------------
# COLISIONES
# -----------------------------
