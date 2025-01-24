class_name FallBoundary
extends Area2D

signal passed_fall_boundary()


func _on_body_entered(body:Node2D) -> void:
	if body is Player:
		passed_fall_boundary.emit()

