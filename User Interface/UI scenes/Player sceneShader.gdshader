shader_type canvas_item;

uniform float speed = 0.5;  // Controls how fast the smoke shifts
uniform float intensity = 0.02;  // Controls the distortion amount
uniform sampler2D noise_texture; // Needs a seamless noise texture

void fragment() {
    vec2 uv = UV;

    // Create a looping time effect
    float time_shift = sin(TIME * speed) * 0.5 + 0.5; // Stays between 0 and 1

    // Sample noise texture at two slightly offset points
    float noise1 = texture(noise_texture, uv + vec2(time_shift * 0.02, time_shift * 0.02)).r;
    float noise2 = texture(noise_texture, uv - vec2(time_shift * 0.02, time_shift * 0.02)).r;

    // Combine both noise samples for a smoother distortion
    float distortion = (noise1 + noise2) * 0.5 - 0.5;

    // Apply the distortion to the UV (stays in place, just wobbles)
    uv += distortion * intensity;

    // Fetch the final color from the UI element
    vec4 tex_color = texture(TEXTURE, uv);
    COLOR = tex_color;
}
