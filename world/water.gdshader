shader_type canvas_item;

uniform sampler2D noise : repeat_enable;
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
uniform vec2 scroll = vec2(0.05,0.05);
uniform float distortion_strength: hint_range(-1,1) = 0.2;

void fragment() {
	vec4 noise_col = texture(noise,UV + scroll * TIME);
	vec4 screen_col = texture(screen_texture, UV + distortion_strength * noise_col.rr);
	COLOR = screen_col;

}
