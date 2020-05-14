extends Node2D

export var member: PackedScene


func setup(
	linear_speed_max: float,
	linear_accel_max: float,
	proximity_radius: float,
	separation_decay_coefficient: float,
	cohesion_strength: float,
	separation_strength: float,
	show_proximity_radius: bool
) -> void:
	var followers := []
	for i in range(19):
		var follower := member.instance()
		add_child(follower)
		follower.position += Vector2(rand_range(-60, 60), rand_range(-60, 60))
		followers.append(follower)
		follower.setup(
			linear_speed_max,
			linear_accel_max,
			proximity_radius,
			separation_decay_coefficient,
			cohesion_strength,
			separation_strength
		)
		if i == 0 and show_proximity_radius:
			follower.draw_proximity = true
			follower.update()
	var agents := []
	for i in followers:
		agents.append(i.agent)
	for i in followers:
		i.proximity.agents = agents


func set_linear_speed_max(value: float) -> void:
	for child in get_children():
		child.agent.linear_speed_max = value


func set_linear_accel_max(value: float) -> void:
	for child in get_children():
		child.agent.linear_acceleration_max = value


func set_proximity_radius(value: float) -> void:
	for child in get_children():
		child.proximity.radius = value
		if child == get_child(0):
			child.update()


func set_show_proximity_radius(value: bool) -> void:
	get_child(0).draw_proximity = value
	get_child(0).update()


func set_separation_decay_coef(value: float) -> void:
	for child in get_children():
		child.separation.decay_coefficient = value


func set_cohesion_strength(value: float) -> void:
	for child in get_children():
		child.blend.get_behavior_at(1).weight = value


func set_separation_strength(value: float) -> void:
	for child in get_children():
		child.blend.get_behavior_at(0).weight = value
