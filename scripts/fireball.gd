extends Area2D


@export var speed = 3000.0
@export var damages = 50.0

var hit = false

func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		self.get_parent().get_parent().get_node("player").get_node("Camera2D").get_node("HUD").get_node("TimeLeft").hit = true
	queue_free()
