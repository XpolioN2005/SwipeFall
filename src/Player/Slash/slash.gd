extends Node2D
class_name SlashTrail

@export var line: Line2D
@export var area: Area2D

@export var point_distance_threshold: float = 10.0
@export var lifetime: float = 1.0
@export var decay_rate: float = 0.01

const MAX_POINTS: int = 200

var is_active: bool = true

@onready var curve: Curve2D = Curve2D.new()

var player_cam: PlayerCam


func _ready() -> void:
	curve.clear_points()
	line.clear_points()

	player_cam = get_viewport().get_camera_3d() as PlayerCam

	SignalBus.dragging.connect(_on_dragging)
	SignalBus.drag_ended.connect(_on_drag_ended)

	_start_lifetime()


func _exit_tree() -> void:
	if SignalBus.dragging.is_connected(_on_dragging):
		SignalBus.dragging.disconnect(_on_dragging)

	if SignalBus.drag_ended.is_connected(_on_drag_ended):
		SignalBus.drag_ended.disconnect(_on_drag_ended)


func _start_lifetime() -> void:
	await get_tree().create_timer(lifetime).timeout

	_decay()


func _on_drag_ended(_finger: int, _position: Vector2) -> void:
	is_active = false


func _on_dragging(_finger: int, pos: Vector2, _delta: Vector2) -> void:
	if not is_active:
		return

	var local_pos: Vector2 = to_local(pos)

	if curve.point_count > 0:
		var last_point: Vector2 = curve.get_point_position(curve.point_count - 1)

		if last_point.distance_to(local_pos) < point_distance_threshold:
			return

	area.position = local_pos

	if player_cam:
		var hit: Node3D = player_cam.raycast_from_screen(pos)
		print(hit)

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

	queue_free()