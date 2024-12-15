extends CanvasLayer

const CHAR_READ_RATE = 0.05

@onready var textbox_container = $TextboxContainer
@onready var start_symbol = $TextboxContainer/MarginContainer/HBoxContainer/Start
@onready var end_symbol = $TextboxContainer/MarginContainer/HBoxContainer/End
@onready var label = $TextboxContainer/MarginContainer/HBoxContainer/Label

enum State {
	READY,
	READING,
	FINISHED
}

var current_state = State.READY
var text_queue = []
var tween  # Declare tween variable

func _ready():
	hide_textbox()
	queue_text("It is said that three restless souls haunt this old manor.")
	queue_text("You are Father Benedict, tasked with breaking the curse.")
	queue_text("But hurry, or your courage may falter.")
	
	# Trigger the first message
	change_state(State.READY)

func _process(_delta):  # Use _delta to silence the warning
	match current_state:
		State.READY:
			if text_queue.size() > 0:  # Correctly check if the queue has elements
				display_text()
		State.READING:
			GlobalVariables.reading = true
			if Input.is_action_just_pressed("ui_accept"):
				if tween:
					tween.kill()
				label.visible_characters = -1
				end_symbol.text = "<-"
				change_state(State.FINISHED)
		State.FINISHED:
			if Input.is_action_just_pressed("ui_accept"):
				change_state(State.READY)
				hide_textbox()
				GlobalVariables.reading = false

func queue_text(next_text):
	text_queue.push_back(next_text)

func hide_textbox():
	start_symbol.text = ""
	end_symbol.text = ""
	label.text = ""
	textbox_container.hide()

func show_textbox():
	start_symbol.text = "*"
	textbox_container.show()

func display_text():
	if tween:
		tween.kill()
	
	# Pop the text from the queue and assign it to the label
	var next_text = text_queue.pop_front()
	label.text = next_text
	label.visible_characters = 0  # Reset visible_characters
	
	# Then create the tween
	tween = get_tree().create_tween()
	tween.tween_property(label, "visible_characters", len(label.text), len(label.text) * CHAR_READ_RATE)
	tween.connect("finished", Callable(self, "_on_tween_finished"))
	
	change_state(State.READING)
	show_textbox()
	end_symbol.text = "..."

func change_state(next_state):
	current_state = next_state

func _on_tween_finished():
	end_symbol.text = "<-"
	change_state(State.FINISHED)
