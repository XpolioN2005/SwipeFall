extends Node3D
class_name Player

@export var cam: Camera3D
@export var hit_visual_scene: PackedScene = preload("res://Player/Slash/slash_trail.tscn")
@export var canvas: CanvasLayer

func _ready() -> void:
	SignalBus.drag_started.connect(_on_drag_started)


func _on_drag_started(_finger: int, pos: Vector2) -> void:
	var hit_isnt: Node = hit_visual_scene.instantiate()
	var hit_visual: Node2D = hit_isnt as Node2D

	if hit_visual == null:
		push_error("hit_visual_scene root must inherit Node2D")
		return

	hit_visual.global_position = pos
	canvas.add_child(hit_visual)


func _screen_to_world(screen_pos: Vector2) -> Vector3:
	if cam == null:
		return Vector3.ZERO

	var from: Vector3 = cam.project_ray_origin(screen_pos)
	var dir: Vector3 = cam.project_ray_normal(screen_pos)

	var plane: Plane = Plane(Vector3.UP, 0.0)
	var denom: float = plane.normal.dot(dir)

	if absf(denom) < 0.0001:
		return from

	var t: float = - (plane.normal.dot(from) + plane.d) / denom

	return from + dir * t