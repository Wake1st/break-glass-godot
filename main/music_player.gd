class_name MusicPlayer
extends AudioStreamPlayer


enum MUSIC {
	BASE,
	LEVEL,
}


@onready var levelStream: AudioStreamOggVorbis = preload("res://assets/music/BreakGlass-Level.ogg")
@onready var baseStream: AudioStreamOggVorbis = preload("res://assets/music/BreakGlass-Base.ogg")


func play_music(music: MUSIC) -> void:
	match music:
		MUSIC.BASE: stream = baseStream
		MUSIC.LEVEL: stream = levelStream
	
	play()


func _ready() -> void:
	volume_db = linear_to_db(0.4)
