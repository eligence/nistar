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
        class="md:hidden bg-black/95 backdrop-blur-lg w-full fixed top-0 left-0 right-0 bottom-0 py-6 px-4 shadow-lg border-t border-gray-800 flex flex-col justify-center z-30"
    >
      <AnimationsParticleSystem
        :density="70"
        :speed="1.2"
        :start-area="particleArea"
        :mid-area="particleArea"
        :end-area="particleArea"
        :show-end-area-text="true"
      />
      <IconsEtzChaim :show-lines="true" class="absolute top-60 left-1/2 transform -translate-x-1/2 opacity-3 size-50" />
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
        <UiSocialLinks />
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
  const items = [...(props.navItems || [])];
  const homeItem = { to: '/', label: 'home' };

  // Find the active item (if any, and it's not home)
  const activeIndex = items.findIndex(item =>
      item.to === route.path && item.to !== '/'
  );
  const activeItem = activeIndex >= 0 ? items.splice(activeIndex, 1)[0] : null;

  // Find home in the remaining items (if it exists)
  const homeIndex = items.findIndex(item => item.to === '/');
  const existingHome = homeIndex >= 0 ? items.splice(homeIndex, 1)[0] : homeItem;

  // Build the final array
  const result = [];

  // 1. Active item first (if exists and not home)
  if (activeItem) {
    result.push(activeItem);
  }

  // 2. Home second (unless it's the active item)
  if (route.path !== '/' || !activeItem) {
    result.push(existingHome);
  }

  // 3. All other items in their original order
  return [...result, ...items];
});

const particleArea = {
  x: {min: 0.22, max: 0.78},
  y: {min: 0.05, max: 0.15},
}
</script>
