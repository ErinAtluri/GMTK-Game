extends Node

var house : int = 200
var personal : int = 0
var roun_d : int = 0

var ceo_talk_sounds : Array = []
var ceo_win_sounds : Array = []
var ozo_talk_sounds : Array = []
var ozo_win_sounds : Array = []
var tippy_talk_sounds : Array = []
var tippy_win_sounds : Array = []

func _ready():
	ceo_talk_sounds.append(load("res://Assets/Audio/CEO Talk Sounds/CEOtalk1final.wav"))
	ceo_talk_sounds.append(load("res://Assets/Audio/CEO Talk Sounds/CEOtalk2final.wav"))
	ceo_talk_sounds.append(load("res://Assets/Audio/CEO Talk Sounds/CEOtalk3final.wav"))
	
	ceo_win_sounds.append(load("res://Assets/Audio/CEO Win Sounds/CEOwin1final.wav"))
	ceo_win_sounds.append(load("res://Assets/Audio/CEO Win Sounds/CEOwin2final.wav"))
	
	
