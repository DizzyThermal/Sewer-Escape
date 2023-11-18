extends CharacterBody2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var triggered = false

func _physics_process(delta):
	if triggered and not is_on_floor():
		velocity.y += gravity * delta

	move_and_slide()

func _on_trigger_box_body_entered(body):
	triggered = true
