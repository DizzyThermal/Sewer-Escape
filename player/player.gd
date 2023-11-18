extends CharacterBody2D

const SPEED = 100.0
const JUMP_VELOCITY = -400.0

var xDirection = 1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func play_anim(direction):
	if not is_on_floor():
		# Jump
		if xDirection > 0:
			$AnimatedSprite2D.play("Jump-Right")
		else:
			$AnimatedSprite2D.play("Jump-Left")
	elif direction.x == 0:
		# Idle
		if xDirection > 0:
			$AnimatedSprite2D.play("Idle-Right")
		else:
			$AnimatedSprite2D.play("Idle-Left")
	else:
		# Walk
		if direction.x > 0:
			$AnimatedSprite2D.play("Walk-Right")
		else:
			$AnimatedSprite2D.play("Walk-Left")
		xDirection = direction.x
	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_vector("Left", "Right", "Up", "Down")
	
	if direction:
		velocity = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	play_anim(direction)
