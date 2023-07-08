extends Node2D

var cards : Array = []
var score : int = 0

var pos_1 : Vector2
var pos_2 : Vector2

signal clicked(gambler)

func _ready():
	pos_1 = $positions/pos_1.position
	pos_2 = $positions/pos_2.position
	
func place_bet():
	$bets.show()

func _on_button_pressed():
	emit_signal("clicked", self)
