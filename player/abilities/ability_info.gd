class_name AbilityInfo extends Resource


#region Members
@export var scene: PackedScene
@export var name := ""
@export_multiline var instructions := ""
@export_multiline var flavor_text := ""
#endregion


func get_text() -> String:
	const TITLE_FONT_SIZE := 16
	return "[font_size=%s][center][b]%s[/b][/center][/font_size]\n\n[i]%s[/i]\n\n%s" \
			% [TITLE_FONT_SIZE, name, flavor_text, instructions]
