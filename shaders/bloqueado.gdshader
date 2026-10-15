
shader_type canvas_item;

uniform vec4 cor_bloqueio : source_color = vec4(1.0, 0.0, 0.0, 1.0);

void fragment() {
	vec4 tex = texture(TEXTURE, UV);

	if (tex.a > 0.0) {
		COLOR = vec4(cor_bloqueio.rgb, tex.a);
	} else {
		COLOR = vec4(0.0);
	}
}
