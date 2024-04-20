extends ItemContainerScene



func hit(damage_amount: int):
	if not opened:
		$LidSprite.hide()
		for i in range(5):
			var pos = $SpawnPositions.get_child(randi()%$SpawnPositions.get_child_count()).global_position
			item_opened.emit(pos, current_diraction)
		opened = true
