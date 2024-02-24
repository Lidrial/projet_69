extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var animation_locked : bool = false
var direction
@onready var _animated_sprite = $AnimatedSprite2D


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	var jumpInput = Input.is_action_just_pressed("ui_accept");
	
	# Handle Direction.
	direction = Input.get_axis("ui_left", "ui_right")
	if direction > 0:
			_animated_sprite.flip_h = false
	elif direction < 0:
			_animated_sprite.flip_h = true

	# Handle Run.
	if direction and !jumpInput: 
		velocity.x = direction * SPEED
		if direction != 0 and is_on_floor():
			_animated_sprite.play("2-Run")

	# Handle Idle.
	elif !direction and !jumpInput and is_on_floor():
		velocity.x = move_toward(velocity.x, 0, SPEED)
		_animated_sprite.play('1-Idle')
	
	# Handle Jump.
	elif jumpInput and is_on_floor() :
		jump()

	move_and_slide()

	#
#func update_animation():
	#if not animation_locked:
		#if not is_on_floor():
			#_animated_sprite.play("4-Jump")
		#else:
			#if direction:
				#_animated_sprite.play("2-Run")
			#else:
				#_animated_sprite.play("1-Idle")
	
func jump():
		velocity.y = JUMP_VELOCITY
		_animated_sprite
		_animated_sprite.play("4-Jump")
		animation_locked = true
		
