extends Node

export (float, 0, 3200, 100) var linear_speed_max := 800.0 setget set_linear_speed_max
export (float, 0, 10000, 100) var linear_acceleration_max := 80.0 setget set_linear_acceleration_max
export (float, 0, 100, 0.1) var arrival_tolerance := 25.0 setget set_arrival_tolerance
export (float, 0, 500, 10) var deceleration_radius := 125.0 setget set_deceleration_radius

onready var arriver := $Arriver
onready var target_drawer := $TargetDrawer


func _ready() -> void:
	arriver.setup(linear_speed_max, linear_acceleration_max, arrival_tolerance, deceleration_radius)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		arriver.target.position = Vector3(event.position.x, event.position.y, 0)
		target_drawer.update()


func set_arrival_tolerance(value: float) -> void:
	arrival_tolerance = value
	if not is_inside_tree():
		return

	arriver.arrive.arrival_tolerance = value


func set_deceleration_radius(value: float) -> void:
	deceleration_radius = value
	if not is_inside_tree():
		return

	arriver.arrive.deceleration_radius = value


func set_linear_speed_max(value: float) -> void:
	linear_speed_max = value
	if not is_inside_tree():
		return

	arriver.agent.linear_speed_max = value


func set_linear_acceleration_max(value: float) -> void:
	linear_acceleration_max = value
	if not is_inside_tree():
		return

	arriver.agent.linear_acceleration_max = value
