extends Control

@onready var population_label = $TopBar/Population
@onready var satisfaction_label = $TopBar/Satisfaction
@onready var time_label = $TopBar/Time
@onready var zone_button = $Toolbar/ZoneButton
@onready var road_button = $Toolbar/RoadButton
@onready var upgrade_button = $Toolbar/UpgradeButton

enum Tool {
	NONE,
	ZONE,
	ROAD,
	UPGRADE
}

var current_tool: Tool = Tool.NONE

func _ready():
	# Connecter les signaux des boutons
	zone_button.pressed.connect(_on_zone_button_pressed)
	road_button.pressed.connect(_on_road_button_pressed)
	upgrade_button.pressed.connect(_on_upgrade_button_pressed)

func update_ui(population: int, satisfaction: float, game_time: float):
	population_label.text = "Population: %d" % population
	satisfaction_label.text = "Satisfaction: %.1f%%" % satisfaction
	
	# Convertir le temps en heures:minutes
	var total_seconds = int(game_time)
	var hours = total_seconds / 3600
	var minutes = (total_seconds % 3600) / 60
	time_label.text = "Temps: %d:%02d" % [hours, minutes]

func _on_zone_button_pressed():
	current_tool = Tool.ZONE
	# Ici, nous ajouterons la logique pour placer une zone
	print("Outil Zone sélectionné")

func _on_road_button_pressed():
	current_tool = Tool.ROAD
	# Ici, nous ajouterons la logique pour placer une route
	print("Outil Route sélectionné")

func _on_upgrade_button_pressed():
	current_tool = Tool.UPGRADE
	# Ici, nous ajouterons la logique pour améliorer
	print("Outil Amélioration sélectionné")

func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed:
		match current_tool:
			Tool.ZONE:
				# Logique pour placer une zone
				pass
			Tool.ROAD:
				# Logique pour placer une route
				pass
			Tool.UPGRADE:
				# Logique pour améliorer
				pass 