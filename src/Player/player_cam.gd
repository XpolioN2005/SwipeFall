extends Camera3D
class_name PlayerCam

@export var hit_visual_scene: PackedScene = preload("res://Player/Atk/player_atk.tscn")
@export var canvas: CanvasLayer

const RAY_LENGTH: float = 200.0

func _ready() -> void:
	SignalBus.drag_started.connect(_on_drag_started)
	SignalBus.tap.connect(_on_tap)

func raycast_from_screen(pos: Vector2) -> Node3D:
	var space_state: PhysicsDirectSpaceState3D = get_world_3d().direct_space_state
	
	var ray_origin: Vector3 = project_ray_origin(pos)
	var ray_end: Vector3 = ray_origin + project_ray_normal(pos) * RAY_LENGTH
	
	var query: PhysicsRayQueryParameters3D = PhysicsRayQueryParameters3D.create(ray_origin, ray_end)
	var result: Dictionary = space_state.intersect_ray(query)
	
	if result.is_empty():
		return null
		
	return result["collider"] as Node3D

func _add_visual(finger: int, pos: Vector2, slash: bool) -> PlayerAtk:
	var hit_inst: Node = hit_visual_scene.instantiate()
	var hit_obj: PlayerAtk = hit_inst as PlayerAtk

	if hit_obj == null:
		push_error("hit_visual_scene root must inherit PlayerAtk")
		if hit_inst:
			hit_inst.queue_free()
		return null

	hit_obj.global_position = pos
	hit_obj.finger_id = finger
	hit_obj.is_slash = slash

	canvas.add_child(hit_obj)

	return hit_obj


func _on_drag_started(finger: int, pos: Vector2) -> void:
	_add_visual(finger, pos, true)


func _on_tap(finger: int, pos: Vector2) -> void:
	_add_visual(finger, pos, false)