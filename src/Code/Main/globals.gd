extends Node

signal has_beaten

var bpm: int


func beating():
	has_beaten.emit()