<template>
  <div ref="container" class="particle-container">
    <div
        v-for="(particle, index) in particles"
        :key="index"
        :ref="el => { if (el) particleRefs[index] = el }"
        class="spark"
    />
    <div
      v-if="showEndAreaText"
      class="end-area-text"
      :style="endAreaTextStyle"
    >
      <span class="font-serif tracking-widest text-amber-300 text-2xl lg:text-5xl text-center glow">NISTAR</span>
    </div>
  </div>
</template>

<script setup>
// based on https://codepen.io/jiayihu/pen/QwvjMZ
// by https://codepen.io/jiayihu
const container = ref(null)
const particles = ref([])
const particleRefs = ref([])

// Props with defaults for Nuxt
const props = defineProps({
  density: {
    type: Number,
    default: 70
  },
  speed: {
    type: Number,
    default: 2
  },
  // Starting area (where sparks spawn)
  startArea: {
    type: Object,
    default: () => ({
      x: { min: 0.5, max: 0.52 }, // As fraction of window width (0.5 = center)
      y: { min: 0.9, max: 1.0 },  // As fraction of window height (1.0 = bottom)
      offset: { x: 10, y: -50 }   // Fixed pixel offsets
    })
  },
  // Middle area (where sparks travel through)
  midArea: {
    type: Object,
    default: () => ({
      x: { min: 0.1, max: 0.9 },  // Full width spread
      y: { min: 0.4, max: 0.9 }   // Middle to lower area
    })
  },
  // End area (where sparks disappear)
  endArea: {
    type: Object,
    default: () => ({
      x: { min: -0.1, max: 1.1 }, // Beyond screen edges
      y: { min: -0.2, max: -0.2 } // Above screen
    })
  },
  // Animation duration in seconds for area transitions
  transitionDuration: {
    type: Number,
    default: 0
  },
  showEndAreaText: {
    type: Boolean,
    default: false
  },
})

let winHeight = 0
let winWidth = 0
let start, mid, end
let animationIds = []
let transitionAnimationId = null

// Store current and target configurations for smooth transitions
const currentAreas = ref({
  startArea: null,
  midArea: null,
  endArea: null
})

// Computed style for end area text positioning
const endAreaTextStyle = computed(() => {
  const endAreaConfig = currentAreas.value.endArea || props.endArea
  const centerX = (endAreaConfig.x.min + endAreaConfig.x.max) / 2
  const centerY = (endAreaConfig.y.min + endAreaConfig.y.max) / 2

  return {
    left: (winWidth * centerX) + 'px',
    top: (winHeight * centerY) + 'px',
    transform: 'translate(-50%, -50%)'
  }
})

const lerp = (start, end, factor) => {
  return start + (end - start) * factor
}

const lerpObject = (startObj, endObj, factor) => {
  const result = {}
  for (const key in startObj) {
    if (typeof startObj[key] === 'object' && startObj[key] !== null) {
      result[key] = lerpObject(startObj[key], endObj[key], factor)
    } else {
      result[key] = lerp(startObj[key], endObj[key], factor)
    }
  }
  return result
}

const easeInOut = (t) => {
  return t < 0.5 ? 2 * t * t : -1 + (4 - 2 * t) * t
}

const updateDimensions = () => {
  // Client-side only dimension calculation
  if (import.meta.client) {
    winHeight = window.innerHeight
    winWidth = window.innerWidth
    calculatePositions()
  }
}

const calculatePositions = (areas = null) => {
  // Use provided areas or current areas
  const activeAreas = areas || currentAreas.value
  const startAreaConfig = activeAreas.startArea || props.startArea
  const midAreaConfig = activeAreas.midArea || props.midArea
  const endAreaConfig = activeAreas.endArea || props.endArea

  // Calculate positions based on current area configuration
  const startX = startAreaConfig.x
  const startY = startAreaConfig.y
  const startOffset = startAreaConfig.offset || { x: 0, y: 0 }

  start = {
    yMin: (winHeight * startY.min) + startOffset.y,
    yMax: (winHeight * startY.max) + startOffset.y,
    xMin: (winWidth * startX.min) + startOffset.x,
    xMax: (winWidth * startX.max) + startOffset.x,
    scaleMin: 0.1,
    scaleMax: 0.25,
    scaleXMin: 0.1,
    scaleXMax: 1,
    scaleYMin: 1,
    scaleYMax: 2,
    opacityMin: 0.1,
    opacityMax: 0.4
  }

  const midX = midAreaConfig.x
  const midY = midAreaConfig.y

  mid = {
    yMin: winHeight * midY.min,
    yMax: winHeight * midY.max,
    xMin: winWidth * midX.min,
    xMax: winWidth * midX.max,
    scaleMin: 0.2,
    scaleMax: 0.8,
    opacityMin: 0.5,
    opacityMax: 1
  }

  const endX = endAreaConfig.x
  const endY = endAreaConfig.y

  end = {
    yMin: winHeight * endY.min,
    yMax: winHeight * endY.max,
    xMin: winWidth * endX.min,
    xMax: winWidth * endX.max,
    scaleMin: 0.1,
    scaleMax: 1,
    opacityMin: 0.4,
    opacityMax: 0.7
  }
}

const animateToNewAreas = (newStartArea, newMidArea, newEndArea, duration) => {
  if (duration <= 0) {
    // No animation, just set immediately
    currentAreas.value = {
      startArea: newStartArea,
      midArea: newMidArea,
      endArea: newEndArea
    }
    calculatePositions()
    return
  }

  // Set up animation
  const startTime = performance.now()
  const fromAreas = {
    startArea: currentAreas.value.startArea ? { ...currentAreas.value.startArea } : { ...props.startArea },
    midArea: currentAreas.value.midArea ? { ...currentAreas.value.midArea } : { ...props.midArea },
    endArea: currentAreas.value.endArea ? { ...props.endArea } : { ...props.endArea }
  }

  const toAreas = {
    startArea: newStartArea,
    midArea: newMidArea,
    endArea: newEndArea
  }

  const animate = (currentTime) => {
    const elapsed = currentTime - startTime
    const progress = Math.min(elapsed / (duration * 1000), 1)
    const easedProgress = easeInOut(progress)

    // Interpolate between current and target areas
    currentAreas.value = {
      startArea: lerpObject(fromAreas.startArea, toAreas.startArea, easedProgress),
      midArea: lerpObject(fromAreas.midArea, toAreas.midArea, easedProgress),
      endArea: lerpObject(fromAreas.endArea, toAreas.endArea, easedProgress)
    }

    calculatePositions()

    if (progress < 1) {
      transitionAnimationId = requestAnimationFrame(animate)
    }
  }

  transitionAnimationId = requestAnimationFrame(animate)
}

const range = (map, prop) => {
  const min = map[prop + 'Min']
  const max = map[prop + 'Max']
  return min + (max - min) * Math.random()
}

const setElementStyle = (element, styles) => {
  Object.assign(element.style, styles)
}

const animateProperty = (element, property, targetValue, duration, delay = 0, easing = 'linear', onComplete = null) => {
  const startTime = performance.now() + delay
  const startValue = parseFloat(getComputedStyle(element)[property]) || 0
  const change = targetValue - startValue

  const animate = (currentTime) => {
    if (currentTime < startTime) {
      animationIds.push(requestAnimationFrame(animate))
      return
    }

    const elapsed = currentTime - startTime
    const progress = Math.min(elapsed / (duration * 1000), 1)

    // Simple easing functions
    let easedProgress = progress
    if (easing === 'easeOut') {
      easedProgress = 1 - Math.pow(1 - progress, 3)
    } else if (easing === 'easeIn') {
      easedProgress = Math.pow(progress, 3)
    }

    const currentValue = startValue + (change * easedProgress)

    if (property === 'opacity') {
      element.style.opacity = currentValue
      element.style.visibility = currentValue > 0 ? 'visible' : 'hidden'
    } else if (property === 'transform') {
      element.style.transform = targetValue.replace('VALUE', currentValue)
    } else {
      element.style[property] = currentValue + (property.includes('scale') ? '' : 'px')
    }

    if (progress < 1) {
      animationIds.push(requestAnimationFrame(animate))
    } else if (onComplete) {
      onComplete()
    }
  }

  animationIds.push(requestAnimationFrame(animate))
}

const spawn = (particleElement, particleIndex) => {
  const wholeDuration = (10 / props.speed) * (0.7 + Math.random() * 0.4)
  const delay = wholeDuration * Math.random()
  const partialDuration = (wholeDuration + 1) * (0.2 + Math.random() * 0.3)

  // Initial setup
  setElementStyle(particleElement, {
    position: 'absolute',
    left: range(start, 'x') + 'px',
    top: range(start, 'y') + 'px',
    transform: `scale(${range(start, 'scale')})`,
    opacity: range(start, 'opacity'),
    visibility: 'hidden'
  })

  // Y movement (upward)
  setTimeout(() => {
    particleElement.style.visibility = 'visible'
    animateProperty(particleElement, 'top', range(mid, 'y'), partialDuration, 0, 'easeOut')
    setTimeout(() => {
      animateProperty(particleElement, 'top', range(end, 'y'), wholeDuration - partialDuration, 0, 'easeIn')
    }, partialDuration * 1000)
  }, delay * 1000)

  // X movement
  setTimeout(() => {
    animateProperty(particleElement, 'left', range(mid, 'x'), partialDuration, 0, 'easeOut')
    setTimeout(() => {
      animateProperty(particleElement, 'left', range(end, 'x'), wholeDuration - partialDuration, 0, 'easeIn')
    }, partialDuration * 1000)
  }, delay * 1000)

  // Scale and opacity
  const scalePartialDuration = wholeDuration * (0.5 + Math.random() * 0.3)
  setTimeout(() => {
    const midScale = range(mid, 'scale')
    const midOpacity = range(mid, 'opacity')

    particleElement.style.transform = `scale(${midScale})`
    particleElement.style.opacity = midOpacity

    setTimeout(() => {
      const endScale = range(end, 'scale')
      const endOpacity = range(end, 'opacity')

      animateProperty(particleElement, 'opacity', endOpacity, wholeDuration - scalePartialDuration, 0, 'linear', () => {
        // Restart the particle
        spawn(particleElement, particleIndex)
      })

      // Animate scale
      const targetTransform = `scale(${endScale})`
      particleElement.style.transform = targetTransform

    }, scalePartialDuration * 1000)
  }, delay * 1000)
}

const createParticles = async () => {
  // Clear any existing particles
  if (particleRefs.value.length > 0) {
    particles.value = []
    await nextTick()
  }

  // Create new particles
  particles.value = Array.from({ length: props.density }, (_, i) => ({ id: i }))

  await nextTick()

  particleRefs.value.forEach((particleElement, index) => {
    if (particleElement) {
      spawn(particleElement, index)
    }
  })
}

const handleResize = () => {
  updateDimensions()
}

// Watch for prop changes and animate to new values
watch([() => props.startArea, () => props.midArea, () => props.endArea],
    ([newStartArea, newMidArea, newEndArea]) => {
      animateToNewAreas(newStartArea, newMidArea, newEndArea, props.transitionDuration)
    },
    { deep: true }
)

// Watch for density changes and adjust particles
watch(() => props.density, (newDensity, oldDensity) => {
  if (newDensity > oldDensity) {
    // Add more particles
    const newParticles = [...particles.value]
    const startIndex = particles.value.length
    const count = newDensity - oldDensity

    for (let i = 0; i < count; i++) {
      newParticles.push({ id: startIndex + i })
    }

    particles.value = newParticles

    // Wait for DOM to update with new particles
    nextTick(() => {
      // Only spawn the new particles
      for (let i = startIndex; i < particles.value.length; i++) {
        if (particleRefs.value[i]) {
          spawn(particleRefs.value[i], i)
        }
      }
    })
  } else if (newDensity < oldDensity) {
    // Remove excess particles
    particles.value = particles.value.slice(0, newDensity)
  }
})

// Client-side only initialization
onMounted(() => {
  // Initialize current areas with prop values
  currentAreas.value = {
    startArea: { ...props.startArea },
    midArea: { ...props.midArea },
    endArea: { ...props.endArea }
  }

  // Only run on client side
  if (import.meta.client) {
    updateDimensions()
    window.addEventListener('resize', handleResize)
    createParticles()
  }
})

onUnmounted(() => {
  if (import.meta.client) {
    window.removeEventListener('resize', handleResize)
    animationIds.forEach(id => cancelAnimationFrame(id))
    if (transitionAnimationId) {
      cancelAnimationFrame(transitionAnimationId)
    }
    animationIds = []
  }
})
</script>

<style scoped>
.particle-container {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  pointer-events: none;
  z-index: 1000;
}

.spark {
  background-color: #DE4A00;
  font-family: 'Helvetica', sans-serif;
  visibility: hidden;
  position: absolute;
  width: 4px;
  height: 4px;
  border-radius: 30%;
  box-shadow: 0 0 5px #AB000B;
}

.end-area-text {
  position: absolute;
  pointer-events: auto;
  white-space: nowrap;
  z-index: 1001;
}

.glow {
  text-shadow:
      -1px -1px 0 rgba(139, 69, 19, 0.8),
      1px -1px 0 rgba(139, 69, 19, 0.8),
      -1px 1px 0 rgba(139, 69, 19, 0.8),
      1px 1px 0 rgba(139, 69, 19, 0.8),
      0 -2px 8px rgba(255, 140, 0, 0.4),
      0 0 3px rgba(255, 165, 0, 0.6),
      0 0 8px rgba(255, 140, 0, 0.5),
      0 0 20px rgba(255, 69, 0, 0.3),
      0 0 35px rgba(255, 69, 0, 0.2),
      0 3px 6px rgba(0, 0, 0, 0.7);
}
</style>
