extends Node2D

const GRAY : Color = Color(0.5, 0.5, 0.5)
const WHITE : Color = Color(1, 1, 1)

enum State {
	Deal,
	Swap,
	Bet,
	Hit,
	Payout,
}

var card_obj = preload("res://Card/card.tscn")

var deck : Array = []
var card_count : int = 0
var state = State.Deal
var selected_card : int = 0
var turn : String = "gangster"
var hit : bool = false
var dealer_stand : bool = false
var stand : int = 0
var timer_on : bool = false

var house_wallet : int = 200
var personal_wallet : int = 0

func _ready():
	randomize()
	
	for patron in $patrons.get_children():
		patron.show_expression("not_looking")
		patron.connect("clicked", self, "patron_clicked")
		patron.connect("hit", self, "patron_hit")
		patron.connect("stand", self, "patron_stand")
		
	$dealer.connect("deal", self, "deal_self")
	
	house_wallet = get_node("/root/Globals").house
	personal_wallet = get_node("/root/Globals").personal
		
	set_deck()
	
	set_top_three()
	de_gayify_the_cards()
	$deal_ui/deck_h_box/first.modulate = WHITE
	
	$base_ui/house_wallet.text = "$" + str(house_wallet)
	$base_ui/personal_wallet.text = "$" + str(personal_wallet)
	
func _process(delta):
	if state == State.Hit and !hit:
		if turn == "dealer":
			return
			
		var patron = $patrons.get_node(turn)
		if patron.bet == 400 and patron.hit_once:
			patron_stand(patron)
		else:
			patron.hit()
	
func set_deck() -> void:
	for i in range(13):
		for j in range(4):
			var card = card_obj.instance()
			card.suit = j
			if i == 12:
				card.value = 11
			elif i >= 9 and i <= 11:
				card.value = 10
			else:
				card.value = i + 2
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
	
func deal_card(patron) -> void:
	var card = deck[selected_card].duplicate()
	card.suit = deck[selected_card].suit
	card.value = deck[selected_card].value
	deck.remove(selected_card)
	patron.get_node("cards").add_child(card)
	card_count += 1
	set_top_three()
	
	update_scores()
	
func patron_clicked(patron : Object) -> void:
	if state == State.Deal:
		match (patron.name):
			"gangster":
				if card_count == 0:
					deal_card(patron)
				elif card_count == 4:
					deal_card(patron)
			"flirt":
				if card_count == 1:
					deal_card(patron)
				elif card_count == 5:
					deal_card(patron)
			"rich":
				if card_count == 2:
					deal_card(patron)
				elif card_count == 6:
					deal_card(patron)
					state = State.Swap
					$deal_ui.hide()
					$swap_ui.show()
					
	elif state == State.Hit and hit:
		if patron.name == turn:
			hit = false
			
			match turn:
				"gangster":
					deal_card($patrons/gangster)
					turn = "flirt"
				"flirt":
					deal_card($patrons/flirt)
					turn = "rich"
				"rich":
					deal_card($patrons/rich)
					turn = "dealer"
				_:
					pass
		
func patron_hit(patron) -> void:
	# patron.bark("hit")
	hit = true
	
	match patron.name:
		"gangster":
			play_audio(get_node("/root/Globals").ozo_talk_sounds)
		"flirt":
			play_audio(get_node("/root/Globals").tippy_talk_sounds)
		"rich":
			play_audio(get_node("/root/Globals").ceo_talk_sounds)
	
func patron_stand(patron) -> void:
	# patron.bark("stand")
	hit = false
	stand += 1
	
	if stand >= 3 and dealer_stand:
		state = State.Payout
		$deal_ui.hide()
		$hit_ui.hide()
		payout()
	else:
		match turn:
			"gangster":
				turn = "flirt"
			"flirt":
				turn = "rich"
			"rich":
				turn = "dealer"
			"dealer":
				turn = "gangster"
			_:
				pass
		
func deal_self() -> void:
	if state == State.Deal:
		if card_count == 3:
			var card = deck[selected_card].duplicate()
			card.suit = deck[selected_card].suit
			card.value = deck[selected_card].value
			deck.remove(selected_card)
			$dealer.get_node("cards").add_child(card)
			set_top_three()
			card_count += 1
			
		elif card_count == 7:
			pass
	elif state == State.Hit and turn == "dealer":
		var card = deck[selected_card].duplicate()
		card.suit = deck[selected_card].suit
		card.value = deck[selected_card].value
		deck.remove(selected_card)
		$dealer.get_node("cards").add_child(card)
		set_top_three()
		turn = "gangster"
		
	update_scores()
		
func payout() -> void:
	var patron_doubled : PoolIntArray = PoolIntArray([])
	var patron_scores : PoolIntArray = PoolIntArray([])
	var winners : PoolStringArray = PoolStringArray([])
	patron_scores.append($patrons/gangster.get_score())
	patron_scores.append($patrons/flirt.get_score())
	patron_scores.append($patrons/rich.get_score())
	patron_doubled.append($patrons/gangster.bet)
	patron_doubled.append($patrons/flirt.bet)
	patron_doubled.append($patrons/rich.bet)
	var dealer_score : int = get_dealer_score()
	
	for i in range(3):
		if dealer_score > 21:
			if patron_scores[i] > 21:
				house_wallet += 200
				if patron_doubled[i] == 400:
					house_wallet += 200
			else:
				match i:
					0:
						winners.append("gangster")
					1:
						winners.append("flirt")
					2:
						winners.append("rich")
		else:
			if patron_scores[i] > 21:
				house_wallet += 200
				if patron_doubled[i] == 400:
					house_wallet += 200
			elif patron_scores[i] > dealer_score:
				house_wallet -= 100
				if patron_doubled[i] == 400:
					house_wallet -= 100
				match i:
					0:
						winners.append("gangster")
					1:
						winners.append("flirt")
					2:
						winners.append("rich")
			else:
				house_wallet += 200
				
	if "gangster" in winners:
		$patrons/gangster.show_expression("win")
	else:
		$patrons/gangster.show_expression("lose")
	if "flirt" in winners:
		$patrons/flirt.show_expression("win")
	else:
		$patrons/flirt.show_expression("lose")
	if "rich" in winners:
		if patron_doubled[2] == 400:
			$patrons/rich.show_expression("win_2")
		else:
			$patrons/rich.show_expression("win")
	else:
		if patron_doubled[2] == 400:
			$patrons/rich.show_expression("lose_2")
		else:
			$patrons/rich.show_expression("lose")
		
	$base_ui/house_wallet.text = "$" + str(house_wallet)
	$base_ui/personal_wallet.text = "$" + str(personal_wallet)
	
	$base_ui/scoreboard_label.text = "Winners:\n"
	
	for winner in winners:
		var winner_name : String = "null"
		
		match winner:
			"gangster":
				winner_name = "Ozo"
				get_node("/root/Globals").ozo_anger = 0
			"flirt":
				winner_name = "Tippy"
				get_node("/root/Globals").tippy_happy += 1
			"rich":
				winner_name = "Fin"
				
		$base_ui/scoreboard_label.text += winner_name + "\n"
	
	$payout_ui.show()
	
	timer_on = true
	$timer.start(2.0)
	$timer.connect("timeout", self, "hide_cards_after_timeout", \
		[ ], CONNECT_ONESHOT)
	
func update_scores() -> void:
	var ozo_score : int = $patrons/gangster.get_score()
	var tippy_score : int = $patrons/flirt.get_score()
	var fin_score : int = $patrons/rich.get_score()
	var dealer_score : int = get_dealer_score()
	
	$base_ui/scoreboard_label.text = "Score:\nOzo: " + \
		str(ozo_score) + "\nTippy: " + str(tippy_score) + \
			"\nFin: " + str(fin_score) + "\n4: " + \
				str(dealer_score)
	
func get_dealer_score() -> int:
	var dealer_score : int = 0
	
	for child in $dealer.get_node("cards").get_children():
		dealer_score += child.value
		
	for child in $dealer.get_node("cards").get_children():
		for grandchild in $dealer.get_node("cards").get_children():
			if child.value == 11 and dealer_score > 21:
				dealer_score -= 10
				
	return dealer_score
	
func play_audio(arr : Array) -> void:
	if $sfx.playing:
		return
		
	var size : int = arr.size()
	$sfx.set_stream(arr[randi() % size - 1])
	$sfx.play()
	
func hide_cards_after_timeout() -> void:
	timer_on = false
	
	for patron in $patrons.get_children():
		patron.get_node("cards").hide()
		
	$dealer/cards.hide()
	
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
	var temp_card = null
	var temp_0 = null
	var temp_1 = null
	
	temp_0 = $patrons/gangster/cards.get_child(0).duplicate()
	temp_0.suit = $patrons/gangster/cards.get_child(0).suit
	temp_0.value = $patrons/gangster/cards.get_child(0).value
	temp_1 = $patrons/gangster/cards.get_child(1).duplicate()
	temp_1.suit = $patrons/gangster/cards.get_child(1).suit
	temp_1.value = $patrons/gangster/cards.get_child(1).value
	
	for child in $patrons/gangster/cards.get_children():
		$patrons/gangster/cards.remove_child(child)
		child.queue_free()
		
	for i in range(2):
		temp_card = $patrons/rich/cards.get_child(i).duplicate()
		temp_card.suit = $patrons/rich/cards.get_child(i).suit
		temp_card.value = $patrons/rich/cards.get_child(i).value
		$patrons/gangster/cards.add_child(temp_card)
	
	for child in $patrons/rich/cards.get_children():
		$patrons/rich/cards.remove_child(child)
		child.queue_free()
		
	for i in range(2):
		temp_card = $patrons/flirt/cards.get_child(i).duplicate()
		temp_card.suit = $patrons/flirt/cards.get_child(i).suit
		temp_card.value = $patrons/flirt/cards.get_child(i).value
		$patrons/rich/cards.add_child(temp_card)
	
	for child in $patrons/flirt/cards.get_children():
		$patrons/flirt/cards.remove_child(child)
		child.queue_free()
		
	$patrons/flirt/cards.add_child(temp_0)
	$patrons/flirt/cards.add_child(temp_1)
	
	update_scores()
	
func _on_dont_swap_button_pressed():
	var card = deck[selected_card].duplicate()
	card.suit = deck[selected_card].suit
	card.value = deck[selected_card].value
	deck.remove(selected_card)
	$dealer.get_node("cards").add_child(card)
	$swap_ui.hide()
	state = State.Bet
	
	for child in $patrons.get_children():
		child.place_bet()
		child.calc_double_down()
		
	state = State.Hit
	for patron in $patrons.get_children():
		patron.show_expression("looking")
	turn = "gangster"
	hit = false
	dealer_stand = false
	stand = 0
	$hit_ui.show()
	$deal_ui.show()
	update_scores()
	
func _on_stand_button_pressed():
	if turn == "dealer":
		dealer_stand = true
		
		if stand >= 3 and dealer_stand:
			state = State.Payout
			$deal_ui.hide()
			$hit_ui.hide()
			payout()
		else:
			match turn:
				"gangster":
					turn = "flirt"
				"flirt":
					turn = "rich"
				"rich":
					turn = "dealer"
				"dealer":
					turn = "gangster"
				_:
					pass
					
func _on_next_round_button_pressed():
	get_node("/root/Globals").house = house_wallet
	get_node("/root/Globals").personal = personal_wallet
	get_node("/root/Globals").roun_d += 1
	get_tree().reload_current_scene()
