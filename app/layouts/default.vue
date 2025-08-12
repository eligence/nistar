<template>
  <div class="min-h-screen flex flex-col bg-background text-foreground relative overflow-hidden">
    <!-- Decorative Elements -->
    <Elements />

    <!-- Noise Overlay -->
    <div class="fixed inset-0 bg-noise pointer-events-none -z-10" aria-hidden="true"></div>

    <!-- Gradient Overlay -->
    <div class="fixed inset-0 bg-gradient-to-b from-background/70 via-background/50 to-background/90 pointer-events-none -z-10" aria-hidden="true"></div>

    <!-- Navbar Component -->
    <Navbar />

    <!-- Page Content -->
    <main class="flex-grow relative z-0">
      <slot />
    </main>

    <!-- Footer -->
    <footer class="bg-background/80 backdrop-blur-sm border-t border-foreground/10 relative z-10">
      <div class="container mx-auto px-4 py-8">
        <div class="flex flex-col md:flex-row justify-between items-center">
          <!-- Copyright -->
          <div class="mb-4 md:mb-0">
            <p class="text-sm text-foreground/60">
              &copy; {{ new Date().getFullYear() }} NISTAR. ALL RIGHTS RESERVED.
            </p>
          </div>

          <!-- Navigation Links -->
          <nav class="flex flex-wrap justify-center space-x-6">
            <NuxtLink
              to="#about"
              class="text-sm text-foreground/70 hover:text-primary transition-colors duration-300"
              @click.prevent="scrollToSection('about')"
            >
              About
            </NuxtLink>
            <NuxtLink
              to="#listen"
              class="text-sm text-foreground/70 hover:text-primary transition-colors duration-300"
              @click.prevent="scrollToSection('listen')"
            >
              Listen
            </NuxtLink>
            <NuxtLink
              to="#contact"
              class="text-sm text-foreground/70 hover:text-primary transition-colors duration-300"
              @click.prevent="scrollToSection('contact')"
            >
              Contact
            </NuxtLink>
          </nav>

          <!-- Back to Top -->
          <button
            @click="scrollToTop"
            class="hidden md:flex items-center text-foreground/70 hover:text-primary transition-colors duration-300 mt-4 md:mt-0 group"
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
  </div>
</template>

<script setup>
// Import components
import Navbar from '~/components/Navbar.vue';
import Elements from '~/components/decorative/Elements.vue';

// Import useHead
import { useHead } from '#imports';

// Meta tags for SEO
useHead({
  titleTemplate: (title) => {
    return title ? `${title} | NISTAR` : 'NISTAR';
  },
  meta: [
    {
      name: 'description',
      content: 'NISTAR - The Hidden Sound of Divine Connection. Chassidic Funk, Soul, and Jazz Originals. Imbuing music with Divine meditation and improvisation.'
    },
    {
      name: 'keywords',
      content: 'NISTAR, Chassidic music, Jewish music, Kabbalah music, spiritual music, funk, soul, jazz, improvisation'
    },
    {
      name: 'theme-color',
      content: '#0a0a0a'
    },
    {
      property: 'og:type',
      content: 'website'
    },
    {
      property: 'og:site_name',
      content: 'NISTAR'
    },
    {
      property: 'og:title',
      content: 'NISTAR - The Hidden Sound of Divine Connection'
    },
    {
      property: 'og:description',
      content: 'Chassidic Funk, Soul, and Jazz Originals. Imbuing music with Divine meditation and improvisation.'
    },
    {
      property: 'og:image',
      content: '/nistar-og-image.jpg'
    },
    {
      name: 'twitter:card',
      content: 'summary_large_image'
    },
    {
      name: 'twitter:title',
      content: 'NISTAR - The Hidden Sound of Divine Connection'
    },
    {
      name: 'twitter:description',
      content: 'Chassidic Funk, Soul, and Jazz Originals. Imbuing music with Divine meditation and improvisation.'
    },
    {
      name: 'twitter:image',
      content: '/nistar-og-image.jpg'
    }
  ],
  link: [
    {
      rel: 'icon',
      type: 'image/png',
      href: '/favicon.ico'
    },
    {
      rel: 'apple-touch-icon',
      sizes: '180x180',
      href: '/apple-touch-icon.png'
    },
    {
      rel: 'icon',
      type: 'image/png',
      sizes: '32x32',
      href: '/favicon-32x32.png'
    },
    {
      rel: 'icon',
      type: 'image/png',
      sizes: '16x16',
      href: '/favicon-16x16.png'
    },
    {
      rel: 'manifest',
      href: '/site.webmanifest'
    }
  ]
});

// Scroll to top function for the footer
const scrollToTop = () => {
  window.scrollTo({
    top: 0,
    behavior: 'smooth'
  });
};

// Scroll to section with offset for fixed header
const scrollToSection = (id) => {
  const element = document.getElementById(id);
  if (element) {
    const headerOffset = 80;
    const elementPosition = element.getBoundingClientRect().top;
    const offsetPosition = elementPosition + window.pageYOffset - headerOffset;

    window.scrollTo({
      top: offsetPosition,
      behavior: 'smooth'
    });
  }
};

// Add smooth scrolling to anchor links
onMounted(() => {
  document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
      const href = this.getAttribute('href');
      if (href !== '#') {
        e.preventDefault();
        const target = document.querySelector(href);
        if (target) {
          const headerOffset = 80;
          const elementPosition = target.getBoundingClientRect().top;
          const offsetPosition = elementPosition + window.pageYOffset - headerOffset;

          window.scrollTo({
            top: offsetPosition,
            behavior: 'smooth'
          });
        }
      }
    });
  });
});
</script>

<style scoped>
/* Noise texture for the background */
.bg-noise {
  background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 200 200' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='noiseFilter'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.65' numOctaves='3' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23noiseFilter)' opacity='0.1'/%3E%3C/svg%3E");
  background-repeat: repeat;
  background-size: 200px 200px;
}

/* Smooth scrolling for the entire page */
html {
  scroll-behavior: smooth;
}

/* Ensure proper spacing for fixed header */
body {
  padding-top: 80px;
}

/* Responsive adjustments */
@media (max-width: 767px) {
  body {
    padding-top: 60px;
  }
}
</style>
