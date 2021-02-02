extends Tabs



#----------Variables----------

onready var Master_Slider = $Master_Slider
onready var SFX_Slider = $SFX_Slider
onready var Music_Slider = $Music_Slider
onready var Dialog_Slider = $Dialog_Slider

onready var Master_Value = $Master_Value
onready var SFX_Value = $SFX_Value
onready var Music_Value = $Music_Value
onready var Dialog_Value = $Dialog_Value



#----------Functions----------

func _ready():
	apply_audio_settings()


func apply_audio_settings():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), int(GS.Settings["Audio"]["Master"]))
	Master_Slider.value = int(GS.Settings["Audio"]["Master"])
	Master_Value.text = str(80 + int(GS.Settings["Audio"]["Master"]))
	
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), int(GS.Settings["Audio"]["SFX"]))
	SFX_Slider.value = int(GS.Settings["Audio"]["SFX"])
	SFX_Value.text = str(80 + int(GS.Settings["Audio"]["SFX"]))
	
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), int(GS.Settings["Audio"]["Music"]))
	Music_Slider.value = int(GS.Settings["Audio"]["Music"])
	Music_Value.text = str(80 + int(GS.Settings["Audio"]["Music"]))
	
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Dialog"), int(GS.Settings["Audio"]["Dialog"]))
	Dialog_Slider.value = int(GS.Settings["Audio"]["Dialog"])
	Dialog_Value.text = str(80 + int(GS.Settings["Audio"]["Dialog"]))



#----------Signal Actions----------


# Change volume of the Master audio BUS and updates settings

func _on_Master_Slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)
	GS.Settings["Audio"]["Master"] = str(value)
	Master_Value.text = str(80 + value)
	print(AudioServer.get_bus_volume_db(0))



# Change volume of the SFX audio BUS and updates settings

func _on_SFX_Slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), value)
	GS.Settings["Audio"]["SFX"] = str(value)
	$SFX_Value.text = str(80 + value)



# Change volume of the Music audio BUS and updates settings

func _on_Music_Slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)
	GS.Settings["Audio"]["Music"] = str(value)
	Music_Value.text = str(80 + value)



# Change volume of the Dialog audio BUS and updates settings

func _on_Dialog_Slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Dialog"), value)
	GS.Settings["Audio"]["Dialog"] = str(value)
	Dialog_Value.text = str(80 + value)



# Saves Settings

func _on_SaveButton_pressed():
	GS.save_settings()
