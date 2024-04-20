extends ItemContainerScene



func hit(damage_amount: int):
	if not opened:
		$LidSprite.hide()
		var pos = $SpawnPositions/Marker2D.global_position
		item_opened.emit(pos, current_diraction)
		opened = true
