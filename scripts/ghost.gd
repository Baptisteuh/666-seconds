extends CharacterBody2D

const Fireball = preload("res://scenes/fireball.tscn")
var timer := Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_child(timer)
	timer.wait_time = 5.0
	timer.one_shot = true
	timer.connect("timeout", _on_timer_timeout)
	timer.start()
	pass # Replace with function body.

func _on_timer_timeout() -> void:
	shoot()
	timer.wait_time = 5.0
	timer.one_shot = true
	timer.connect("timeout", _on_timer_timeout)
	timer.start()
	pass

func shoot() -> void:
	var fireball = Fireball.instantiate()
	add_child(fireball)
	fireball.transform = $Aim.transform
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$AnimatedSprite2D.animation = "idle"
	$AnimatedSprite2D.play()
	pass
