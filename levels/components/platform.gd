class_name Platform
extends Node2D

const SHARD_START: int = -60
const SHARD_OFFSET: int = 40
const VELOCITY: int = 10

signal platform_broken()

@export var durability: int = 3 

@onready var image: Sprite2D = $Image
@onready var boundary: StaticBody2D = $Boundary
@onready var thumpAudio: AudioStreamPlayer2D = $ThumpSound

var shardScene: PackedScene = preload("res://levels/components/shard.tscn")
var isBroken: bool = false


func _ready() -> void:
	thumpAudio.volume_db = linear_to_db(0.8)


func _on_detection_body_entered(body:Node2D) -> void:
	if body is Player:
		var player = body as Player
		if player.headFirst:
			break_glass(player.velocity)
		else:
			durability -= 1
			
			if durability <= 0:
				break_glass(player.velocity)
			else:
				player.surfaceForward = global_transform.x.angle()
				thumpAudio.play()



func break_glass(velocity: Vector2) -> void:
	# check for redundant loop
	if isBroken:
		return
	
	# set values 
	isBroken = true
	boundary.visible = false
	platform_broken.emit()
	
	# "animate" image to show broken
	image.frame = 1
	
	# create some shards from the shattering
	for i in 4:
		create_shard(i, velocity)
	
	# almost forgot... play the sound
	create_glass_sfx()


func create_shard(i: int, vel: Vector2) -> void:
	var shard: Shard = shardScene.instantiate()
	call_deferred("add_child", shard)
	
	var x = SHARD_START + SHARD_OFFSET * i
	shard.set_piece(Vector2(x, 0), vel * VELOCITY / abs(x))


func create_glass_sfx() -> void:
	var player = AudioStreamPlayer2D.new()
	add_child(player)
	player.stream = GlassSounds.get_rand_sound()
	player.pitch_scale = 1 + randf_range(-0.1, 0.1)
	player.play()
