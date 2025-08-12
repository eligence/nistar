import { defineConfig } from 'vitest/config'
import tsconfigPaths from 'vite-tsconfig-paths'
import { fileURLToPath } from 'url'
import tailwindcss from '@tailwindcss/vite'

export default defineConfig({
  plugins: [tsconfigPaths(), tailwindcss(),],
  test: {
    globals: true,
    environment: 'jsdom',
    alias: {
      '@': fileURLToPath(new URL('./', import.meta.url)),
      '~': fileURLToPath(new URL('./', import.meta.url)),
    },
    css: false, // Disable CSS processing in tests
    // Mock CSS and other asset imports
    server: {
      deps: {
        inline: ['nuxt']
      }
    },
    // Mock CSS files
    resolve: {
      alias: {
        '^.+\\.(css|less|scss|sass|styl)$': 'identity-obj-proxy',
      },
    },
  },
})
