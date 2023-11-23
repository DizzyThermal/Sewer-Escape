extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -360.0

var xDirection = 1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var hats = [
	preload("res://scenes/PilgrimHat.tscn"),
	preload("res://scenes/SantaHat.tscn"),
	preload("res://scenes/RedHat.tscn"),
]
var hat_index = 1

func get_hat():
	var hat_node = get_node("PilgrimHat")
	if hat_node == null:
		hat_node = get_node("RedHat")
	if hat_node == null:
		hat_node = get_node("SantaHat")
	
	return hat_node

func play_anim(direction):
	var body_parts = [$Body]
	var hat_node = get_hat()
	if hat_node != null:
		hat_node.frame = body_parts[0].frame
		body_parts.append(hat_node)
	var animation = "Idle-Right"

	if not is_on_floor():
		# Jump
		if xDirection > 0:
			animation = "Jump-Right"
		else:
			animation = "Jump-Left"
	elif direction == 0:
		# Idle
		if xDirection > 0:
			animation = "Idle-Right"
		else:
			animation = "Idle-Left"
	else:
		# Walk
		if direction > 0:
			animation = "Walk-Right"
		else:
			animation = "Walk-Left"
		xDirection = direction
	
	for body_part in body_parts:
		body_part.play(animation)
	
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

	if Input.is_action_just_pressed("Hat"):
		var hat_node = get_hat()
		if hat_node != null:
			hat_node.queue_free()

		if hat_index < len(hats):
			add_child(hats[hat_index].instantiate())
		
		hat_index = (hat_index + 1) % 3
		
	move_and_slide()
	play_anim(direction)

func _on_death_zone_level_1_body_entered(body):
	get_tree().reload_current_scene()

func _on_death_zone_level_2_body_entered(body):
	get_tree().reload_current_scene()

func _on_death_zone_level_3_body_entered(body):
	get_tree().reload_current_scene()
