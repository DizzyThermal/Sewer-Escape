extends CharacterBody2D

const SPEED = 60.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var xDirection = 1
var dead = false

func play_anim():
	# Walk
	if xDirection > 0:
		$AnimatedSprite2D.play("Walk-Right")
	else:
		$AnimatedSprite2D.play("Walk-Left")

func _physics_process(delta):
	if dead:
		return

	if velocity.x == 0:
		xDirection = xDirection * -1

	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	velocity.x = xDirection * SPEED

	move_and_slide()
	play_anim()

func _on_damage_box_body_entered(body):
	dead = true

	# Death
	if xDirection > 0:
		$AnimatedSprite2D.play("Death-Right")
	else:
		$AnimatedSprite2D.play("Death-Left")
	queue_free()

func _on_hurt_box_body_entered(body):
	get_tree().reload_current_scene()
