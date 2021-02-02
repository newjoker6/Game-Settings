extends HBoxContainer



#----------Variables----------


# export of action variable to easily set through inspector

export(String) var action


# Custom Signal for emitting up to Control_List script

signal newmapping


#----------Functions----------



# Checks that action exists and sets key and action text

func _ready():
	yield(get_tree().create_timer(0.1),"timeout")
	assert(InputMap.has_action(action))
	set_process_unhandled_key_input(false)
	display_current_key()
	$ActionText.text = action + "                               "



# Remaps key to new button pressed

func _unhandled_key_input(event):
	remap_action_to(event)
	$Button.pressed = false



# Remaps control based on the given input
# Emitts signal to update and save controls file

func remap_action_to(event):
	InputMap.action_erase_events(action)
	InputMap.action_add_event(action, event)
	emit_signal("newmapping", action, event)
	$Button.text = event.as_text()


# Displays the current key for your action

func display_current_key():
	var current_key = InputMap.get_action_list(action)[0].as_text()
	$Button.text = current_key



#----------Signal Actions----------


# Gets ready to accept new key input from the user
# Updates shown key for action

func _toggled(button_pressed):
	set_process_unhandled_key_input(button_pressed)
	if button_pressed:
		$Button.text = "?"
		release_focus()
	else:
		display_current_key()
