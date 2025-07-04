extends CharacterBody2D


@export var moveSpeed = 600.0
@export var dashSpeed = 1000
@export var dashLength = 0.2
var dashTime = 0.0
var isDashing = false
var dashBuffer = 0.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var lookDirection = get_global_mouse_position() - position

	if (Input.is_action_just_pressed("dash") or dashBuffer > 0) and not(isDashing):
		isDashing = true
		dashTime = dashLength

	elif Input.is_action_just_pressed("dash"):
		dashBuffer = 0.1
	var direction = Vector2.ZERO

	if isDashing:
		velocity = lookDirection.normalized() * dashSpeed
		move_and_slide()

	else:
		direction.x = Input.get_action_strength("moveRight") - Input.get_action_strength("moveLeft")
		direction.y = Input.get_action_strength("moveDown") - Input.get_action_strength("moveUp")
	
		direction = direction.normalized()
	
		if direction != Vector2.ZERO:
			velocity = direction * moveSpeed

			move_and_slide()

	look_at(lookDirection)

	if dashTime > 0:
		dashTime -= delta
	if dashBuffer > 0:
		dashBuffer -= delta

	if dashTime <= 0:
		isDashing = false
