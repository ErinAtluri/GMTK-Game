extends Node2D

const GRAY : Color = Color(0.5, 0.5, 0.5)
const WHITE : Color = Color(1, 1, 1)

enum State {
	Deal,
	Swap,
	Bet,
}

var card_obj = preload("res://Card/card.tscn")

var deck : Array = []
var card_count : int = 0
var state = State.Deal
var selected_card : int = 0

var house_wallet : int = 200
var personal_wallet : int = 0

func _ready():
	randomize()
	
	for patron in $patrons.get_children():
		patron.connect("clicked", self, "patron_clicked")
		
	$dealer.connect("deal", self, "deal_self")
		
	set_deck()
	
	set_top_three()
	de_gayify_the_cards()
	$deal_ui/deck_h_box/first.modulate = WHITE
	
func _process(delta):
	pass
	
func set_deck() -> void:
	for i in range(13):
		for j in range(4):
			var card = card_obj.instance()
			card.suit = j
			card.value = i
			card.get_node("sprite").texture = \
				load("res://Assets/Cards/" + str(j) + "_" + \
					str(i) + ".png")
			deck.append(card)
			
	deck.shuffle()
	
func set_top_three() -> void:
	$deal_ui/deck_h_box/first.texture = deck[0].get_node("sprite").texture
	$deal_ui/deck_h_box/second.texture = deck[1].get_node("sprite").texture
	$deal_ui/deck_h_box/third.texture = deck[2].get_node("sprite").texture
	
func de_gayify_the_cards() -> void:
	$deal_ui/deck_h_box/first.modulate = GRAY
	$deal_ui/deck_h_box/second.modulate = GRAY
	$deal_ui/deck_h_box/third.modulate = GRAY
	
func deal_card(patron, position : Vector2) -> void:
	var card = deck[selected_card].duplicate()
	if card_count <= 3:
		card.position = patron.pos_1
	else:
		card.position = patron.pos_2
	deck.remove(selected_card)
	patron.get_node("cards").add_child(card)
	card_count += 1
	set_top_three()
			
func patron_clicked(patron : Object) -> void:
	if state != State.Deal:
		return
		
	match (patron.name):
		"gangster":
			if card_count == 0:
				deal_card(patron, patron.pos_1)
			elif card_count == 4:
				deal_card(patron, patron.pos_2)
		"rich":
			if card_count == 1:
				deal_card(patron, patron.pos_1)
			elif card_count == 5:
				deal_card(patron, patron.pos_2)
		"flirt":
			if card_count == 2:
				deal_card(patron, patron.pos_1)
			elif card_count == 6:
				deal_card(patron, patron.pos_2)
				state = State.Swap
				$deal_ui.hide()
				$swap_ui.show()
		
func deal_self() -> void:
	if state != State.Deal:
		return
		
	if card_count == 3:
		var card = deck[selected_card].duplicate()
		card.position = $dealer.pos_1
		deck.remove(selected_card)
		$dealer.get_node("cards").add_child(card)
		set_top_three()
		card_count += 1
		
	elif card_count == 7:
		pass
	
func _on_first_button_pressed():
	de_gayify_the_cards()
	$deal_ui/deck_h_box/first.modulate = WHITE
	selected_card = 0
	
func _on_second_button_pressed():
	de_gayify_the_cards()
	$deal_ui/deck_h_box/second.modulate = WHITE
	selected_card = 1
	
func _on_third_button_pressed():
	de_gayify_the_cards()
	$deal_ui/deck_h_box/third.modulate = WHITE
	selected_card = 2
	
func _on_swap_button_pressed():
	var temp_0 = null
	var temp_1 = null
	
	temp_0 = $patrons/gangster/cards.get_child(0).duplicate()
	temp_1 = $patrons/gangster/cards.get_child(1).duplicate()
	
	for child in $patrons/gangster/cards.get_children():
		$patrons/gangster/cards.remove_child(child)
		child.queue_free()
		
	$patrons/gangster/cards.add_child($patrons/flirt/cards.get_child(0).duplicate())
	$patrons/gangster/cards.add_child($patrons/flirt/cards.get_child(1).duplicate())
	
	
	for child in $patrons/flirt/cards.get_children():
		$patrons/flirt/cards.remove_child(child)
		child.queue_free()
		
	$patrons/flirt/cards.add_child($patrons/rich/cards.get_child(0).duplicate())
	$patrons/flirt/cards.add_child($patrons/rich/cards.get_child(1).duplicate())
	
	for child in $patrons/rich/cards.get_children():
		$patrons/rich/cards.remove_child(child)
		child.queue_free()
		
	$patrons/rich/cards.add_child(temp_0)
	$patrons/rich/cards.add_child(temp_1)
	
func _on_dont_swap_button_pressed():
	var card = deck[selected_card].duplicate()
	card.position = $dealer.pos_2
	deck.remove(selected_card)
	$dealer.get_node("cards").add_child(card)
	$swap_ui.hide()
	state = State.Bet
