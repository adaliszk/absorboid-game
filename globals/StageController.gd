class_name StageController
extends Node2D

signal stage_begin
signal stage_success
signal stage_failure
signal stage_end


func trigger_begin(_event):
	stage_begin.emit()


func trigger_failure(_event):
	stage_failure.emit()
	stage_end.emit()


func trigger_success(_event):
	stage_success.emit()
	stage_end.emit()

