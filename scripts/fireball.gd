extends Area2D


@export var speed = 3000.0
@export var damages = 50.0

var hit = false

func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta

func _on_body_entered(body: Node2D) -> void:
	print(body)
	if body is CharacterBody2D:
		self.get_parent().get_parent().get_child(0).get_child(0).hit = true
	queue_free()
	pass # Replace with function body.
