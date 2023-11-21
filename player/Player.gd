extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -360.0

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
	elif direction == 0:
		# Idle
		if xDirection > 0:
			$AnimatedSprite2D.play("Idle-Right")
		else:
			$AnimatedSprite2D.play("Idle-Left")
	else:
		# Walk
		if direction > 0:
			$AnimatedSprite2D.play("Walk-Right")
		else:
			$AnimatedSprite2D.play("Walk-Left")
		xDirection = direction
	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("Left", "Right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	play_anim(direction)

func _on_death_zone_level_1_body_entered(body):
	get_tree().reload_current_scene()

func _on_death_zone_level_2_body_entered(body):
	get_tree().reload_current_scene()

func _on_death_zone_level_3_body_entered(body):
	get_tree().reload_current_scene()
