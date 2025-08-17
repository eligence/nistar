<template>
  <footer class="backdrop-blur-sm border-t border-foreground/10 relative z-10" :class="{ 'hidden': isMobileMenuOpen }">
    <div class="container mx-auto px-4 py-8">
      <div class="flex flex-col md:flex-row justify-between items-center">
        <!-- Copyright -->
        <div class="mb-4 md:mb-0">
          <p class="text-sm">
            &copy; {{ new Date().getFullYear() }} NISTAR. ALL RIGHTS RESERVED.
          </p>
        </div>
        <div class="flex flex-wrap justify-center space-x-6">
         <SocialLinks />
        </div>
        <div class="glass-text mt-4 md:mt-0">NISTAR - נִסְתָּר - The Hidden Light in Music</div>
      </div>
    </div>
  </footer>
</template>
<script setup lang="ts">
import {useMobileMenu} from "../composables/useMobileMenu";

const { isMobileMenuOpen } = useMobileMenu()
</script>

<style scoped>
.glass-text {
  background: rgba(255, 255, 255, 0.2);
  backdrop-filter: blur(2px);
  -webkit-backdrop-filter: blur(12px);
  background-clip: text;
  -webkit-background-clip: text;
  color: transparent;
  font-weight: 500;
}
</style>
