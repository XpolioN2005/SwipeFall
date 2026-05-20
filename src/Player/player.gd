extends Node3D
class_name Player

@export var Cam: Camera3D

# signal tapped(screen_pos: Vector2, world_pos: Vector3)
# signal drag_started(screen_pos: Vector2, world_pos: Vector3)
# signal dragging(screen_pos: Vector2, world_pos: Vector3, relative: Vector2)
# signal drag_ended(screen_pos: Vector2, world_pos: Vector3)

const TAP_MAX_TIME: float = 0.2
const TAP_MAX_MOVE: float = 20.0

var _pointer_id: int = -1
var _start_pos: Vector2 = Vector2.ZERO
var _start_time: float = 0.0
var _is_dragging: bool = false


func _unhandled_input(event: InputEvent) -> void:
    if event is InputEventScreenTouch:
        var e: InputEventScreenTouch = event as InputEventScreenTouch
        if e.pressed:
            _start_input(e.index, e.position)
        else:
            _end_input(e.index, e.position)

    elif event is InputEventScreenDrag:
        var e: InputEventScreenDrag = event as InputEventScreenDrag
        _update_input(e.index, e.position)

    elif event is InputEventMouseButton:
        var e: InputEventMouseButton = event as InputEventMouseButton
        if e.button_index == MOUSE_BUTTON_LEFT:
            if e.pressed:
                _start_input(0, e.position)
            else:
                _end_input(0, e.position)

    elif event is InputEventMouseMotion:
        var e: InputEventMouseMotion = event as InputEventMouseMotion
        _update_input(0, e.position)


func _start_input(index: int, pos: Vector2) -> void:
    _pointer_id = index
    _start_pos = pos
    _start_time = Time.get_ticks_msec() / 1000.0
    _is_dragging = false


func _end_input(index: int, pos: Vector2) -> void:
    if index != _pointer_id:
        return

    var elapsed: float = Time.get_ticks_msec() / 1000.0 - _start_time
    var dist: float = pos.distance_to(_start_pos)

    if _is_dragging:
        # ** DO something --  DRAG ENDS
        pass

    elif elapsed <= TAP_MAX_TIME and dist <= TAP_MAX_MOVE:
        # ** DO something --  tap
        pass

    _reset_state()


func _update_input(index: int, pos: Vector2) -> void:
    if _pointer_id == -1:
        _start_input(index, pos)

    if index != _pointer_id:
        return

    var dist: float = pos.distance_to(_start_pos)

    if not _is_dragging and dist > TAP_MAX_MOVE:
        _is_dragging = true
        # ** DO something - DRAG stared

    if _is_dragging:
        # ** DO something - STILL DRAG 
        pass


func _screen_to_world(screen_pos: Vector2) -> Vector3:
    if Cam == null:
        return Vector3.ZERO

    var from: Vector3 = Cam.project_ray_origin(screen_pos)
    var dir: Vector3 = Cam.project_ray_normal(screen_pos)
    var plane: Plane = Plane(Vector3.UP, 0.0)

    var denom: float = plane.normal.dot(dir)
    if abs(denom) < 0.0001:
        return from

    var t: float = - (plane.normal.dot(from) + plane.d) / denom
    return from + dir * t


func _reset_state() -> void:
    _pointer_id = -1
    _start_pos = Vector2.ZERO
    _start_time = 0.0
    _is_dragging = false
