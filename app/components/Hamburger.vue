<template>
  <UButton
      :aria-expanded="isMobileMenuOpen"
      aria-label="Toggle menu"
      class="size-10 md:hidden text-white focus:outline-none focus:ring-2 focus:ring-amber-300/50 rounded-md transition-all duration-200 hover:cursor-pointer relative"
      color="neutral"
      variant="link"
      @click="toggleMobileMenu"
  >
    <span class="sr-only">Menu</span>
    <div v-if="!isMobileMenuOpen" class="size-6">
      <EtzChaim />
    </div>
    <Or v-else class="absolute top-3 left-0 transform size-10" />
  </UButton>
</template>

<script lang="ts" setup>
defineProps<{
  isMobileMenuOpen?: boolean
}>()
</script>

