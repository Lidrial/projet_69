extends Area2D
var DetectPlayer = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
		if DectectPlayer == true and HasJumped == false:
	%AnimatedCthulu2D.play(1atk)
	else :
		
	pass
