<template>
  <canvas
    ref="canvasRef"
    class="fixed inset-0 -z-10 overflow-hidden pointer-events-none smoke-canvas"
  />
</template>

<script setup>
const canvasRef = ref(null)
let webGLHandler = null
let resizeObserver = null

// credit: https://codepen.io/Akash_Ramani/pen/oggRObV?editors=0010
const fragmentShaderSource = `#version 300 es
precision highp float;

uniform float time;
uniform vec2 vp;

in vec2 uv;
out vec4 fragColor;

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
    vec3 c1 = mix(vec3(0.2, 0.5, 0.3), vec3(0.0, 0.0, 0.5), ins1 + shift1);

    // Second smoke layer (faster) - using original color scheme
    float speed2 = 0.1;  // Faster speed for second layer
    float details2 = 7.0;
    float force2 = 0.9;
    float shift2 = 0.5;

    vec2 layer2 = vec2(p.x, p.y - time * speed2) * details2;
    float ns_a2 = fbm(layer2 * 1.5);
    float ns_b2 = force2 * fbm(layer2 + ns_a2 + time * 0.7) - shift2;
    float ins2 = fbm(vec2(ns_b2, ns_a2));
    vec3 c2 = mix(vec3(0.2, 0.5, 0.3), vec3(0.0, 0.0, 0.5), ins2 + shift2);

    // Blend the two layers with original colors
    float blend = 0.6;  // Slightly more weight to the second layer for visibility
    vec3 finalColor = mix(c1, c2, blend) + vec3((ins1 + ins2) * 0.5 - gradient);

    fragColor = vec4(finalColor, 1.0);
}
`;


class WebGLHandler {
  vertexShaderSource = `#version 300 es
        precision mediump float;
        const vec2 positions[6] = vec2[6](vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(-1.0, 1.0), vec2(1.0, -1.0), vec2(1.0, 1.0));
        out vec2 uv;
        void main() {
            uv = positions[gl_VertexID];
            gl_Position = vec4(positions[gl_VertexID], 0.0, 1.0);
        }`;

  constructor(canvas, fragmentShaderSource) {
    this.cn = canvas;
    this.gl = canvas.getContext("webgl2");
    this.startTime = Date.now();

    this.resize();
    window.addEventListener("resize", () => this.resize());

    this.program = this.gl.createProgram();
    this.compileShader(this.vertexShaderSource, this.gl.VERTEX_SHADER);
    this.compileShader(fragmentShaderSource, this.gl.FRAGMENT_SHADER);
    this.gl.linkProgram(this.program);
    this.gl.useProgram(this.program);

    this.timeLocation = this.gl.getUniformLocation(this.program, "time");
    this.resolutionLocation = this.gl.getUniformLocation(this.program, "vp");

    this.render();
  }

  resize() {
    this.cn.width = window.innerWidth;
    this.cn.height = window.innerHeight;
    this.gl.viewport(0, 0, this.cn.width, this.cn.height);
  }

  compileShader(source, type) {
    const shader = this.gl.createShader(type);
    this.gl.shaderSource(shader, source);
    this.gl.compileShader(shader);
    if (!this.gl.getShaderParameter(shader, this.gl.COMPILE_STATUS)) {
      console.error(this.gl.getShaderInfoLog(shader));
      this.gl.deleteShader(shader);
      return null;
    }
    return this.gl.attachShader(this.program, shader);
  }

  render = () => {
    this.gl.uniform1f(this.timeLocation, (Date.now() - this.startTime) / 1000);
    this.gl.uniform2fv(this.resolutionLocation, [
      this.cn.width,
      this.cn.height
    ]);
    this.gl.drawArrays(this.gl.TRIANGLES, 0, 6);
    window.requestAnimationFrame(this.render);
  };
}

onMounted(() => {
  if (canvasRef.value) {
    webGLHandler = new WebGLHandler(canvasRef.value, fragmentShaderSource)

    // Set up ResizeObserver for better responsiveness
    resizeObserver = new ResizeObserver(() => {
      if (webGLHandler) {
        webGLHandler.resize()
      }
    })
    resizeObserver.observe(canvasRef.value.parentElement)
  }
})

onUnmounted(() => {
  if (webGLHandler) {
    webGLHandler.destroy()
    webGLHandler = null
  }
  if (resizeObserver) {
    resizeObserver.disconnect()
    resizeObserver = null
  }
})
</script>

<style scoped>
.smoke-canvas {
  display: block;
  width: 100%;
  height: 100%;
}
</style>
