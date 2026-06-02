extends Camera3D
class_name PlayerCam

@export var hit_visual_scene: PackedScene = preload("res://Player/Slash/slash.tscn")
@export var canvas: CanvasLayer

const RAY_LENGTH: float = 200.0

func _ready() -> void:
	SignalBus.drag_started.connect(_on_drag_started)

func raycast_from_screen(pos: Vector2) -> Node3D:
	var space_state: PhysicsDirectSpaceState3D = get_world_3d().direct_space_state
	
	var ray_origin: Vector3 = project_ray_origin(pos)
	var ray_end: Vector3 = ray_origin + project_ray_normal(pos) * RAY_LENGTH
	
	var query: PhysicsRayQueryParameters3D = PhysicsRayQueryParameters3D.create(ray_origin, ray_end)
	var result: Dictionary = space_state.intersect_ray(query)
	
	if result.is_empty():
		return null
		
	return result["collider"] as Node3D


func _on_drag_started(_finger: int, pos: Vector2) -> void:
	var hit_isnt: Node = hit_visual_scene.instantiate()
	var hit_visual: Node2D = hit_isnt as Node2D

	if hit_visual == null:
		push_error("hit_visual_scene root must inherit Node2D")
		return

	hit_visual.global_position = pos
	canvas.add_child(hit_visual)
