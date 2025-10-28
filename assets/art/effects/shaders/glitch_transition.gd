@tool
extends ColorRect


@export var shake := false:
	set(_value):
		material.set_shader_param("fade", 0.0)
		create_tween().set_trans(Tween.TRANS_SPRING).tween_property(material,
				^"shader_parameter/fade", 0.02, 1.0)
