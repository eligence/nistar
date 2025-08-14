<template>
  <div v-if="!isMobileMenuOpen" class="size-6">
    <EtzChaim />
  </div>
  <UIcon v-else name="i-charm:disc" class="size-6" />
</template>

<script lang="ts" setup>
defineProps<{
  isMobileMenuOpen?: boolean
}>()
</script>

