<template>
  <ParticleSystem
    :density="800"
    :speed="2"
    :start-area="currentStartArea"
    :mid-area="currentMidArea"
    :end-area="currentEndArea"
    :transition-duration="transitionDuration"
  />
</template>

<script setup>
// Configuration
const transitionDelay = 5 // seconds until transition starts
const transitionDuration = 3 // seconds for the transition animation

// Reactive state
const currentState = ref('Default')
const hasTransitioned = ref(false)
const timeUntilTransition = ref(transitionDelay)
const showTargetIndicator = ref(false)

// Timer references
let transitionTimer = null
let countdownTimer = null

// Default configuration (bottom center spreading)
const defaultConfig = {
  startArea: {
    x: {min: 0.48, max: 0.52}, // Narrow center area
    y: {min: 0.9, max: 1.0},   // Bottom of screen
    offset: {x: 0, y: -20}
  },
  midArea: {
    x: {min: 0.0, max: 1.0},   // Full width spread
    y: {min: 0.3, max: 0.8}    // Middle area
  },
  endArea: {
    x: {min: -0.2, max: 1.2},  // Beyond screen edges
    y: {min: -0.3, max: -0.1}  // Above screen
  }
}

// Contained configuration (top center area)
const containedConfig = {
  startArea: {
    x: {min: 0.35, max: 0.65}, // Top center area - 30% width
    y: {min: 0.15, max: 0.25}, // Top 10% of screen (15-25%)
    offset: {x: 0, y: 0}
  },
  midArea: {
    x: {min: 0.25, max: 0.75}, // Slightly wider for mid travel
    y: {min: 0.10, max: 0.30}  // Stay in upper area
  },
  endArea: {
    x: {min: 0.20, max: 0.80}, // Contained to upper area
    y: {min: 0.05, max: 0.15}  // Exit at very top
  }
}

// Current particle area configurations
const currentStartArea = ref({...defaultConfig.startArea})
const currentMidArea = ref({...defaultConfig.midArea})
const currentEndArea = ref({...defaultConfig.endArea})

// Start the one-time transition sequence
const startTransitionSequence = () => {
  // Clear any existing timers
  clearTimers()

  // Start countdown timer
  countdownTimer = setInterval(() => {
    timeUntilTransition.value--

    // Show target indicator in the last 2 seconds
    if (timeUntilTransition.value <= 2) {
      showTargetIndicator.value = true
    }

    if (timeUntilTransition.value <= 0) {
      clearInterval(countdownTimer)
      executeTransition()
    }
  }, 1000)
}

// Execute the transition
const executeTransition = () => {
  currentState.value = 'Transitioning'
  showTargetIndicator.value = true

  // Update particle areas to contained configuration
  currentStartArea.value = {...containedConfig.startArea}
  currentMidArea.value = {...containedConfig.midArea}
  currentEndArea.value = {...containedConfig.endArea}

  // After transition completes, update state
  setTimeout(() => {
    currentState.value = 'Contained'
    hasTransitioned.value = true
    showTargetIndicator.value = false
  }, transitionDuration * 1000)
}

// Reset the demo
const resetDemo = () => {
  clearTimers()

  // Reset state
  currentState.value = 'Default'
  hasTransitioned.value = false
  timeUntilTransition.value = transitionDelay
  showTargetIndicator.value = false

  // Reset particle areas to default
  currentStartArea.value = {...defaultConfig.startArea}
  currentMidArea.value = {...defaultConfig.midArea}
  currentEndArea.value = {...defaultConfig.endArea}

  // Start the sequence again
  startTransitionSequence()
}

// Clear all timers
const clearTimers = () => {
  if (transitionTimer) {
    clearTimeout(transitionTimer)
    transitionTimer = null
  }
  if (countdownTimer) {
    clearInterval(countdownTimer)
    countdownTimer = null
  }
}

// Lifecycle
onMounted(() => {
  // Start the transition sequence when component mounts
  startTransitionSequence()
})

onUnmounted(() => {
  clearTimers()
})
</script>

<style scoped>
/* Optional: Add some animation to the target indicator */
@keyframes pulse {
  0%, 100% {
    opacity: 0.3;
  }
  50% {
    opacity: 0.8;
  }
}

.target-indicator {
  animation: pulse 2s ease-in-out infinite;
}
</style>
