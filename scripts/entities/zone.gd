extends Node2D

enum ZoneType {
	RESIDENTIAL,
	COMMERCIAL,
	INDUSTRIAL
}

@export var zone_type: ZoneType
@export var capacity: int = 1000
@export var current_population: int = 0

var connected_zones: Array = []
var traffic_level: float = 0.0

func _ready():
	# Initialize zone
	pass

func add_population(amount: int) -> int:
	var available_space = capacity - current_population
	var actual_add = min(amount, available_space)
	current_population += actual_add
	return actual_add

func remove_population(amount: int) -> int:
	var actual_remove = min(amount, current_population)
	current_population -= actual_remove
	return actual_remove

func connect_zone(other_zone: Node):
	if not connected_zones.has(other_zone):
		connected_zones.append(other_zone)

func disconnect_zone(other_zone: Node):
	connected_zones.erase(other_zone)

func update_traffic(delta: float):
	# Simple traffic calculation based on population
	traffic_level = float(current_population) / float(capacity)
	
	# Update visual representation of traffic
	update_visuals()

func update_visuals():
	# This will be implemented later to show traffic visually
	pass 