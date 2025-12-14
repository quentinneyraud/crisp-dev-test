import process from 'node:process'

// Sass modules included in templates <style> tags (https://sass-lang.com/documentation/modules/)
type SassModules = 'math' | 'string' | 'color' | 'list' | 'map' | 'selector' | 'meta'
const sassModules: SassModules[] = ['math', 'map']
const sassModulesImportString = sassModules.map(sassModule => `@use "sass:${sassModule}";`).join('')

export default defineNuxtConfig({
  modules: ['@nuxt/eslint', '@vueuse/nuxt'],

  // Remove components prefix
  components: [
    {
      path: '~/components',
      pathPrefix: false,
    },
  ],

  devtools: {
    enabled: true,
  },

  // Global styles
  css: ['@/assets/styles/index.scss'],

  runtimeConfig: {
    public: {
      APP_URL: process.env.APP_URL,
    },
  },

  compatibilityDate: '2025-07-15',

  // SCSS
  vite: {
    css: {
      preprocessorOptions: {
        scss: {
          additionalData: `${sassModulesImportString} @use "@/assets/styles/index.shared.scss" as *;`,
          silenceDeprecations: ['if-function'],
        },
      },
    },
  },

  // Typescript
  typescript: {
    typeCheck: true,
    strict: true,
    tsConfig: {
      compilerOptions: {
        noUncheckedIndexedAccess: true,
      },
    },
  },

  // Eslint
  eslint: {
    config: {
      stylistic: true,
      standalone: false,
    },
  },
})
