<template>
  <header class="fixed top-0 left-0 right-0 z-50 transition-all duration-500 px-1 py-2 md:px-4">
    <div class="flex items-center justify-between">
      <!-- Logo -->
      <NuxtLink
        aria-label="Home"
        class="flex items-center group ml-2.5 md:ml-0"
        to="/"
      >
        <img
          alt="Nistar"
          class="w-10 h-10 transition-all duration-500 group-hover:opacity-90 bg-gray-100 rounded-full shadow-2xl"
          src="/Nister_Logo-eng.png"
        />
      </NuxtLink>
      <!-- Desktop Navigation -->
      <nav class="hidden md:flex items-center gap-4">
        <span class="font-serif text-lg tracking-widest text-amber-300 mr-4">NISTAR</span>
        <div class="h-6 w-px bg-gray-700"></div>
        <ULink
          v-for="item in navItems"
          :key="item.to"
          :aria-label="item.label"
          :to="item.to"
          active-class="font-bold text-blue-300"
          class="text-sm hover:text-blue-300 transition-all duration-300 uppercase tracking-widest relative group"
          inactive-class="text-gray-300"
        >
            <span class="relative">
              {{ item.label }}
              <span
                :class="{ 'w-full': item.to === route.name }"
                class="absolute -bottom-1 left-0 w-0 h-px bg-amber-300 transition-all duration-300 group-hover:w-full"
              ></span>
            </span>
        </ULink>
      </nav>
      <!-- Mobile menu button -->
      <UButton
        :aria-expanded="isMobileMenuOpen"
        aria-label="Toggle menu"
        class="md:hidden text-white focus:outline-none focus:ring-2 focus:ring-amber-300/50 rounded-md transition-all duration-200"
        color="neutral"
        variant="link"
        @click="toggleMobileMenu"
      >
        <span class="sr-only">Menu</span>
        <Hamburger :isMobileMenuOpen="isMobileMenuOpen"/>
      </UButton>
    </div>
  </header>
  <MobileMenu :isMobileMenuOpen="isMobileMenuOpen" :navItems="navItems"/>
</template>

<script setup lang="ts">
import NavItem from "./MobileMenu.vue";
const route = useRoute();
const isMobileMenuOpen = ref(false);

const navItems: NavItem = [
  {to: '/about', label: 'about'},
  {to: '/listen', label: 'listen'},
  {to: '/contact', label: 'contact'},
];

const toggleMobileMenu = () => {
  isMobileMenuOpen.value = !isMobileMenuOpen.value;
};

</script>
