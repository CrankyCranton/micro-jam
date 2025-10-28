class_name Scenario extends Area2D


#region Members
signal won

@export var ability_info: AbilityInfo
@export var boss: Boss

var player: Player

@onready var animation_player: AnimationPlayer = $AnimationPlayer
#endregion


#region Functions
func _ready() -> void:
	if boss != null:
		boss.died.connect(_on_boss_died)


#region Methods
func start() -> void:
	animation_player.play(&"start")


func win() -> void:
	if ability_info != null:
		player.add_ability(ability_info)
	won.emit()


func end() -> void:
	player.reset_health()
	animation_player.play(&"end")


func activate_boss() -> void:
	boss.activate()
#endregion


#region Callbacks
func _on_boss_died() -> void:
	win()


func _on_body_entered(player: Player) -> void:
	if not Global.met_shady_guy:
		return
	self.player = player
	start()
#endregion
#endregion
