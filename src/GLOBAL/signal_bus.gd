# Signal bus
extends Node

@warning_ignore_start("unused_signal")

signal touch_pressed(finger: int, position: Vector2)
signal touch_released(finger: int, position: Vector2)

signal tap(finger: int, position: Vector2)

signal drag_started(finger: int, position: Vector2)
signal dragging(finger: int, position: Vector2, delta: Vector2)
signal drag_ended(finger: int, position: Vector2)

signal hold(finger: int, position: Vector2)
signal hold_released(finger: int, position: Vector2)

@warning_ignore_restore("unused_signal")