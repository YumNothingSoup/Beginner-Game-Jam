class_name DeflectArea
extends CharacterBody2D

signal touched_ball

func touchDeflect():
	touched_ball.emit()
