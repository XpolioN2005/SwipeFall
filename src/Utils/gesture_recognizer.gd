extends Node
class_name GestureRecognizer


@export var tap_max_distance: float = 20.0
@export var tap_max_time: float = 0.25
@export var drag_threshold: float = 12.0
@export var hold_time: float = 0.5

var touches: Dictionary[int, TouchData] = {}


class TouchData:
	var start_position: Vector2
	var current_position: Vector2
	var start_time: float

	var dragging: bool = false
	var hold_triggered: bool = false

	func _init(pos: Vector2, time: float) -> void:
		start_position = pos
		current_position = pos
		start_time = time


func _process(_delta: float) -> void:
	_check_holds()


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		_handle_touch(event as InputEventScreenTouch)

	elif event is InputEventScreenDrag:
		_handle_drag(event as InputEventScreenDrag)


# TOUCH
func _handle_touch(event: InputEventScreenTouch) -> void:
	if event.pressed:
		_on_touch_pressed(event)
	else:
		_on_touch_released(event)


func _on_touch_pressed(event: InputEventScreenTouch) -> void:
	var finger: int = event.index

	touches[finger] = TouchData.new(event.position, _get_time())

	print(
		"Finger %d TOUCH at %s"
		% [finger, event.position]
	)


func _on_touch_released(event: InputEventScreenTouch) -> void:
	var finger: int = event.index

	if not touches.has(finger):
		return

	var data: TouchData = touches[finger]

	var elapsed: float = _get_time() - data.start_time

	var distance: float = data.start_position.distance_to(event.position)

	if data.dragging:
		print(
			"Finger %d DRAG RELEASE at %s"
			% [finger, event.position]
		)

	elif data.hold_triggered:
		print(
			"Finger %d HOLD RELEASE at %s | Held %.2fs"
			% [finger, event.position, elapsed]
		)

	elif _is_tap(elapsed, distance):
		print(
			"Finger %d TAP at %s"
			% [finger, event.position]
		)

	touches.erase(finger)


# DRAG
func _handle_drag(event: InputEventScreenDrag) -> void:
	var finger: int = event.index

	if not touches.has(finger):
		return

	var data: TouchData = touches[finger]

	var previous_position: Vector2 = (data.current_position)

	data.current_position = event.position

	var moved_distance: float = (data.start_position.distance_to(event.position))

	_try_start_drag(finger, data, moved_distance)

	if data.dragging:
		var delta: Vector2 = (event.position - previous_position)

		print(
			"Finger %d DRAGGING | Pos: %s | Delta: %s"
			% [finger, event.position, delta]
		)


func _try_start_drag(finger: int, data: TouchData, moved_distance: float) -> void:
	if data.dragging:
		return

	if data.hold_triggered:
		return

	if moved_distance < drag_threshold:
		return

	data.dragging = true

	print(
		"Finger %d DRAG START at %s"
		% [finger, data.start_position]
	)


# HOLD
func _check_holds() -> void:
	var current_time: float = _get_time()

	for finger: int in touches.keys():
		var data: TouchData = touches[finger]

		if _can_trigger_hold(data, current_time):
			data.hold_triggered = true

			print(
				"Finger %d HOLD at %s"
				% [finger, data.current_position]
			)


func _can_trigger_hold(data: TouchData, current_time: float) -> bool:
	if data.dragging:
		return false

	if data.hold_triggered:
		return false

	var elapsed: float = (current_time - data.start_time)

	var distance: float = (data.start_position.distance_to(data.current_position))

	return (
		elapsed >= hold_time
		and distance <= drag_threshold
	)


# HELPERS
func _is_tap(elapsed: float, distance: float) -> bool:
	return (
		elapsed <= tap_max_time
		and distance <= tap_max_distance
	)

func _get_time() -> float:
	return Time.get_ticks_msec() / 1000.0

func _reset() -> void:
	touches.clear()