extends Node

var house : int = 200
var personal : int = 0
var tips : int = 0

var roun_d : int = 0
var letter_shown : bool = false
var day_start : bool = false

var ozo_anger : int = 0
var tippy_happy : int = 0

var ceo_talk_sounds : Array = []
var ceo_win_sounds : Array = []
var ozo_talk_sounds : Array = []
var ozo_win_sounds : Array = []
var tippy_talk_sounds : Array = []
var tippy_win_sounds : Array = []

var deal
var kaching
var growl
var swap
var win

func _ready():
	ceo_talk_sounds.append(load("res://Assets/Audio/CEO Talk Sounds/CEOtalk1final.wav"))
	ceo_talk_sounds.append(load("res://Assets/Audio/CEO Talk Sounds/CEOtalk2final.wav"))
	ceo_talk_sounds.append(load("res://Assets/Audio/CEO Talk Sounds/CEOtalk3final.wav"))
	
	ceo_win_sounds.append(load("res://Assets/Audio/CEO Win Sounds/CEOwin1final.wav"))
	ceo_win_sounds.append(load("res://Assets/Audio/CEO Win Sounds/CEOwin2final.wav"))
	
	ozo_talk_sounds.append(load("res://Assets/Audio/Ozo Talk Sounds/Ozo_1.wav"))
	ozo_talk_sounds.append(load("res://Assets/Audio/Ozo Talk Sounds/Ozo_2.wav"))
	ozo_talk_sounds.append(load("res://Assets/Audio/Ozo Talk Sounds/Ozo_3.wav"))
	ozo_talk_sounds.append(load("res://Assets/Audio/Ozo Talk Sounds/Ozo_5.wav"))
	ozo_talk_sounds.append(load("res://Assets/Audio/Ozo Talk Sounds/Ozo_6.wav"))
	ozo_talk_sounds.append(load("res://Assets/Audio/Ozo Talk Sounds/Ozo_7.wav"))
	ozo_talk_sounds.append(load("res://Assets/Audio/Ozo Talk Sounds/Ozo_9.wav"))
	ozo_talk_sounds.append(load("res://Assets/Audio/Ozo Talk Sounds/Ozo_10.wav"))
	
	ozo_win_sounds.append(load("res://Assets/Audio/Ozo Win Sounds/OzoWin1Final.wav"))
	ozo_win_sounds.append(load("res://Assets/Audio/Ozo Win Sounds/OzoWin2Final.wav"))
	
	tippy_talk_sounds.append(load("res://Assets/Audio/Tippy Talk Sounds/tippytalk1.wav"))
	tippy_talk_sounds.append(load("res://Assets/Audio/Tippy Talk Sounds/tippytalk2.wav"))
	tippy_talk_sounds.append(load("res://Assets/Audio/Tippy Talk Sounds/tippytalk4.wav"))
	tippy_talk_sounds.append(load("res://Assets/Audio/Tippy Talk Sounds/tippytalk5.wav"))
	tippy_talk_sounds.append(load("res://Assets/Audio/Tippy Talk Sounds/tippytalk9.wav"))
	tippy_talk_sounds.append(load("res://Assets/Audio/Tippy Talk Sounds/tippytalk10.wav"))
	
	tippy_win_sounds.append(load("res://Assets/Audio/Tippy Win Sounds/TippyWinFinal1.wav"))
	tippy_win_sounds.append(load("res://Assets/Audio/Tippy Win Sounds/TippyWinFinal2.wav"))

	deal = load("res://Assets/Audio/deal.wav")
	kaching = load("res://Assets/Audio/kaching.wav")
	growl = load("res://Assets/Audio/Ozo_11Growl.wav")
	swap = load("res://Assets/Audio/swap.wav")
	win = load("res://Assets/Audio/win.wav")


func reset():
	house = 200
	personal = 0
	tips = 0

	roun_d = 0
	letter_shown = false
	day_start = false

	ozo_anger = 0
	tippy_happy = 0
