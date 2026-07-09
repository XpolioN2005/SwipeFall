extends Node2D
class_name PlayerAtk

@export var line: Line2D
@export var area: Area2D

@export var point_distance_threshold: float = 10.0
@export var minimum_points_while_dragging: int = 2

@export var lifetime: float = 1.0
@export var decay_rate: float = 0.01
@export var default_decay_delay: float = 0.5

var is_slash: bool = false
var finger_id: int

const MAX_POINTS: int = 200

var drag_ended: bool = false
var decay_running: bool = false
var decay_delay: float = 0.0

@onready var curve: Curve2D = Curve2D.new()

var player_cam: PlayerCam


func _ready() -> void:
	curve.clear_points()
	line.clear_points()

	player_cam = get_viewport().get_camera_3d() as PlayerCam

	_raycast(global_position)
	
	if is_slash:
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

	if not is_slash:
		drag_ended = true

	if not decay_running:
		_decay()


func _on_dragging(finger: int, pos: Vector2, _delta: Vector2) -> void:
	if finger_id != finger:
		return
		
	if drag_ended:
		return

	var local_pos: Vector2 = to_local(pos)

	area.position = local_pos

	if curve.point_count > 0:
		var last_point: Vector2 = curve.get_point_position(curve.point_count - 1)

		if last_point.distance_to(local_pos) < point_distance_threshold:
			return

	# Delay decay so new points can accumulate.
	if decay_running and curve.point_count < minimum_points_while_dragging:
		decay_delay = default_decay_delay

	curve.add_point(local_pos)

	_raycast(pos)

	if curve.point_count > MAX_POINTS:
		curve.remove_point(0)

	_update_line()

func _on_drag_ended(finger: int, _position: Vector2) -> void:
	if finger_id != finger:
		return
	drag_ended = true

func _update_line() -> void:
	line.points = curve.get_baked_points()


func _decay() -> void:
	decay_running = true

	while true:
		if decay_delay > 0.0:
			await get_tree().create_timer(decay_delay).timeout
			decay_delay = 0.0
			
		if curve.point_count > 0:
			curve.remove_point(0)
			_update_line()

		if curve.point_count == 0 and drag_ended:
			break

		await get_tree().create_timer(decay_rate).timeout

	decay_running = false
	queue_free()

func _raycast(pos: Vector2) -> void:
	if player_cam:
		var hit: Node3D = player_cam.raycast_from_screen(pos)
		print(hit)