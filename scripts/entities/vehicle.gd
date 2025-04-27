extends Node2D

enum VehicleType {
	CAR,
	BUS,
	BIKE
}

@export var vehicle_type: VehicleType
@export var max_speed: float = 50.0  # km/h
@export var acceleration: float = 2.0  # m/s²
@export var braking: float = 4.0  # m/s²

var speed: float = 0.0
var current_road: Node = null
var position_on_road: float = 0.0  # 0 to 1
var destination: Vector2
var origin: Vector2

func _ready():
	# Initialize vehicle
	pass

func _process(delta):
	update_position(delta)

func update_position(delta: float):
	if current_road:
		# Simple movement along the road
		var target_speed = max_speed
		
		# Check for vehicles ahead
		var distance_to_next = check_distance_to_next_vehicle()
		if distance_to_next < 50.0:  # 50 meters safety distance
			target_speed = 0.0
		elif distance_to_next < 100.0:
			target_speed = max_speed * 0.5
		
		# Adjust speed
		if speed < target_speed:
			speed = min(speed + acceleration * delta, target_speed)
		else:
			speed = max(speed - braking * delta, target_speed)
		
		# Update position
		position_on_road += (speed / 3.6) * delta / current_road.length()
		if position_on_road >= 1.0:
			reach_destination()
		
		# Update visual position
		update_visual_position()

func check_distance_to_next_vehicle() -> float:
	if not current_road:
		return INF
	
	var min_distance = INF
	for vehicle in current_road.vehicles:
		if vehicle != self and vehicle.position_on_road > position_on_road:
			var distance = (vehicle.position_on_road - position_on_road) * current_road.length()
			min_distance = min(min_distance, distance)
	
	return min_distance

func update_visual_position():
	if current_road:
		var direction = current_road.end_point - current_road.start_point
		position = current_road.start_point + direction * position_on_road
		rotation = direction.angle()

func reach_destination():
	# Handle reaching destination
	if current_road:
		current_road.remove_vehicle(self)
		current_road = null
		# Here we'll add logic to find next road or end journey 