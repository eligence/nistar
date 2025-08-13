#version 300 es
precision highp float;

uniform float time;
uniform vec2 vp;

in vec2 uv;
out vec4 fragColor;

// Color palette - base1 and base2 pairs (brightness reduced for brighter colors)
const vec3 colorPalette[20] = vec3[20](
// Royal Blue (teal-green/dark blue)
vec3(0.20, 0.50, 0.30), vec3(0.00, 0.00, 0.50),
// Teal
vec3(0.11, 0.42, 0.49), vec3(0.06, 0.21, 0.25),
// Emerald Green
vec3(0.10, 0.49, 0.37), vec3(0.05, 0.25, 0.19),
// Lime Green
vec3(0.22, 0.42, 0.13), vec3(0.11, 0.21, 0.07),
// Golden Yellow - dimmed
vec3(0.43, 0.34, 0.06), vec3(0.22, 0.17, 0.03),
// Orange - dimmed
vec3(0.47, 0.25, 0.07), vec3(0.24, 0.13, 0.04),
// Coral - dimmed
vec3(0.48, 0.16, 0.13), vec3(0.24, 0.08, 0.07),
// Pink - dimmed
vec3(0.44, 0.06, 0.20), vec3(0.22, 0.03, 0.10),
// Violet
vec3(0.56, 0.27, 0.68), vec3(0.28, 0.13, 0.34),
// Deep Purple
vec3(0.18, 0.10, 0.28), vec3(0.09, 0.05, 0.14)
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

// Get interpolated colors with smooth transition
vec3 getAnimatedColor1(float time) {
    float transitionSpeed = 5.0; // 5 seconds per transition
    float totalCycle = transitionSpeed * 10.0; // Total time for all 10 colors

    // Current position in the cycle (0.0 to 10.0)
    float cyclePos = mod(time, totalCycle) / transitionSpeed;

    // Current and next color indices
    int currentIndex = int(floor(cyclePos));
    int nextIndex = int(mod(float(currentIndex + 1), 10.0));

    // Interpolation factor (0.0 to 1.0)
    float t = fract(cyclePos);

    // Smooth transition using smoothstep
    t = smoothstep(0.0, 1.0, t);

    return mix(getColor1(currentIndex), getColor1(nextIndex), t);
}

vec3 getAnimatedColor2(float time) {
    float transitionSpeed = 5.0; // 5 seconds per transition
    float totalCycle = transitionSpeed * 10.0; // Total time for all 10 colors

    // Current position in the cycle (0.0 to 10.0)
    float cyclePos = mod(time, totalCycle) / transitionSpeed;

    // Current and next color indices
    int currentIndex = int(floor(cyclePos));
    int nextIndex = int(mod(float(currentIndex + 1), 10.0));

    // Interpolation factor (0.0 to 1.0)
    float t = fract(cyclePos);

    // Smooth transition using smoothstep
    t = smoothstep(0.0, 1.0, t);

    return mix(getColor2(currentIndex), getColor2(nextIndex), t);
}

void main() {
    vec2 p = uv.xy;
    p.x *= vp.x / vp.y;

    float gradient = mix(p.y*.2 + .1, p.y*1.2 + .9, fbm(p));
    float speed = 0.1;
    float details = 7.;
    float force = .9;
    float shift = .5;

    vec2 fast = vec2(p.x, p.y - time*speed) * details;
    float ns_a = fbm(fast);
    float ns_b = force * fbm(fast + ns_a + time) - shift;
    float nns = force * fbm(vec2(ns_a, ns_b));
    float ins = fbm(vec2(ns_b, ns_a));

    vec3 c1 = mix(getAnimatedColor1(time), getAnimatedColor2(time), ins + shift);

    fragColor = vec4(c1 + vec3(ins - gradient), 1.0);
}
