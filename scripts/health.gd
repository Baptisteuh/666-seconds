extends TextureProgressBar

func _process(_delta: float) -> void:
	self.value = 3 - GlobalVariables.defeated
	if Input.is_action_just_released("click") && !GlobalVariables.ghost_upstairs && self.value > 0:
		GlobalVariables.defeated += 1
		GlobalVariables.defeated_ghosts.append(GlobalVariables.ghost_type)
		GlobalVariables.change_ghost = true
		GlobalVariables.ghost_type = ""
	if GlobalVariables.defeated == 3:
		GlobalVariables.victory_text = "YOU WON !!!"
		get_tree().change_scene_to_file("res://scenes/end_screen.tscn")
