class_name LevelController
extends Node2D

var stopwatch_enabled: bool = false
var stopwatch: float = 0.0
var stages: PackedFloat32Array = []

func start_stopwatch():
	stopwatch_enabled = true
	stopwatch = 0.0

func _process

