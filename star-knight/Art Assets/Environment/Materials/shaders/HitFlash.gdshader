shader_type spatial;

uniform sampler2D tex : source_color, filter_nearest, repeat_disable;
uniform vec3 flash_color : source_color = vec3(1.0);
uniform float intensity : hint_range(0.0, 1.0, 0.1) = 0.0;

void fragment() {
	vec4 tex_color = texture(tex, UV);
	ALBEDO = mix(tex_color.rgb, flash_color, intensity);
	ALPHA = tex_color.a;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
