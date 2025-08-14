<template>
  <div>
    <NuxtLayout>
      <NuxtPage />
    </NuxtLayout>
  </div>
</template>

<script setup>
// Set up global head configuration
useHead({
  htmlAttrs: {
    lang: 'en',
    class: 'h-full scroll-smooth'
  },
  bodyAttrs: {
    class: 'antialiased bg-black text-white min-h-screen font-sans'
  },
  link: [
    { rel: 'preconnect', href: 'https://fonts.googleapis.com' },
    { rel: 'preconnect', href: 'https://fonts.gstatic.com', crossorigin: '' }
  ]
});

// Handle smooth scrolling for anchor links
const route = useRoute();
const router = useRouter();

const scrollToSection = (hash) => {
  if (!hash) return;

  const el = document.querySelector(hash);
  if (el) {
    const headerOffset = 80; // Height of the header
    const elementPosition = el.getBoundingClientRect().top;
    const offsetPosition = elementPosition + window.pageYOffset - headerOffset;

    window.scrollTo({
      top: offsetPosition,
      behavior: 'smooth'
    });
  }
};

// Handle route changes for anchor links
onMounted(() => {
  if (route.hash) {
    // Small timeout to ensure the page is fully loaded
    setTimeout(() => {
      scrollToSection(route.hash);
    }, 100);
  }

  // Listen for hash changes
  window.addEventListener('hashchange', () => {
    if (route.hash) {
      scrollToSection(route.hash);
    }
  });
});
</script>

<style>
/* Global styles */
* {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

html {
  scroll-behavior: smooth;
}

body {
  font-family: 'Nunito Sans', sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  line-height: 1.6;
  overflow-x: hidden;
}

/* Custom scrollbar */
::-webkit-scrollbar {
  width: 8px;
  height: 8px;
}

::-webkit-scrollbar-track {
  background: #0f172a;
}

::-webkit-scrollbar-thumb {
  background: #334155;
  border-radius: 4px;
}

::-webkit-scrollbar-thumb:hover {
  background: #475569;
}

/* Animations */
@keyframes fadeIn {
  from { opacity: 0; }
  to { opacity: 1; }
}

.fade-in {
  animation: fadeIn 0.5s ease-in-out;
}

/* Section styling */
section {
  position: relative;
  width: 100%;
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  scroll-margin-top: 80px; /* Space for fixed header */
  overflow: hidden;
}

/* Responsive typography */
h1, h2, h3, h4, h5, h6 {
  font-family: 'Roboto', sans-serif;
  font-weight: 700;
  line-height: 1.2;
  margin-bottom: 1rem;
}

h1 { font-size: 2.5rem; }
h2 { font-size: 2rem; }
h3 { font-size: 1.75rem; }

@media (min-width: 768px) {
  h1 { font-size: 3.5rem; }
  h2 { font-size: 2.5rem; }
  h3 { font-size: 2rem; }
}

/* Links */
a {
  color: inherit;
  text-decoration: none;
  transition: color 0.3s ease;
}

/* Buttons */
button, .btn {
  cursor: pointer;
  transition: all 0.3s ease;
}

/* Utility classes */
.container {
  width: 100%;
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 1rem;
}

.text-center { text-align: center; }
.mb-4 { margin-bottom: 1rem; }
.mb-8 { margin-bottom: 2rem; }
.mb-12 { margin-bottom: 3rem; }
.py-12 { padding-top: 3rem; padding-bottom: 3rem; }
.py-20 { padding-top: 5rem; padding-bottom: 5rem; }
</style>
