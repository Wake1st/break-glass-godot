class_name GlassSounds

static var streams: Dictionary = {
	0: preload("res://assets/sfx/glass/SFX_Break_Window_10.wav"),
	1: preload("res://assets/sfx/glass/SFX_Break_Window_01.wav"),
	2: preload("res://assets/sfx/glass/SFX_Break_Window_02.wav"),
	3: preload("res://assets/sfx/glass/SFX_Break_Window_03.wav"),
	4: preload("res://assets/sfx/glass/SFX_Break_Window_04.wav"),
	5: preload("res://assets/sfx/glass/SFX_Break_Window_05.wav"),
	6: preload("res://assets/sfx/glass/SFX_Break_Window_06.wav"),
	7: preload("res://assets/sfx/glass/SFX_Break_Window_07.wav"),
	8: preload("res://assets/sfx/glass/SFX_Break_Window_08.wav"),
	9: preload("res://assets/sfx/glass/SFX_Break_Window_09.wav"),
}


static func get_rand_sound() -> AudioStream:
	var index = randi() % 10
	return streams[index]
