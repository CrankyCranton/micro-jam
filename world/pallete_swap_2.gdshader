shader_type canvas_item; 

uniform sampler2D grayscaleImage : filter_nearest;
uniform vec4 lowColor : source_color;
uniform vec4 midColor : source_color;
uniform vec4 highColor : source_color;

void fragment() {
	float avg = (midColor.r+lowColor.g+highColor.b)/3.0;
	vec4 greyecale = vec4(vec3(avg), COLOR.a);

	vec4 grayscaleTexture = textureLod(grayscaleImage, UV, 0.0);
	float grayscaleValue = grayscaleTexture.r;
	float alphaValue = grayscaleTexture.a;
	
	vec4 color = mix(lowColor, midColor, grayscaleValue);
	color = mix(color, highColor, pow(grayscaleValue, 1.0));
	
	color.a *= alphaValue;
	
	COLOR = color;
	
}