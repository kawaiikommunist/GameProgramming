extends CharacterBody2D


var SPEED = 300.0
var JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		gravity -= 1

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and not is_on_floor():
		velocity.y = JUMP_VELOCITY
		JUMP_VELOCITY *= 1.05

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		JUMP_VELOCITY = -abs(velocity.x)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
