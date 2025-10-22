<template>
  <UButton
      :aria-expanded="isMobileMenuOpen"
      aria-label="Toggle menu"
      class="size-10 md:hidden focus:outline-none focus:ring-2 focus:ring-amber-300/50 rounded-md transition-all duration-200 hover:cursor-pointer px-0 py-0"
      color="neutral"
      variant="link"
      @click="toggleMenu"
  >
    <span class="sr-only">Menu</span>
    <svg
        :width="svgSize"
        :height="svgSize"
        :viewBox="`0 0 ${svgSize} ${svgSize}`"
        xmlns="http://www.w3.org/2000/svg"
    >
      <!-- Animated Circles -->
      <circle
          v-for="(sephira, index) in treePositions"
          :key="sephira.id"
          :cx="sephira.cx"
          :cy="sephira.cy"
          :r="originalRadius"
          fill="none"
          stroke="white"
          :stroke-width="isTransformed ? 3 : 20"
          :style="getCircleStyle(sephira, index)"
      />

      <!-- Center circle fill that scales from 0 -->
      <circle
          v-if="isTransformed"
          :cx="svgCenterX"
          :cy="concentricCenterY"
          :r="concentricRadii[10]"
          fill="white"
          :style="centerFillStyle"
      />

      <!-- Triangular indicator that appears in concentric mode -->
      <polygon
          :points="`${svgCenterX},${concentricCenterY - 8} ${svgCenterX - 8},${targetTop} ${svgCenterX + 8},${targetTop}`"
          fill="white"
          :style="triangleStyle"
      />
    </svg>
  </UButton>
</template>

<script lang="ts" setup>
import type {Sephira} from "../../utils/types";

const isMobileMenuOpen = useMobileMenu()
const isTransformed = ref(false)
const centerFilled = ref(false)

// Original Tree of Life positions from your design (scaled to fit SVG)
const scaleFactor = 1.4
const treeVerticalOffset = 50

const originalTreePositions = [
  { id: 'keter', cx: 142.5 * scaleFactor, cy: 66.3 * scaleFactor + treeVerticalOffset },
  { id: 'chokmah', cx: 248.7 * scaleFactor, cy: 123.9 * scaleFactor + treeVerticalOffset },
  { id: 'binah', cx: 35.2 * scaleFactor, cy: 124.8 * scaleFactor + treeVerticalOffset },
  { id: 'chesed', cx: 36.2 * scaleFactor, cy: 218.4 * scaleFactor + treeVerticalOffset },
  { id: 'gevurah', cx: 248.7 * scaleFactor, cy: 218.4 * scaleFactor + treeVerticalOffset },
  { id: 'tiferet', cx: 141.5 * scaleFactor, cy: 257.4 * scaleFactor + treeVerticalOffset },
  { id: 'netzach', cx: 35.2 * scaleFactor, cy: 312 * scaleFactor + treeVerticalOffset },
  { id: 'hod', cx: 248.7 * scaleFactor, cy: 312 * scaleFactor + treeVerticalOffset },
  { id: 'yesod', cx: 142.5 * scaleFactor, cy: 352 * scaleFactor + treeVerticalOffset },
  { id: 'malkut', cx: 142.5 * scaleFactor, cy: 446.6 * scaleFactor + treeVerticalOffset },
  { id: 'daat', cx: 141.5 * scaleFactor, cy: 163.8 * scaleFactor + treeVerticalOffset }
]

const originalRadius = 34.2 * scaleFactor

// Calculate the actual bounds of the Tree of Life from raw positions (without treeVerticalOffset)
const rawTreePositions = [
  { id: 'keter', cx: 142.5 * scaleFactor, cy: 66.3 * scaleFactor },
  { id: 'chokmah', cx: 248.7 * scaleFactor, cy: 123.9 * scaleFactor },
  { id: 'binah', cx: 35.2 * scaleFactor, cy: 124.8 * scaleFactor },
  { id: 'chesed', cx: 36.2 * scaleFactor, cy: 218.4 * scaleFactor },
  { id: 'gevurah', cx: 248.7 * scaleFactor, cy: 218.4 * scaleFactor },
  { id: 'tiferet', cx: 141.5 * scaleFactor, cy: 257.4 * scaleFactor },
  { id: 'netzach', cx: 35.2 * scaleFactor, cy: 312 * scaleFactor },
  { id: 'hod', cx: 248.7 * scaleFactor, cy: 312 * scaleFactor },
  { id: 'yesod', cx: 142.5 * scaleFactor, cy: 352 * scaleFactor },
  { id: 'malkut', cx: 142.5 * scaleFactor, cy: 446.6 * scaleFactor },
  { id: 'daat', cx: 141.5 * scaleFactor, cy: 163.8 * scaleFactor }
]

const rawTreeTopEdge = Math.min(...rawTreePositions.map(p => p.cy)) - originalRadius
const rawTreeBottomEdge = Math.max(...rawTreePositions.map(p => p.cy)) + originalRadius
const actualTreeHeight = rawTreeBottomEdge - rawTreeTopEdge

// Now apply the treeVerticalOffset to get the actual tree bounds
const treeTopEdge = rawTreeTopEdge + treeVerticalOffset

// Make SVG square with size equal to tree height
const svgSize = Math.ceil(actualTreeHeight) + 6
const svgCenterX = svgSize / 2

// Center the tree vertically in the square SVG
const verticalPadding = (svgSize - actualTreeHeight) / 2
const targetTop = verticalPadding
const concentricCenterY = svgSize / 2

// Adjust tree positions to be centered in the square SVG
const treePositions = computed(() => {
  return originalTreePositions.map(pos => ({
    ...pos,
    cx: pos.cx + (svgCenterX - 141.5 * scaleFactor), // Center horizontally
    cy: pos.cy - treeTopEdge + verticalPadding // Center vertically, removing original offset and applying new centering
  }))
})

// Make concentric circles match the actual tree height
const maxRadius = actualTreeHeight / 2 - 8
const concentricRadii = computed(() => {
  return Array.from({ length: 11 }, (_, i) => {
    return maxRadius * (1 - i * 0.09) // Each circle is 9% smaller
  })
})

const toggleMenu = () => {
  isMobileMenuOpen.value = !isMobileMenuOpen.value
}
const toggleTransformation = () => {
  isTransformed.value = !isTransformed.value

  if (isTransformed.value) {
    centerFilled.value = false
    setTimeout(() => {
      centerFilled.value = true
    }, 1100) // After triangle completes (0.3s delay + 0.8s duration)
  } else {
    centerFilled.value = false
  }
}

const getCircleStyle = (sephira: Sephira, index: number) => {
  const targetRadius = concentricRadii.value[index]

  return {
    transition: 'all 1.5s cubic-bezier(0.4, 0, 0.2, 1)',
    transform: isTransformed.value
        ? `translate(${svgCenterX - sephira.cx}px, ${concentricCenterY - sephira.cy}px) scale(${targetRadius / originalRadius})`
        : 'translate(0, 0) scale(1)',
    transformOrigin: `${sephira.cx}px ${sephira.cy}px`
  }
}

const centerFillStyle = computed(() => ({
  transition: 'transform 0.5s ease-out',
  transform: centerFilled.value ? 'scale(1)' : 'scale(0)',
  transformOrigin: `${svgCenterX}px ${concentricCenterY}px`
}))

const triangleStyle = computed(() => ({
  transition: 'transform 0.8s ease-in-out, opacity 0.1s ease-in-out',
  opacity: isTransformed.value ? 1 : 0,
  transform: isTransformed.value ? 'scaleY(1)' : 'scaleY(0)',
  transformOrigin: `${svgCenterX}px ${targetTop}px`,
  transitionDelay: isTransformed.value ? '0.3s' : '0s'
}))

watch(isMobileMenuOpen, () => {
  toggleTransformation()
})
</script>

