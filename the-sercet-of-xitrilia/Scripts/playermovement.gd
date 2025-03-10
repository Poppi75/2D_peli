extends CharacterBody2D

# Constants
const GRAVITY = 1200  # Gravity force applied to the player
const JUMP_FORCE = -400  # The initial velocity for a jump
const MAX_SPEED = 200  # Maximum horizontal speed (normal running speed)
const SPRINT_MULTIPLIER = 1.5  # Speed multiplier when sprinting
const ACCELERATION = 500  # How fast the player accelerates
const FRICTION = 600  # How fast the player decelerates

# Variables
var horizontal_velocity = 0  # Horizontal movement speed

func _physics_process(delta):
	var direction = 0  # Horizontal input direction (left or right)
	var current_max_speed = MAX_SPEED  # Start with default max speed

	# Check if the sprint key is pressed (e.g., "run")
	if Input.is_action_pressed("run"):
		current_max_speed *= SPRINT_MULTIPLIER  # Increase max speed while sprinting
	
	# Get input from the player for movement direction
	if Input.is_action_pressed("right"):
		direction += 1
	if Input.is_action_pressed("left"):
		direction -= 1

	# Horizontal movement (acceleration and deceleration)
	if direction != 0:
		horizontal_velocity = move_toward(horizontal_velocity, direction * current_max_speed, ACCELERATION * delta)
	else:
		horizontal_velocity = move_toward(horizontal_velocity, 0, FRICTION * delta)

	# Set the velocity.x based on the horizontal movement
	velocity.x = horizontal_velocity

	# Apply gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Jumping (only when on the floor)
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_FORCE

	# Move the player using the built-in velocity property
	move_and_slide()
