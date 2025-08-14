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

        <!-- Navigation Links -->
        <nav class="flex flex-wrap justify-center space-x-6">
          <NuxtLink
              to="#about"
              class="text-sm hover:text-primary transition-colors duration-300"
              @click.prevent="scrollToSection('about')"
          >
            About
          </NuxtLink>
          <NuxtLink
              to="#listen"
              class="text-sm hover:text-primary transition-colors duration-300"
              @click.prevent="scrollToSection('listen')"
          >
            Listen
          </NuxtLink>
          <NuxtLink
              to="#contact"
              class="text-sm hover:text-primary transition-colors duration-300"
              @click.prevent="scrollToSection('contact')"
          >
            Contact
          </NuxtLink>
        </nav>

        <!-- Back to Top -->
        <button
            @click="scrollToTop"
            class="hidden md:flex items-center hover:text-primary transition-colors duration-300 mt-4 md:mt-0 group"
            aria-label="Back to top"
        >
          <span class="text-xs mr-2 group-hover:translate-y-[-2px] transition-transform duration-300">BACK TO TOP</span>
          <UIcon name="i-heroicons-arrow-up" class="w-4 h-4" />
        </button>
      </div>

      <!-- Small Print -->
      <div class="mt-8 pt-6 border-t border-gray-800/30 text-center">
        <p class="text-xs text-gray-500">
          NISTAR - נִסְתָּר - The Hidden Light in Music
        </p>
      </div>
    </div>
  </footer>
</template>

<script setup lang="ts">

</script>

<style scoped>

</style>
