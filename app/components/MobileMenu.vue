<template>
  <Transition
      enter-active-class="transition duration-300 ease-out"
      enter-from-class="opacity-0 -translate-y-4"
      enter-to-class="opacity-100 translate-y-0"
      leave-active-class="transition duration-200 ease-in"
      leave-from-class="opacity-100 translate-y-0"
      leave-to-class="opacity-0 -translate-y-4"
  >
    <div
        v-if="isMobileMenuOpen"
        class="md:hidden bg-black/95 backdrop-blur-lg w-full fixed top-0 left-0 right-0 bottom-0 py-6 px-4 shadow-lg border-t border-gray-800 flex flex-col justify-center z-50"
    >
      <nav class="flex flex-col space-y-6 items-center">
        <ULink
            v-for="item in navItems"
            :key="item"
            :to="item.to"
            class="text-xl text-white hover:text-purple-300 transition-colors duration-200 w-full text-center py-2 relative"
        >
          {{ item.label }}
          <span
              class="absolute bottom-0 left-1/2 transform -translate-x-1/2 w-1/2 h-0.5 bg-purple-400 transition-all duration-300"
          ></span>
        </ULink>
      </nav>
    </div>
  </Transition>
</template>

<script setup lang="ts">
type NavItem = {
  to: string,
  label: string
}
defineProps<{
  isMobileMenuOpen?: boolean,
  navItems: NavItem
}>()
</script>

<style scoped>

</style>
