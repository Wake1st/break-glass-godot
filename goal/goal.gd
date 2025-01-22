class_name Goal
extends Area2D

signal finished()


func _on_body_entered(body:Node2D) -> void:
	if body is Player:
		finished.emit()

