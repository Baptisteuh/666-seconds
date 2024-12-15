extends CharacterBody2D

@export var speed = 50 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.
var can_move = true
var move_steps = 2 # Number of steps (tiles) to move up.
var step_size = 16

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity = Vector2.ZERO # The player's movement vector.
	if self.can_move:
		if Input.is_action_pressed("move_right"):
			velocity.x += 1
		if Input.is_action_pressed("move_left"):
			velocity.x -= 1
		if Input.is_action_pressed("move_down"):
			velocity.y += 1
		if Input.is_action_pressed("move_up"):
			velocity.y -= 1
		
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y < 0:
		$AnimatedSprite2D.animation = "up"
	elif velocity.y > 0:
		$AnimatedSprite2D.animation = "down_still"

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		
	position += velocity * delta
	
	move_and_slide()
# Function to move the player up 2 steps, face down, and stop.
func move_and_stop():
	can_move = false # Disable player control.
	
	var target_position = position + Vector2(0, -move_steps * step_size) # Calculate target position.
	
	# Tween to move the player.
	var tween = create_tween()
	tween.tween_property(self, "position", target_position, move_steps * step_size / float(speed))
	
	# After reaching the target, face down and re-enable control.
	tween.connect("finished", Callable(self, "_on_move_and_stop_finished"))# Callback for when the tween finishes.

func _on_move_and_stop_finished():
	$AnimatedSprite2D.animation = "down_still" # Face the player down.
	can_move = true # Re-enable player control.
