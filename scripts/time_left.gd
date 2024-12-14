extends Label

var timer := Timer.new()
var hit = false
var duration = 666.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_child(timer)
	timer.connect("timeout", _on_timer_timeout)
	timer.wait_time = duration
	timer.one_shot = true
	timer.start()

func _on_timer_timeout() -> void:
	# lose
	queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if hit:
		duration = timer.time_left
		timer.stop()
		duration -= 50.0
		timer.wait_time = duration
		timer.start()
		hit = false
	self.text = str(roundf(timer.time_left))
