extends Node2D
class_name SlashTrail

@export var line: Line2D
@export var area: Area2D

@export var point_distance_threshold: float = 10.0
@export var lifetime: float = 1.0
@export var decay_rate: float = 0.01

const MAX_POINTS: int = 200

@onready var curve: Curve2D = Curve2D.new()


func _ready() -> void:
	curve.clear_points()
	line.clear_points()

	SignalBus.dragging.connect(_on_dragging)
	_start_lifetime()


func _exit_tree() -> void:
	if SignalBus.dragging.is_connected(_on_dragging):
		SignalBus.dragging.disconnect(_on_dragging)


func _start_lifetime() -> void:
	await get_tree().create_timer(lifetime).timeout

	_decay()


func _on_dragging(_finger: int, pos: Vector2, _delta: Vector2) -> void:
	var local_pos: Vector2 = to_local(pos)

	if curve.point_count == 0:
		curve.add_point(local_pos)
		_update_line()
		return

	var last_point: Vector2 = curve.get_point_position(curve.point_count - 1)

	area.position = local_pos

	if last_point.distance_to(local_pos) < point_distance_threshold:
		return

	curve.add_point(local_pos)

	if curve.point_count > MAX_POINTS:
		curve.remove_point(0)

	_update_line()


func _update_line() -> void:
	line.points = curve.get_baked_points()


func _decay() -> void:
	while curve.point_count > 0:
		curve.remove_point(0)
		_update_line()

		await get_tree().create_timer(decay_rate).timeout

	_exit_tree()
	queue_free()
