class_name DeflectArea
extends CharacterBody2D

signal touched_ball

func touchDeflect():
	print("k")
	touched_ball.emit()
