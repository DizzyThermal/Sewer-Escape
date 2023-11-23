extends CharacterBody2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var triggered = false

func _physics_process(delta):
	if triggered and not is_on_floor():
		velocity.y += gravity * delta
	
	if triggered and is_on_floor():
		queue_free()

	move_and_slide()

func _on_trigger_box_body_entered(body):
	triggered = true

func _on_death_zone_body_entered(body):
	get_tree().reload_current_scene()
