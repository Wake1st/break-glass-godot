class_name Tutorials
extends Control


enum TIP {
	NONE,
	LAUNCH,
	FLIP,
	BACK
}


const DURATION: float = 0.3
const SLOW_SPEED: float = 0.001

@onready var tipLanch: Panel = $Tip_Launch
@onready var tipFlip: Panel = $Tip_Flip
@onready var tipBack: Panel = $Tip_FlipBack

var isFirstPlaythrough: bool = true
var readyFlipTip: bool
var timeTween: Tween


func run_tip(tip: TIP) -> void:
	match tip:
		TIP.LAUNCH: tipLanch.visible = true
		TIP.FLIP: readyFlipTip = true


func show_flip() -> void:
	tipFlip.visible = true


func _input(event: InputEvent) -> void:
	if isFirstPlaythrough:
		if event.is_action_released("aim") and tipLanch.visible:
			tipLanch.visible = false

		elif event.is_action_released("aim") and readyFlipTip:
			timeTween = create_tween()
			timeTween.tween_property(Engine, "time_scale", SLOW_SPEED, DURATION)
			timeTween.set_ease(Tween.EASE_OUT)
			timeTween.tween_callback(show_flip)

		elif event.is_action_released("flip") and tipFlip.visible:
			tipFlip.visible = false
			tipBack.visible = true

		elif event.is_action_released("flip") and tipBack.visible:
			tipBack.visible = false
			isFirstPlaythrough = false

			timeTween = create_tween()
			timeTween.tween_property(Engine, "time_scale", 1, DURATION * SLOW_SPEED)
			timeTween.set_ease(Tween.EASE_IN)
