<template>
  <svg
    class="w-6 h-6"
    fill="none"
    stroke="currentColor"
    viewBox="0 0 24 24"
    xmlns="http://www.w3.org/2000/svg"
  >
    <path
      v-if="!isMobileMenuOpen"
      d="M4 6h16M4 12h16m-7 6h7"
      stroke-linecap="round"
      stroke-linejoin="round"
      stroke-width="2"
    >
    </path>
    <path
      v-else
      d="M6 18L18 6M6 6l12 12"
      stroke-linecap="round"
      stroke-linejoin="round"
      stroke-width="2"
    >
    </path>
  </svg>
</template>

<script lang="ts" setup>
defineProps<{
  isMobileMenuOpen?: boolean
}>()
</script>

