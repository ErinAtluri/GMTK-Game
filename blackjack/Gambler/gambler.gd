extends Node2D

var cards : Array = []
var score : int = 0
var bet : int = 0
var hit_once : bool = false

var pos_1 : Vector2
var pos_2 : Vector2

signal clicked(gambler)
signal hit(gambler)
signal stand(gambler)

func _ready():
	pos_1 = $positions/pos_1.position
	pos_2 = $positions/pos_2.position
	
func get_score() -> int:
	score = 0
	
	for child in $cards.get_children():
		score += child.value
		
	
	for child in $cards.get_children():
		for grandchild in $cards.get_children():
			if grandchild.value == 11 and score > 21:
				score -= 10
		
	return score
	
func place_bet() -> void:
	$bets.show()
	$bets/bet_2.hide()
	
	$bets/label.text = "$200"
	bet = 200
	
func calc_double_down() -> bool:
	get_score()
	hit_once = false
	
	if score >= 10 and score <= 12:
		$bets/bet_2.show()
		$bets/label.text = "$400"
		bet = 400
		return true
		
	return false
	
func hit() -> void:
	get_score()
	hit_once = true
	
	if score < 16:
		emit_signal("hit", self)
	elif score == 17:
		randomize()
		if randi() % 2 == 0:
			emit_signal("hit", self)
		else:
			emit_signal("stand", self)
	else:
		emit_signal("stand", self)
	
func hide_expressions() -> void:
	for child in $expressions.get_children():
		child.hide()
		
func show_expression(expression : String) -> void:
	if $expressions.has_node(expression):
		hide_expressions()
		$expressions.get_node(expression).show()
		
func bark(dialog : String) -> void:
	pass
	
func _on_button_pressed():
	emit_signal("clicked", self)
