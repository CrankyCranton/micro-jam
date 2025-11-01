class_name Scenario extends Area2D


#region Members
signal won

#region Export
@export var ability_info: AbilityInfo
@export var boss: Boss
#endregion

var player: Player

#region Onready
@onready var boundaries: StaticBody2D = $Boundaries
@onready var left: CollisionShape2D = %Left
@onready var right: CollisionShape2D = %Right
@onready var top: CollisionShape2D = %Top
@onready var bottom: CollisionShape2D = %Bottom
@onready var limits: ReferenceRect = $Limits
@onready var animation_player: AnimationPlayer = $AnimationPlayer
#endregion
#endregion


#region Functions
func _ready() -> void:
	set_up_boundaries()
	if boss != null:
		boss.started.connect(_on_boss_started)
		boss.died.connect(_on_boss_died)


#region Methods
func set_up_boundaries() -> void:
	var rect := limits.get_global_rect()
	left.global_position.x = rect.position.x
	right.global_position.x = rect.end.x
	top.global_position.y = rect.position.y
	bottom.global_position.y = rect.end.y


func set_boundaries_active(active: bool) -> void:
	boundaries.process_mode = Node.PROCESS_MODE_INHERIT if active else Node.PROCESS_MODE_DISABLED


func set_limits_active(active: bool) -> void:
	var camera := get_viewport().get_camera_2d()
	camera.limit_enabled = active
	if active:
		var rect := Rect2i(limits.get_global_rect())
		camera.limit_left = rect.position.x
		camera.limit_right = rect.end.x
		camera.limit_top = rect.position.y
		camera.limit_bottom = rect.end.y


func start() -> void:
	set_boundaries_active(true)
	animation_player.play(&"start")


func win() -> void:
	if ability_info != null:
		player.add_ability(ability_info)
	end()
	won.emit()


func end() -> void:
	set_boundaries_active(false)
	set_limits_active(false)
	player.set_state(&"peace")
	animation_player.play(&"end")


func activate_boss() -> void:
	set_limits_active(true)
	boss.activate()
#endregion


#region Callbacks
func _on_boss_died() -> void:
	win()


func _on_boss_started() -> void:
	player.set_state(&"combat")


func _on_body_entered(player: Player) -> void:
	if not Global.met_shady_guy:
		return
	self.player = player
	start()
#endregion
#endregion
