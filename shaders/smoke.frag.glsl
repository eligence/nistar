#version 300 es
precision highp float;

uniform float time;
uniform vec2 vp;

in vec2 uv;
out vec4 fragColor;

// Color palette - base1 and base2 pairs
const vec3 colorPalette[20] = vec3[20](
// Royal Blue (teal-green/dark blue)
vec3(0.20, 0.50, 0.30), vec3(0.00, 0.00, 0.50),
// Teal
vec3(0.11, 0.42, 0.49), vec3(0.05, 0.21, 0.25),
// Emerald Green
vec3(0.10, 0.49, 0.37), vec3(0.05, 0.25, 0.18),
// Lime Green
vec3(0.29, 0.55, 0.17), vec3(0.15, 0.27, 0.09),
// Golden Yellow
vec3(0.83, 0.66, 0.12), vec3(0.42, 0.33, 0.06),
// Orange (matches your example)
vec3(0.90, 0.49, 0.13), vec3(0.45, 0.25, 0.07),
// Coral
vec3(0.91, 0.30, 0.24), vec3(0.46, 0.15, 0.12),
// Pink
vec3(0.85, 0.11, 0.38), vec3(0.43, 0.05, 0.19),
// Violet
vec3(0.56, 0.27, 0.68), vec3(0.28, 0.13, 0.34),
// Deep Purple
vec3(0.18, 0.10, 0.28), vec3(0.10, 0.05, 0.14)
);

float rand(vec2 p) {
    return fract(sin(dot(p.xy, vec2(1., 300.))) * 43758.5453123);
}

// Based on Morgan McGuire
float noise(vec2 p) {
    vec2 i = floor(p);
    vec2 f = fract(p);

    // Four corners in 2D of a tile
    float a = rand(i);
    float b = rand(i + vec2(1.0, 0.0));
    float c = rand(i + vec2(0.0, 1.0));
    float d = rand(i + vec2(1.0, 1.0));

    vec2 u = f * f * (3.0 - 2.0 * f);

    return mix(a, b, u.x) +
    (c - a)* u.y * (1.0 - u.x) +
    (d - b) * u.x * u.y;
}

#define OCTAVES 5
float fbm(vec2 p) {
    // Initial values
    float value = 0.;
    float amplitude = .4;
    float frequency = 0.;

    // Loop of octaves
    for (int i = 0; i < OCTAVES; i++) {
        value += amplitude * noise(p);
        p *= 2.;
        amplitude *= .4;
    }
    return value;
}

// Helper function to get color pair by index (0-9)
vec3 getColor1(int index) {
    return colorPalette[index * 2];
}

vec3 getColor2(int index) {
    return colorPalette[index * 2 + 1];
}

void main() {
    vec2 p = uv.xy;
    p.x *= vp.x / vp.y;

    float gradient = mix(p.y*.2 + .1, p.y*1.2 + .9, fbm(p));

    // First smoke layer (slower)
    float speed1 = 0.05;  // Slower speed for first layer
    float details1 = 5.0;
    float force1 = 0.8;
    float shift1 = 0.5;

    vec2 layer1 = vec2(p.x, p.y - time * speed1) * details1;
    float ns_a1 = fbm(layer1);
    float ns_b1 = force1 * fbm(layer1 + ns_a1 + time * 0.5) - shift1;
    float ins1 = fbm(vec2(ns_b1, ns_a1));
    vec3 c1 = mix(getColor1(0), getColor2(0), ins1 + shift1); // Orange palette

    // Second smoke layer (faster)
    float speed2 = 0.1;  // Faster speed for second layer
    float details2 = 7.0;
    float force2 = 0.9;
    float shift2 = 0.5;

    vec2 layer2 = vec2(p.x, p.y - time * speed2) * details2;
    float ns_a2 = fbm(layer2 * 1.5);
    float ns_b2 = force2 * fbm(layer2 + ns_a2 + time * 0.7) - shift2;
    float ins2 = fbm(vec2(ns_b2, ns_a2));
    vec3 c2 = mix(getColor1(0), getColor2(0), ins2 + shift2); // Orange palette

    // Blend the two layers with original colors
    float blend = 0.6;  // Slightly more weight to the second layer for visibility
    vec3 finalColor = mix(c1, c2, blend) + vec3((ins1 + ins2) * 0.5 - gradient);

    fragColor = vec4(finalColor, 1.0);
}
