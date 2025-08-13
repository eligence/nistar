<template>
  <canvas
      ref="canvasRef"
      class="fixed inset-0 -z-10 overflow-hidden pointer-events-none smoke-canvas"
  />
</template>

<script setup>
import fragmentShaderSource from '../../shaders/smoke.frag.glsl?raw'
import vertexShaderSource from '../../shaders/smoke.vert.glsl?raw'

const canvasRef = ref(null)
let webGLHandler = null
let resizeObserver = null

/*{ base1: [0.18, 0.10, 0.28], base2: [0.10, 0.05, 0.14] }, // Deep Purple
  { base1: [0.20, 0.50, 0.30], base2: [0.00, 0.00, 0.50] }, // Royal Blue (teal-green/dark blue)
  { base1: [0.11, 0.42, 0.49], base2: [0.05, 0.21, 0.25] }, // Teal
  { base1: [0.10, 0.49, 0.37], base2: [0.05, 0.25, 0.18] }, // Emerald Green
  { base1: [0.29, 0.55, 0.17], base2: [0.15, 0.27, 0.09] }, // Lime Green
  { base1: [0.83, 0.66, 0.12], base2: [0.42, 0.33, 0.06] }, // Golden Yellow
  { base1: [0.90, 0.49, 0.13], base2: [0.45, 0.25, 0.07] }, // Orange
  { base1: [0.91, 0.30, 0.24], base2: [0.46, 0.15, 0.12] }, // Coral
  { base1: [0.85, 0.11, 0.38], base2: [0.43, 0.05, 0.19] }, // Pink
  { base1: [0.56, 0.27, 0.68], base2: [0.28, 0.13, 0.34] }  // Violet*/

// credit: https://codepen.io/Akash_Ramani/pen/oggRObV?editors=0010
class WebGLHandler {
  constructor(canvas, vertexShaderSource, fragmentShaderSource) {
    this.cn = canvas;
    this.gl = canvas.getContext("webgl2");
    this.startTime = Date.now();

    this.resize();
    window.addEventListener("resize", () => this.resize());

    this.program = this.gl.createProgram();
    this.compileShader(vertexShaderSource, this.gl.VERTEX_SHADER);
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

  destroy() {
    if (this.gl && this.program) {
      this.gl.deleteProgram(this.program);
    }
  }
}

onMounted(() => {
  if (canvasRef.value) {
    webGLHandler = new WebGLHandler(canvasRef.value, vertexShaderSource, fragmentShaderSource)

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
