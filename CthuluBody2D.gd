extends CharacterBody2D

const SPEED = 150.0
var mouvementX = 0
var saut = 0
var action
var temp = 10
const JUMP_VELOCITY = -400.0
var HasJumped = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	if not is_on_floor():
		velocity.y += gravity * delta
	#pick a random number between 1 and 2 every 10 frames
	if temp == 0:
		action = randi_range(1,4)
		HasJumped = false		
		print(action)
		temp = 60
	else:
		temp -= 1
	#action = randi_range(1,2)
	if action == 1:
		%CthuluBody2D.position.x += 1
		%AnimatedCthulu2D.flip_h = false
		%AnimatedCthulu2D.play("walk")
		#HasJumped = false
		
		
	elif action == 2:
		%CthuluBody2D.position.x += -1
		%AnimatedCthulu2D.flip_h = true
		%AnimatedCthulu2D.play("walk")
		#HasJumped = false
		
	elif action == 3:
		%CthuluBody2D.position.x += 0
		%AnimatedCthulu2D.play("idle")
		#HasJumped = false
		
	elif is_on_floor() and HasJumped == false: 
		%AnimatedCthulu2D.play("fly")
		velocity.y = JUMP_VELOCITY
		HasJumped = true 
	pass

	move_and_slide()
# suppression des mob en dehors de l'écran
#func _on_visible_on_screen_notifier_2d_screen_exited():
	#queue_free()
