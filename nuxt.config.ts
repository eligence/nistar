// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  devtools: { enabled: false },

  modules: ['@nuxt/ui', '@nuxt/eslint', '@nuxt/image', '@nuxt/scripts', '@tresjs/nuxt', '@nuxtjs/robots', '@nuxtjs/sitemap', 'nuxt-viewport'],

  // SEO Configuration
  app: {
    head: {
      title: 'Nistar | Chassidic Funk, Soul & Jazz Music',
      htmlAttrs: {
        lang: 'en'
      },
      meta: [
        { charset: 'utf-8' },
        { name: 'viewport', content: 'width=device-width, initial-scale=1' },
        {
          name: 'description',
          content: 'Nistar creates spiritually uplifting music that fuses traditional Jewish melodies with contemporary funk, soul, and jazz influences. Based in Florida.'
        },
        {
          name: 'keywords',
          content: 'Nistar, Nistar band, Nistar music, Nistar Florida, Nistar Jewish, Jewish music, soul, funk, jazz, fusion, Jewish soul, Jewish funk, Jewish jazz, Jewish fusion, Chassidic music, Florida Jewish music'
        },

        // Open Graph / Facebook
        { property: 'og:type', content: 'website' },
        { property: 'og:url', content: 'https://www.nistarband.com' },
        { property: 'og:title', content: 'Nistar | Chassidic Funk, Soul & Jazz Music' },
        {
          property: 'og:description',
          content: 'Experience the unique fusion of Chassidic melodies with contemporary funk, soul, and jazz. Based in Florida, performing worldwide.'
        },
        { property: 'og:image', content: 'https://www.nistarband.com/Nister_Logo-eng.png' },

        // Twitter
        { name: 'twitter:card', content: 'summary_large_image' },
        { name: 'twitter:url', content: 'https://www.nistarband.com' },
        { name: 'twitter:title', content: 'Nistar | Chassidic Funk, Soul & Jazz' },
        {
          name: 'twitter:description',
          content: 'Fusing traditional Jewish music with contemporary funk, soul, and jazz. Based in Florida.'
        },
        { name: 'twitter:image', content: 'https://www.nistarband.com/Nister_Logo-eng.png' }
      ],
      link: [
        { rel: 'canonical', href: 'https://www.nistarband.com' },
        { rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' }, // Updated favicon path
        {
          rel: 'stylesheet',
          href: 'https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&family=Inter:wght@100..900&family=Tinos:ital,wght@0,400;0,700;1,400;1,700&display=swap',
          crossorigin: ''
        }
      ]
    }
  },
  nitro: {
    prerender: {
      routes: ['/sitemap.xml']
    }
  },
  // Site configuration (required for sitemap)
  site: {
    url: 'https://www.nistarband.com',
  },

  // Sitemap configuration
  sitemap: {
    hostname: 'https://www.nistarband.com',
    gzip: true,
    routes: [
      '/',
      '/about',
      '/listen',
      '/shows',
      '/contact'
    ]
  },

  // Robots.txt configuration
  robots: {
    robotsTxt: false, // Disable automatic robots.txt generation
    UserAgent: '*',
    Allow: '/',
    Sitemap: 'https://www.nistarband.com/sitemap.xml'
  },

  // Module configurations
  tres: {
    devtools: false,
    glsl: true,
  },
  css: ['~/assets/css/main.css'],

  compatibilityDate: '2025-07-16',

  // Image optimization
  image: {
    domains: ['nistarband.com'],
    format: ['webp'],
    quality: 80,
    screens: {
      xs: 320,
      sm: 640,
      md: 768,
      lg: 1024,
      xl: 1280,
      xxl: 1536,
    },
  }
})