extends Node

const SAVE_PATH = "res://savegame.bin" #if relising game - users instead of res, it's where we'll save the game

func saveGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE) #WILL ALLOW US to create a temporary file to write inside of it
	var data: Dictionary = {
		"playerHP": Game.playerHP,
		"Gold": Game.Gold
	}
	var jstr = JSON.stringify(data) #convert to JSON
	file.store_line(jstr)


func loadGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if FileAccess.file_exists(SAVE_PATH) == true:
		if not file.eof_reached(): #if we haven't reached the end of the file
			var current_line = JSON.parse_string(file.get_line()) #allows us to read what's inside the file
			if current_line: #this will convert the JSON-fike into GODOT readeble thing
				Game.playerHP = current_line["playerHP"]
				Game.Gold = current_line["Gold"]
