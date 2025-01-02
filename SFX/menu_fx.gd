extends Node

func button_click():
	$ButtonClick.play()

func play_menu():
	if $Menu.playing:
		return
		
	$Game.stop()
	$Menu.play()
	
func play_game():
	if $Game.playing:
		return
		
	$Menu.stop()
	$Game.play()
	
func stop_music():
	$Menu.stop()
	$Game.stop()
