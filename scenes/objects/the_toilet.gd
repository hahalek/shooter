extends ItemContainerScene



func hit():
	if not opened:
		$LidSprite.hide()
		var pos = $SpawnPositions/Marker2D.global_position
		item_opened.emit(pos, current_diraction)
		opened = true
