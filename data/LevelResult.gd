class_name LevelResult

const MAX_TIME: float = 52
const GLASS_MULTIPLIER: int = 100
const TIME_MULTIPLIER: int = 1000

var glass: int
var time: float
var score: float


func _init(g: float, t: float) -> void:
	glass = g
	time = t
	
	score = glass * GLASS_MULTIPLIER + time/MAX_TIME * TIME_MULTIPLIER
