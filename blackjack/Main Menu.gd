extends Control


func _ready():
	pass
	
func _on_Play_Button_pressed():
	get_tree().change_scene("res://root.tscn")


func _on_Credits_Button_pressed():
	$"Credit Menu".show()


func _on_Quit_Button_pressed():
	get_tree().quit()



func _on_Back_pressed():
	$"Credit Menu".hide()
	$"Intel Menu".hide()


func _on_Intel_Button_pressed():
	$"Intel Menu".show()
