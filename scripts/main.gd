extends Node

var timer := Timer.new()
var lock = true

func _ready() -> void:
	add_child(timer)
	timer.connect("timeout", _on_timer_timeout)
	timer.wait_time = 10
	timer.one_shot = true

func _process(_delta: float) -> void:
	if GlobalVariables.fighting && lock:
		timer.start()
		lock = false
	if GlobalVariables.change_ghost && lock:
		GlobalVariables.ghost_upstairs = true
		move_ghost()
		
func _on_timer_timeout() -> void:
	GlobalVariables.ghost_upstairs = false
	move_ghost()
	
func move_ghost() -> void :
	var ghost = get_node("ghost")
	if GlobalVariables.ghost_upstairs:
		ghost.position = Vector2(939, 681)
		GlobalVariables.change_ghost = false
	else:
		match GlobalVariables.ghost_type:
			"electric":
				ghost.position = Vector2(1025, 430)
			"fire":
				ghost.position = Vector2(1030, 225)
			"water":
				ghost.position = Vector2(665, 200)
		GlobalVariables.fighting = false
	lock = true
