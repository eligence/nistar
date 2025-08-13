<template>
  <header
    class="fixed top-0 left-0 right-0 z-50 transition-all duration-500"
    :class="{ 'bg-black/80 backdrop-blur-md shadow-lg': isScrolled || isMobileMenuOpen, 'bg-transparent': !isScrolled && !isMobileMenuOpen }"
  >
    <div class="container mx-auto px-4 py-3">
      <div class="flex items-center justify-between">
        <!-- Logo -->
        <NuxtLink
          to="/"
          class="flex items-center group"
          @click="scrollToTop"
          aria-label="Home"
        >
          <img
            src="/Nister_Logo-eng.png"
            alt="Nistar"
            class="w-10 h-10 transition-all duration-500 group-hover:opacity-90 bg-gray-100 rounded-full shadow-2xl"
          />
        </NuxtLink>

        <!-- Desktop Navigation -->
        <nav class="hidden md:flex items-center gap-4">
          <span class="font-serif text-lg tracking-widest text-amber-300 mr-4">NISTAR</span>
          <div class="h-6 w-px bg-gray-700"></div>
          <NuxtLink
            v-for="item in navItems"
            :key="item.to"
            :to="item.to"
            class="text-sm text-gray-300 hover:text-amber-300 transition-all duration-300 uppercase tracking-widest relative group"
            :class="{ 'text-amber-300': isActive(item.to) }"
            @click="handleNavClick($event, item.to)"
            :aria-label="item.label"
          >
            <span class="relative">
              {{ item.label }}
              <span
                class="absolute -bottom-1 left-0 w-0 h-px bg-amber-300 transition-all duration-300 group-hover:w-full"
                :class="{ 'w-full': isActive(item.to) }"
              ></span>
            </span>
          </NuxtLink>
        </nav>

        <!-- Mobile menu button -->
        <UButton
          color="neutral"
          variant="link"
          class="md:hidden p-2 text-white focus:outline-none focus:ring-2 focus:ring-amber-300/50 rounded-md transition-all duration-200"
          @click="toggleMobileMenu"
          :aria-expanded="isMobileMenuOpen"
          aria-label="Toggle menu"
        >
          <span class="sr-only">Menu</span>
          <svg
              class="w-6 h-6"
              fill="none"
              stroke="currentColor"
              viewBox="0 0 24 24"
              xmlns="http://www.w3.org/2000/svg"
          >
            <path
                v-if="!isMobileMenuOpen"
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M4 6h16M4 12h16m-7 6h7"
            >
            </path>
            <path
                v-else
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M6 18L18 6M6 6l12 12"
            >
            </path>
          </svg>
        </UButton>
      </div>
    </div>

    <!-- Mobile menu -->
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
        class="md:hidden bg-black/95 backdrop-blur-lg w-full absolute top-full left-0 right-0 py-6 px-4 shadow-lg border-t border-gray-800"
      >
        <nav class="flex flex-col space-y-6 items-center">
          <NuxtLink
            v-for="item in navItems"
            :key="item.to"
            :to="item.to"
            class="text-xl text-white hover:text-purple-300 transition-colors duration-200 w-full text-center py-2 relative"
            :class="{ 'text-purple-300': isActive(item.to) }"
            @click="handleNavClick($event, item.to, true)"
          >
            {{ item.label }}
            <span
              class="absolute bottom-0 left-1/2 transform -translate-x-1/2 w-1/2 h-0.5 bg-purple-400 transition-all duration-300"
              :class="{ 'opacity-0': !isActive(item.to) }"
            ></span>
          </NuxtLink>

        </nav>
      </div>
    </Transition>
  </header>
</template>

<script setup>
const route = useRoute();
const isMobileMenuOpen = ref(false);
const isScrolled = ref(false);

const navItems = [
  { to: '/about', label: 'about' },
  { to: '/listen', label: 'listen' },
  { to: '/contact', label: 'contact' },
];

// Handle scroll effect for header
const handleScroll = () => {
  isScrolled.value = window.scrollY > 50;
};

// Check if a nav item is active based on current hash
const isActive = (path) => {
  if (typeof window === 'undefined') return false;
  const hash = window.location.hash || '#';
  return hash === path;
};

// Handle navigation with smooth scroll
const handleNavClick = (event, path, isMobile = false) => {
  if (isMobile) {
    isMobileMenuOpen.value = false;
    document.body.style.overflow = '';
  }

  // If we're already on the page, just scroll to the section
  if (path.startsWith('#')) {
    event.preventDefault();
    const target = document.querySelector(path);
    if (target) {
      const headerOffset = 80;
      const elementPosition = target.getBoundingClientRect().top;
      const offsetPosition = elementPosition + window.pageYOffset - headerOffset;

      window.scrollTo({
        top: offsetPosition,
        behavior: 'smooth'
      });

      // Update URL without adding to history
      history.replaceState(null, null, path);
    }
  }
};

// Scroll to top when clicking the logo
const scrollToTop = (event) => {
  if (window.location.pathname === '/' && !window.location.hash) {
    event.preventDefault();
    window.scrollTo({
      top: 0,
      behavior: 'smooth'
    });
    history.replaceState(null, null, ' ');
  }
};

const toggleMobileMenu = () => {
  isMobileMenuOpen.value = !isMobileMenuOpen.value;
  document.body.style.overflow = isMobileMenuOpen.value ? '' : 'hidden';
};

const closeMobileMenu = () => {
  isMobileMenuOpen.value = false;
  document.body.style.overflow = '';
};

// Close mobile menu when clicking outside
const handleClickOutside = (event) => {
  const navbar = document.querySelector('header');
  const menuButton = document.querySelector('button[aria-label="Toggle menu"]');

  if (isMobileMenuOpen.value &&
      !navbar.contains(event.target) &&
      !menuButton.contains(event.target)) {
    closeMobileMenu();
  }
};

// Add event listeners
onMounted(() => {
  window.addEventListener('scroll', handleScroll);
  document.addEventListener('click', handleClickOutside);

  // Close menu on route change
  const unwatch = watch(() => route.hash, () => {
    closeMobileMenu();
  });

  // Cleanup
  onBeforeUnmount(() => {
    window.removeEventListener('scroll', handleScroll);
    document.removeEventListener('click', handleClickOutside);
    unwatch();
  });
});
</script>

<style scoped>
/* Custom styles for the navbar */
header {
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
  backdrop-filter: blur(8px);
  -webkit-backdrop-filter: blur(8px);
}

   /* Custom animation for the menu icon */
svg {
 transform-origin: center;
}

/* Smooth transition for the paths */
path {
  transform-origin: center;
  transition-property: transform, opacity;
  transition-timing-function: cubic-bezier(0.4, 0, 0.2, 1);
  transition-duration: 300ms;
}

/* Ensure the header is above other content */
header {
  z-index: 1000;
}

/* Nav link hover effect */
nav a {
  position: relative;
  overflow: hidden;
}

/* Animation for the active link indicator */
@keyframes slideIn {
  from {
    transform: translateX(-100%);
  }
  to {
    transform: translateX(0);
  }
}
</style>
