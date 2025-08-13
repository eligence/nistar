<template>
  <div class="min-h-screen flex flex-col bg-background text-foreground relative overflow-hidden">
    <Elements />
    <Navbar />

    <!-- Page Content -->
    <main class="flex-grow relative z-0">
      <slot />
    </main>

    <Footer />
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
