extends CharacterBody2D


const SPEED_WALK = 75.0
const SPEED_RUN = 300.0
const JUMP_VELOCITY = -815.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") * 1.7
var animation_locked : bool = false
var direction
@onready var _animated_sprite = $AnimatedSprite2D


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	var jump_input = Input.is_action_just_pressed("input_space");

	
	# Handle Direction.
	direction = Input.get_axis("input_move_left", "input_move_right")
	var shift_input = Input.is_action_pressed("input_shift")
	
	if direction > 0:
			_animated_sprite.flip_h = false
	elif direction < 0:
			_animated_sprite.flip_h = true

	# Handle Walk.
	if direction and not jump_input and not shift_input: 
		velocity.x = direction * SPEED_WALK
		if direction != 0 and is_on_floor():
			_animated_sprite.play("3-Walk")
			
	# Handle Run.
	elif direction and not jump_input and shift_input: 
		velocity.x = direction * SPEED_RUN
		if direction != 0 and is_on_floor():
			_animated_sprite.play("2-Run")

	# Handle Idle.
	elif not direction and not jump_input and is_on_floor():

		velocity.x = move_toward(velocity.x, 0, SPEED_RUN)
		_animated_sprite.play('1-Idle')
	
	# Handle Jump.
	elif jump_input and is_on_floor() :
		jump()

	move_and_slide()

	
func jump():
		velocity.y = JUMP_VELOCITY
		_animated_sprite
		_animated_sprite.play("4-Jump")
		animation_locked = true
		
