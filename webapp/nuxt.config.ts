export default defineNuxtConfig({
  modules: [
    '@nuxt/eslint',
  ],

  devtools: {
    enabled: true,
  },

  compatibilityDate: '2025-07-15',

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
