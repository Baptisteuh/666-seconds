extends CharacterBody2D

const Fireball = preload("res://scenes/fireball.tscn")
var timer := Timer.new()var firerate = 1.0
var health = 3.0
var type

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("TextureProgressBar").value = health
	add_child(timer)
	timer.wait_time = firerate
	timer.one_shot = true
	timer.connect("timeout", _on_timer_timeout)
	timer.start()
	match randi() % 3:
		0:
			type = "energy"
		1:
			type = "fire"
		2:
			type = "water"

func _on_timer_timeout() -> void:
	shoot()
	timer.wait_time = firerate
	timer.start()

func shoot() -> void:
	var fireball = Fireball.instantiate()
	add_child(fireball)
	fireball.transform = $Aim.transform

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$AnimatedSprite2D.animation = "idle_" + type
	$AnimatedSprite2D.play()
	if Input.is_action_just_released("click") && health > 0:
		health -= 1.0
		get_node("TextureProgressBar").value = health
	if health == 0.0:
		GlobalVariables.victory_text = "YOU WON !!!"
		get_tree().change_scene_to_file("res://scenes/end_screen.tscn")
