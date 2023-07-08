extends Node2D

var pos_1 : Vector2
var pos_2 : Vector2

signal deal

func _ready():
	pos_1 = $positions/pos_1.position
	pos_2 = $positions/pos_2.position
	
func _on_deal_button_pressed():
	emit_signal("deal")
