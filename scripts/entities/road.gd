extends Node2D

enum RoadType {
	ONE_LANE,
	ONE_LANE_WITH_BIKE,
	TWO_LANES,
	TWO_LANES_WITH_BIKE,
	THREE_LANES,
	THREE_LANES_WITH_BIKE,
	FOUR_LANES,
	FOUR_LANES_WITH_BIKE,
	FIVE_LANES,
	SIX_LANES
}

@export var road_type: RoadType = RoadType.ONE_LANE
@export var start_point: Vector2
@export var end_point: Vector2
@export var speed_limit: float = 50.0  # km/h

var vehicles: Array = []
var traffic_jam_length: float = 0.0
var average_speed: float = 0.0

func _ready():
	# Initialize road
	update_visuals()

func _process(delta):
	update_traffic(delta)
	update_visuals()

func update_traffic(delta: float):
	# Calculate average speed
	var total_speed = 0.0
	for vehicle in vehicles:
		total_speed += vehicle.speed
	
	if vehicles.size() > 0:
		average_speed = total_speed / vehicles.size()
	else:
		average_speed = speed_limit
	
	# Calculate traffic jam length
	# Simple formula: more vehicles = longer traffic jam
	traffic_jam_length = max(0.0, (1.0 - (average_speed / speed_limit)) * length())

func length() -> float:
	return start_point.distance_to(end_point)

func add_vehicle(vehicle: Node):
	if not vehicles.has(vehicle):
		vehicles.append(vehicle)

func remove_vehicle(vehicle: Node):
	vehicles.erase(vehicle)

func can_upgrade() -> bool:
	return road_type < RoadType.SIX_LANES

func upgrade():
	if can_upgrade():
		road_type += 1
		update_visuals()

func update_visuals():
	# This will be implemented later to show road and traffic visually
	pass 