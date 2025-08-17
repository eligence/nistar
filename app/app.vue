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
</script>
