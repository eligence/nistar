<template>
<section class="grid grid-cols-1 lg:grid-cols-3">
  <slot name="header"><h1 class="justify-self-center mt-8 lg:justify-self-start lg:mt-0">{{ header }}</h1></slot>
  <div class="text-center">
    <slot name="default" />
  </div>
  <div class="text-center">
    <slot name="details" />
  </div>
</section>
</template>

<script setup lang="ts">
defineProps<{
  header?: 'boolean'
}>()
</script>

<style scoped>
section {
  min-height: calc(100vh - 56px);
  margin-top: 56px; /* Space for fixed header */
}
</style>
