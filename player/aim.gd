class_name Aim
extends Node2D

const MAX_MAGNITUDE: float = 6
const MAGNITUDE_RATE: float = 15

@onready var target: Sprite2D = $Target

var aimAt: Vector2 = Vector2(48,0)
var magnitude: float = 0

var isIncreasing: bool = true


func launch() -> Vector2:
    var impulse = aimAt.normalized() * magnitude

    # reset the values
    aimAt = Vector2(48,0)
    magnitude = 0
    target.frame = 0

    return impulse


func update(delta: float, point: Vector2) -> void:
    # update the aimAt
    aimAt = point

    # update the magnitude
    var delta_magnitude = MAGNITUDE_RATE * delta
    if isIncreasing:
        var adjusted_magnitude = magnitude + delta_magnitude

        if adjusted_magnitude > MAX_MAGNITUDE:
            var remainder = adjusted_magnitude - MAX_MAGNITUDE
            magnitude = MAX_MAGNITUDE - remainder
            
            isIncreasing = false
        else:
            magnitude += delta_magnitude
    else:
        var adjusted_magnitude = magnitude - delta_magnitude

        if adjusted_magnitude < 0:
            var remainder = 0 - adjusted_magnitude
            magnitude = remainder

            isIncreasing = true
        else:
            magnitude -= delta_magnitude
    
    
    # point arrow
    look_at(point);

    # animate magnitude
    target.frame = round(magnitude)
