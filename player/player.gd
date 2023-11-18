extends CharacterBody2D

const SPEED = 300.0

var xDirection = 1

func play_anim(direction):
	if direction.x == 0:
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
	var direction = Input.get_vector("Left", "Right", "Up", "Down")
	
	if direction:
		velocity = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	play_anim(direction)
