extends Tabs



#----------Variables----------


# Nodes names for easier access
onready var Resolution_Options = $Resolution_Options
onready var Window_Mode = $Window_Mode
onready var VSync = $VSync
onready var FPS = $FPS
onready var MSAA = $MSAA
onready var HDR = $HDR


# Information LIsts
var Resolutions = ["2160x1440", "1920x1080", "1280x720", "1024x600", "640x480"]
var WindowModes = ["Windowed", "Borderless", "Fullscreen"]
var MSAAOptions = ["off", "x2", "x4", "x8", "x16"]



#----------Functions----------

func _ready():
	add_modes()
	add_resolutions()
	add_msaa()
	set_hints()
	set_display_settings()


# Adds and sets window mode options

func add_modes():
	for mode in WindowModes:
		Window_Mode.add_item(mode)
		
	match GS.Settings["Display"]["WindowMode"]:
		"Windowed":
			Window_Mode.select(0)
		"Borderless":
			Window_Mode.select(1)
		"Fullscreen":
			Window_Mode.select(2)


# Adds adn sets resolution options

func add_resolutions():
	for res in Resolutions:
		Resolution_Options.add_item(res)
		
	match GS.Settings["Display"]["Resolution"]:
		Vector2(2160, 1440):
			Resolution_Options.select(0)
		Vector2(1920, 1080):
			Resolution_Options.select(1)
		Vector2(1280, 720):
			Resolution_Options.select(2)
		Vector2(1024, 600):
			Resolution_Options.select(3)
		Vector2(640, 480):
			Resolution_Options.select(4)



# Adds MSAA options

func add_msaa():
	for msaa in MSAAOptions:
		MSAA.add_item(msaa)
		
	MSAA.select(GS.Settings["Display"]["MSAA"])



# Sets all hints for mouse hover on options

func set_hints():
	Resolution_Options.hint_tooltip = "Set the resolution of your game."
	Window_Mode.hint_tooltip = "Set the window mode of your game."
	VSync.hint_tooltip = "Vsync helps elimnate screen tearing and locks your fps to your monitors reresh rate."
	FPS.hint_tooltip = "Lock your Frames Per Second, set to 0 to unlock."
	MSAA.hint_tooltip = "MSAA helps smooth edges at the cost of performance."
	HDR.hint_tooltip = "Manifold colour performance, deeper saturation, more diverse contrast, brighter highlights and darker shadows."



# Sets FPS, Vsync and HDR options based on loaded settings

func set_display_settings():
	if GS.Settings["Display"]["Vsync"] == true:
		VSync.pressed = true
	if GS.Settings["Display"]["HDR"] == true:
		HDR.pressed = true
		
	FPS.value = GS.Settings["Display"]["FPS"]



#----------Signal Actions----------


# Change window size based on resolution selected and updates and saves settings

func _on_Resolution_Options_item_selected(index):
	var resolution = Resolution_Options.get_item_text(index)
	var Window_Size = resolution.split("x", true, 1)
	OS.window_size = Vector2(Window_Size[0], Window_Size[1])
	OS.window_position = Vector2(0,0)
	
	GS.Settings["Display"]["Resolution"] = Vector2(Window_Size[0], Window_Size[1])




# Sets window mode based on selection and updates and saves settings

func _on_Window_Mode_selected(index):
	var WindowMode = Window_Mode.get_item_text(index)
	if WindowMode == "Windowed":
		OS.window_fullscreen = false
		OS.window_borderless = false
	elif WindowMode == "Borderless":
		OS.window_fullscreen = false
		OS.window_borderless = true
	elif WindowMode == "Fullscreen":
		OS.window_fullscreen = true
		OS.window_borderless = false
		
	GS.Settings["Display"]["WindowMode"] = WindowMode




# Turns vsync on and off and updates and saves settings

func _on_VSync_toggled(button_pressed):
	OS.vsync_enabled = button_pressed
	
	GS.Settings["Display"]["Vsync"] = OS.vsync_enabled




# Sets FPS based on selection and updates and saves settings

func _on_FPS_value_changed(value):
		Engine.set_target_fps(value)
		
		GS.Settings["Display"]["FPS"] = value




# Sets MSAA level and saves and updates settings

func _on_MSAA_item_selected(index):
	var msaa_option = MSAA.get_item_text(index)
	if msaa_option == "off":
		get_viewport().msaa = Viewport.MSAA_DISABLED
	if msaa_option == "x2":
		get_viewport().msaa = Viewport.MSAA_2X
	if msaa_option == "x4":
		get_viewport().msaa = Viewport.MSAA_4X
	if msaa_option == "x8":
		get_viewport().msaa = Viewport.MSAA_8X
	if msaa_option == "x16":
		get_viewport().msaa = Viewport.MSAA_16X
	
	GS.Settings["Display"]["MSAA"] = index




# Toggles HDR on and off and updates and saves settings

func _on_HDR_toggled(button_pressed):
	get_viewport().hdr = button_pressed
	
	GS.Settings["Display"]["HDR"] = get_viewport().hdr



# Saves Settings

func _on_SaveButton_pressed():
	GS.save_settings()
