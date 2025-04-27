extends Node2D

# Game state
var population: int = 0
var satisfaction: float = 100.0
var game_time: float = 0.0
var election_timer: float = 0.0
var election_interval: float = 10800.0  # 3 heures en secondes

@onready var game_ui = $UI/GameUI

# Called when the node enters the scene tree for the first time.
func _ready():
	# Initialize game state
	population = 1000
	satisfaction = 100.0
	game_time = 0.0
	election_timer = 0.0
	
	# Update UI
	update_ui()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Update game time
	game_time += delta
	election_timer += delta
	
	# Check for elections
	if election_timer >= election_interval:
		check_elections()
		election_timer = 0.0
	
	# Update UI
	update_ui()

# Update UI with current game state
func update_ui():
	game_ui.update_ui(population, satisfaction, game_time)

# Check if player wins or loses elections based on satisfaction
func check_elections():
	if satisfaction < 30.0:  # Threshold to be adjusted
		end_game("Vous avez perdu les élections ! La satisfaction des habitants est trop basse.")
	else:
		print("Élections réussies ! Satisfaction actuelle : ", satisfaction)

# End the game with a message
func end_game(message: String):
	print(message)
	# Here we'll add proper game over handling later
	get_tree().paused = true

# Update population based on satisfaction
func update_population():
	var growth_rate = satisfaction / 100.0
	population += int(growth_rate * 10)  # Adjust growth rate as needed

# Update satisfaction based on traffic
func update_satisfaction(traffic_jam_kilometers: float):
	# Simple formula to be refined
	satisfaction = max(0.0, 100.0 - (traffic_jam_kilometers * 2.0)) 