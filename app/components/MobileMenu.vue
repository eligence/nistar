<template>
  <Transition
      enter-active-class="transition duration-1000 ease-out"
      enter-from-class="opacity-0 -translate-y-4"
      enter-to-class="opacity-100 translate-y-0"
      leave-active-class="transition duration-300 ease-in"
      leave-from-class="opacity-100 translate-y-0"
      leave-to-class="opacity-0 -translate-y-4"
  >
    <div
        v-if="isMobileMenuOpen"
        class="md:hidden bg-black/95 backdrop-blur-lg w-full fixed top-0 left-0 right-0 bottom-0 py-6 px-4 shadow-lg border-t border-gray-800 flex flex-col justify-center z-30 glow"
    >
      <ParticleSystem
        :density="70"
        :speed="1.2"
        :start-area="particleArea"
        :mid-area="particleArea"
        :end-area="particleArea"
        :show-end-area-text="true"
      />
      <EtzChaim :show-lines="true" class="absolute top-60 left-1/2 transform -translate-x-1/2 opacity-3 size-50" />
      <nav class="flex flex-col space-y-6 items-center">
        <ULink
            v-for="item in orderedNavItems"
            :key="item"
            :to="item.to"
            class="text-xl text-white hover:text-purple-300 transition-colors duration-200 w-full text-center py-2 relative"
            @click="isMobileMenuOpen = false"
        >
          {{ item.label }}
          <span
              v-if="item.to === route.path"
              class="absolute bottom-0 left-1/2 transform -translate-x-1/2 w-1/4 h-0.5 bg-purple-400 transition-all duration-300"
          ></span>
        </ULink>
      </nav>
      <div class="absolute left-0 right-0 bottom-8 w-full flex justify-center">
        <SocialLinks />
      </div>
    </div>
  </Transition>
</template>

<script setup lang="ts">
interface NavItem {
  to: string;
  label: string;
}

const props = defineProps<{
  navItems: NavItem[]
}>()

const isMobileMenuOpen = useMobileMenu()
const route = useRoute() // Get current route

const orderedNavItems = computed(() => {
  const itemsWithHome = [...(props.navItems || []), { to: '/', label: 'home' }];
  return itemsWithHome.sort((a, b) => {
    // Sort active item to the top
    if (a.to === route.path) return -1;
    if (b.to === route.path) return 1;
    // Otherwise, sort alphabetically by label, with null/undefined safety
    return (a.label || '').localeCompare(b?.label || '');
  });
});

const particleArea = {
  x: {min: 0.22, max: 0.78},
  y: {min: 0.05, max: 0.15},
}
</script>

<style scoped>
.glow {
  text-shadow:
      -1px -1px 0 rgba(139, 69, 19, 0.8),
      1px -1px 0 rgba(139, 69, 19, 0.8),
      -1px 1px 0 rgba(139, 69, 19, 0.8),
      1px 1px 0 rgba(139, 69, 19, 0.8),
      0 -2px 8px rgba(255, 140, 0, 0.4),
      0 0 3px rgba(255, 165, 0, 0.6),
      0 0 8px rgba(255, 140, 0, 0.5),
      0 0 20px rgba(255, 69, 0, 0.3),
      0 0 35px rgba(255, 69, 0, 0.2),
      0 3px 6px rgba(0, 0, 0, 0.7);
}
</style>
