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
