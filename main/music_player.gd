class_name MusicPlayer
extends AudioStreamPlayer


enum MUSIC {
	BASE,
	LEVEL,
}


@onready var levelStream: AudioStreamOggVorbis = preload("res://assets/music/BreakGlass-Level.ogg")
@onready var baseStream: AudioStreamOggVorbis = preload("res://assets/music/BreakGlass-Base.ogg")

var loop: bool


func play_music(music: MUSIC) -> void:
	match music:
		MUSIC.BASE: 
			stream = baseStream
			loop = true
		MUSIC.LEVEL: 
			stream = levelStream
			loop = false
	
	play()


func _ready() -> void:
	volume_db = linear_to_db(0.4)


func _on_finished():
	if loop:
		play()
