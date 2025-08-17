<template>
<section class="grid lg:grid-cols-[2fr_5fr_2fr]">
  <slot name="header">
    <div class="flex flex-col justify-center align-center text-center lg:text-left">
      <h1>{{ header }}</h1>
    </div>
  </slot>
  <div v-if="slots.default" class="flex flex-col justify-center align-center text-center lg:text-left">
    <slot name="default" />
  </div>
  <div v-if="slots.details" class="flex flex-col justify-center align-center text-center lg:text-left">
    <slot name="details" />
  </div>
</section>
</template>

<script setup lang="ts">
defineProps<{
  header?: 'boolean'
}>()
const slots = useSlots()
</script>

<style scoped>
section {
  min-height: calc(100vh - 56px);
  margin-top: 56px; /* Space for fixed header */
}
</style>
