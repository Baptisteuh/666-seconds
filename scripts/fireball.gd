extends Area2D

@export var speed = 3000.0
@export var damages = 100.0

var hit = false

func _ready() -> void:
	# Adjust visibility of the balls based on the ghost type
	if GlobalVariables.ghost_type == "electric":
		get_node("WaterBall").visible = false
		get_node("FireBall").visible = false
		get_node("ElectricBall").visible = true
	elif GlobalVariables.ghost_type == "fire":
		get_node("WaterBall").visible = false
		get_node("ElectricBall").visible = false
		get_node("FireBall").visible = true
	elif GlobalVariables.ghost_type == "water":
		get_node("FireBall").visible = false
		get_node("ElectricBall").visible = false
		get_node("WaterBall").visible = true

func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		self.get_parent().get_parent().get_node("Player").get_node("Camera2D").get_node("HUD").get_node("TimeLeft").hit = true
	queue_free()
