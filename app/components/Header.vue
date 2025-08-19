<template>
  <header class="fixed top-0 left-0 right-0 z-50 transition-all duration-500 px-1 py-2 md:px-4 glass-bg"
    >
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
        <span v-if="route.name !== 'index'" class="font-serif text-lg tracking-widest text-amber-300 mr-4">NISTAR</span>
        <div v-if="route.name !== 'index'" class="h-6 w-px bg-gray-700"></div>
        <ULink
            v-for="item in navItems"
            :key="item.to"
            :aria-label="item.label"
            :to="item.to"
            active-class="font-bold text-purple-400"
            class="text-sm hover:text-purple-400 transition-all duration-300 uppercase tracking-widest relative group"
            inactive-class="text-gray-300"
        >
            <span class="relative">
              {{ item.label }}
              <span
                  :class="{ 'w-full': item.to === route.name }"
                  class="absolute -bottom-1 left-0 w-0 h-px bg-purple-400 transition-all duration-300 group-hover:w-full"
              ></span>
            </span>
        </ULink>
      </nav>
      <MenuToggle :isMobileMenuOpen="isMobileMenuOpen" @click="toggleMobileMenu"/>
    </div>
  </header>
  <MobileMenu :isMobileMenuOpen="isMobileMenuOpen" :navItems="navItems"/>
</template>

<script lang="ts" setup>
import NavItem from "./MobileMenu.vue";
import MenuToggle from "./MenuToggle.vue";
import {useMobileMenu} from "../composables/useMobileMenu";

const route = useRoute();
const {isMobileMenuOpen} = useMobileMenu()

const navItems: NavItem = [
  {to: '/about', label: 'about'},
  {to: '/listen', label: 'listen'},
  {to: '/shows', label: 'shows'},
  {to: '/contact', label: 'contact'}, shows
];

const toggleMobileMenu = () => {
  isMobileMenuOpen.value = !isMobileMenuOpen.value;
};

</script>
