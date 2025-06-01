class_name ChainAbility extends Ability


func execute(player:Player):
	if player.interactable is NPC:
		player.set_enabled(false)
		await player.interactable.enslave(player)
		player.set_enabled(true)
