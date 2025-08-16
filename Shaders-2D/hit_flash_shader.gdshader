shader_type canvas_item;

uniform vec4 flash_color : source_color = vec4(1.0, 0.0, 0.0, 0.5); // Red flash
uniform float flash_strength : hint_range(0.0, 1.0) = 0.0; // 0 = normal, 1 = full flash

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
    COLOR = mix(tex_color, flash_color, flash_strength) * tex_color.a;
}