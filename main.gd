extends Node2D

func _ready():
	Utils.saveGame()
	Utils.loadGame()

func _on_quit_pressed(): #function for the pressed Quit-button
	get_tree().quit()

#to make a Play_button we have to create another scene


func _on_play_pressed(): #function for the pressed Play-button
	get_tree().change_scene_to_file("res://world.tscn")
