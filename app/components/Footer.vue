<template>
  <footer class="backdrop-blur-sm border-t border-foreground/10 relative z-10">
    <div class="container mx-auto px-4 py-8">
      <div class="flex flex-col md:flex-row justify-between items-center">
        <!-- Copyright -->
        <div class="mb-4 md:mb-0">
          <p class="text-sm">
            &copy; {{ new Date().getFullYear() }} NISTAR. ALL RIGHTS RESERVED.
          </p>
        </div>
        <nav class="flex flex-wrap justify-center space-x-6">
          <UButton
            v-for="item in navItems"
            :to="item.to"
            :icon="item.icon"
            :aria-label="item.ariaLabel"
            class="text-white hover:text-blue-300 focus:outline-none focus:ring-2 focus:ring-amber-300/50 rounded-md transition-all duration-200"
            color="neutral"
            variant="link"
          />
        </nav>

        <div class="text-center">
          <p class="text-xs text-gray-500">
            NISTAR - נִסְתָּר - The Hidden Light in Music
          </p>
        </div>
      </div>
    </div>
  </footer>
</template>

<script setup lang="ts">
const navItems = [
  {to: 'https://www.instagram.com/nistar_band/', icon: 'i-fa6-brands:instagram', ariaLabel: 'Instagram page link'},
  {to: 'https://www.facebook.com/nistarBand', icon: 'i-fa6-brands:square-facebook', ariaLabel: 'Facebook page link'},
  {to: 'mailto:eligence@gmail.com', label: 'about', icon: 'i-fa6-regular:envelope', ariaLabel: 'Email link'},
];
</script>

