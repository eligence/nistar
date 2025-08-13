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

    // Generate random seed based on time
    float seed = time * 0.2;
    
    // Random number of waves (between 3 and 6)
    int numWaves = 3 + int(floor(noise(vec2(seed, 0.0)) * 4.0));
    
    // Initialize wave sum
    float waveSum = 0.0;
    float totalAmp = 0.0;
    
    // Generate multiple waves with random properties
    for (int i = 0; i < 8; i++) {
        if (i >= numWaves) break;
        
        // Random wave properties
        float freq = 1.0 + 6.0 * noise(vec2(seed + float(i) * 10.0, 5.0));
        float speed = 0.1 + 0.4 * noise(vec2(seed + float(i) * 5.0, 10.0));
        float phase = 6.28 * noise(vec2(seed + float(i) * 15.0, 20.0));
        float amp = 0.01 + 0.04 * noise(vec2(seed + float(i) * 20.0, 30.0));
        
        // Add wave to sum
        waveSum += sin(p.x * freq + time * speed + phase) * amp;
        totalAmp += amp;
    }
    
    // Normalize wave sum
    if (numWaves > 0) {
        waveSum /= totalAmp / 0.03; // Keep overall amplitude in check
    }
    
    // Fade waves with height
    float horizonWarp = waveSum * (1.0 - p.y * 0.7);
    
    // Base gradient with animated horizon
    float baseGradient = mix(p.y * 0.2 + 0.1, p.y * 1.2 + 0.9, fbm(p + time * 0.05));
    float gradient = baseGradient + horizonWarp;

    // First smoke layer (slower)
    float speed1 = 0.01;  // Slower speed for first layer
    
    // Add subtle random variations to the first layer's characteristics
    float details1 = 5.0 + sin(time * 0.05) * 0.5;  // Slight oscillation in detail
    float force1 = 0.8 + noise(vec2(time * 0.1, 0.5)) * 0.1 - 0.05;  // Subtle random force variation
    float shift1 = 0.5 + sin(time * 0.03) * 0.1;  // Slow shifting of the noise pattern

    // Vertical movement only
    vec2 layer1 = vec2(p.x, p.y - time * speed1) * details1;
    float ns_a1 = fbm(layer1);
    float ns_b1 = force1 * fbm(layer1 + ns_a1 + time * 0.5) - shift1;
    float ins1 = fbm(vec2(ns_b1, ns_a1));
    vec3 c1 = mix(getAnimatedColor1(time), getAnimatedColor2(time), ins1 + shift1);

    // Second smoke layer (faster)
    float speed2 = 0.04;  // Faster speed for second layer
    
    // Add different random variations for the second layer
    float details2 = 7.0 + cos(time * 0.07) * 0.7;  // Different oscillation pattern
    float force2 = 0.9 + noise(vec2(time * 0.08, 1.5)) * 0.08 - 0.04;  // Subtle random force variation
    float shift2 = 0.5 + sin(time * 0.04 + 1.57) * 0.15;  // Different phase for variation

    // Vertical movement only for second layer
    vec2 layer2 = vec2(p.x, p.y - time * speed2) * details2;
    float ns_a2 = fbm(layer2 * 1.5);
    float ns_b2 = force2 * fbm(layer2 + ns_a2 + time * 0.7) - shift2;
    float ins2 = fbm(vec2(ns_b2, ns_a2));
    vec3 c2 = mix(getAnimatedColor1(time), getAnimatedColor2(time), ins2 + shift2);

    // Blend the two layers with original colors
    float blend = 0.6 + sin(time * 0.02) * 0.05;  // Subtle variation in layer blending
    
    // Add animated noise to the gradient for organic feel
    float gradientNoise = noise(p * 3.0 + vec2(time * 0.15, time * 0.1)) * 0.15 - 0.075;
    // Apply the noise to the gradient for more organic peaks/valleys
    vec3 finalColor = mix(c1, c2, blend) + vec3((ins1 + ins2) * 0.5 - (gradient + gradientNoise));

    fragColor = vec4(finalColor, 1.0);
}
