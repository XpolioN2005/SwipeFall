extends Node3D
class_name Player

@export var Cam: Camera3D


func _screen_to_world(screen_pos: Vector2) -> Vector3:
	if Cam == null:
		return Vector3.ZERO

	var from: Vector3 = Cam.project_ray_origin(screen_pos)
	var dir: Vector3 = Cam.project_ray_normal(screen_pos)

	var plane: Plane = Plane(Vector3.UP, 0.0)
	var denom: float = plane.normal.dot(dir)

	if abs(denom) < 0.0001:
		return from

	var t: float = (- (plane.normal.dot(from) + plane.d) / denom)

	return from + dir * t