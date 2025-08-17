<template>
  <div class="min-h-screen flex flex-col relative overflow-hidden">
    <Elements />
    <Navbar />
    <main class="flex-grow relative z-0" :class="{ 'hidden': isMobileMenuOpen }">
      <slot />
    </main>
    <Footer />
  </div>
</template>

<script setup>
import Navbar from '~/components/Navbar.vue';
import Elements from '~/components/decorative/Elements.vue';
import {useMobileMenu} from "../composables/useMobileMenu.js";
const { isMobileMenuOpen } = useMobileMenu()
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
  ]
});
</script>

<style scoped>
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
