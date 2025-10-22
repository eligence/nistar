<template>
  <UButton
    v-for="(item, i) in navItems"
    :key="i"
    :to="item.to"
    :icon="item.icon"
    :aria-label="item.ariaLabel"
    class="text-white hover:text-blue-300 focus:outline-none focus:ring-2 focus:ring-amber-300/50 rounded-md transition-all duration-200"
    color="neutral"
    variant="link"
  />
</template>

<script setup lang="ts">
const navItems = [
  {to: 'https://www.instagram.com/nistar_band/', icon: 'i-fa6-brands:instagram', ariaLabel: 'Instagram page link'},
  {to: 'https://www.facebook.com/nistarBand', icon: 'i-fa6-brands:square-facebook', ariaLabel: 'Facebook page link'},
  {to: 'https://www.youtube.com/@nistar_band', icon: 'i-fa6-brands:square-youtube', ariaLabel: 'Youtube page link'},
  {to: 'mailto:eligence@gmail.com', icon: 'i-fa6-regular:envelope', ariaLabel: 'Email link'},
];
</script>
