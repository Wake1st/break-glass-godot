class_name Platform
extends Node2D

const MAX_DURABILITY: float = 400

signal platform_broken()

@onready var detection:Area2D = $Detection
@onready var boundaryShape:CollisionShape2D = $Boundary/CollisionShape2D

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


func break_glass() -> void:
	set_deferred("boundaryShape.disabled", true)
	platform_broken.emit()
	print("glass broken")
