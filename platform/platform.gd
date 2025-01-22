class_name Platform
extends Node2D

const MAX_DURABILITY: float = 400

signal platform_broken()

@onready var detection:Area2D = $Detection
@onready var boundary:StaticBody2D = $Boundary

var durability:float = MAX_DURABILITY


func _on_detection_body_entered(body:Node2D) -> void:
	if body is Player:
		var player = body as Player
		if player.headFirst:
			break_glass()
		else:
			durability -= player.velocity.length()

			if durability < 0:
				break_glass()
			else:
				player.surfaceForward = global_transform.x.angle()



func break_glass() -> void:
	# boundary.call_deferred("queue_free")
	platform_broken.emit()
	print("glass broken")
