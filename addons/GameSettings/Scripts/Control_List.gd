extends VBoxContainer



#----------Variables----------


# Default Controls

var inputStorage = {
	"Up": KEY_W,
	"Down": KEY_S,
	"Left": KEY_A,
	"Right": KEY_D
}


# Controls save location

var PATH = "user://Controls.json"


# New Key to assign controls on load

var KEY_event




#----------Functions----------


# Deletes all Godot Default Inputs
# If no controls file exists, saves one with default buttons
# If does exists, loads controls

func _ready():
	delete_all_events()
	initial_control_save()
	for action in inputStorage:
		InputMap.erase_action(action)
		InputMap.add_action(action)
		create_event(inputStorage[str(action)])
		InputMap.action_add_event(action, KEY_event)
	print(InputMap.get_actions())



# Gets input codes using our saved controls

func create_event(key):
	var event = InputEventKey.new()
	if event is InputEventKey:
		event.scancode = key
		KEY_event = event
		print(event)


# Deletes all Godots built in controls

func delete_all_events():
	for action in ["ui_accept","ui_select","ui_cancel","ui_focuse_next","ui_focus_prev","ui_left","ui_right","ui_up","ui_down","ui_page_up","ui_page_down","ui_home","ui_focus_next","ui_end"]:
		InputMap.erase_action(action)



# Creates controls files if none exists and loads if one does

func initial_control_save():
	var file = File.new()
	if file.file_exists(PATH):
		load_controls()
	else:
		save_controls()



# Saves controls file

func save_controls():
	var file
	file = File.new()
	file.open(PATH, file.WRITE)
	file.store_line(to_json(inputStorage))
	file.close()



# Loads controls file

func load_controls():
	var file =File.new()
	file.open(PATH, file.READ)
	var text = file.get_as_text()
	inputStorage = parse_json(text)
	file.close()



#----------Signal Actions----------



# Saves new controls when a button is changed

func _on_newmapping(action, event):
	inputStorage[action] = event.scancode
	save_controls()
