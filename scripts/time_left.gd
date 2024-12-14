extends Label

var timer := Timer.new()
var hit = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_child(timer)
	timer.wait_time = 666.0
	timer.one_shot = true
	timer.start()
	timer.connect("timeout", _on_timer_timeout)
	pass # Replace with function body.

func _on_timer_timeout() -> void:
	# lose
	queue_free()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if hit:
		timer.wait_time -= 50.0
		hit = false
	self.text = str(roundf(timer.time_left))
	pass
