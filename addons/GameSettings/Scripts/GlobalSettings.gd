extends Node

var SAVE_PATH = "user://config.ini"

var config_file = ConfigFile.new()

var Settings = {
	"Audio": {
		"Master": -40,
		"SFX": -40,
		"Music": -40,
		"Dialog": -40
	},
	"Display": {
		"Resolution": Vector2(1024,600),
		"WindowMode": "Windowed",
		"Vsync": false,
		"FPS": 60,
		"MSAA": 1,
		"HDR": false
	}
}


func _ready():
	load_settings()
	set_Display_Settings()



func set_Display_Settings():
	OS.vsync_enabled = Settings["Display"]["Vsync"]
	OS.window_size = Settings["Display"]["Resolution"]
	get_viewport().hdr = Settings["Display"]["HDR"]
	Engine.set_target_fps(Settings["Display"]["FPS"])
	
	match Settings["Display"]["MSAA"]:
		0:
			get_viewport().msaa = Viewport.MSAA_DISABLED
		1:
			get_viewport().msaa = Viewport.MSAA_2X
		2:
			get_viewport().msaa = Viewport.MSAA_4X
		3:
			get_viewport().msaa = Viewport.MSAA_8X
		4:
			get_viewport().msaa = Viewport.MSAA_16X
	
	match Settings["Display"]["WindowMode"]:
		"Windowed":
			OS.window_fullscreen = false
			OS.window_borderless = false
		"Borderless":
			OS.window_fullscreen = false
			OS.window_borderless = true
		"Fullscreen":
			OS.window_fullscreen = true
			OS.window_borderless = false


func save_settings():
	for section in Settings.keys():
		for key in Settings[section]:
			config_file.set_value(section, key, Settings[section][key])
	config_file.save(SAVE_PATH)


func load_settings():
	var error = config_file.load(SAVE_PATH)
	if error != OK:
		print("Failed loading settings Error code: %s" %error)
		return null
	
	for section in Settings.keys():
		for key in Settings[section]:
			Settings[section][key] = config_file.get_value(section, key, null)
	set_Display_Settings()
