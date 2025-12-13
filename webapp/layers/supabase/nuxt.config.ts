export default defineNuxtConfig({
  modules: [
    '@nuxtjs/supabase',
  ],

  // Solve "ReferenceError: exports is not defined" issue (see: https://github.com/nuxt-modules/supabase/issues/566)
  vite: {
    optimizeDeps: {
      include: [
        '@nuxtjs/supabase > @supabase/supabase-js',
        '@nuxtjs/supabase > @supabase/postgrest-js',
        '@nuxtjs/supabase > @supabase/auth-js',
        '@nuxtjs/supabase > @supabase/realtime-js',
        '@nuxtjs/supabase > @supabase/storage-js',
        '@nuxtjs/supabase > @supabase/functions-js',
      ],
    },
  },

  supabase: {
    redirectOptions: {
      login: '/login',
      callback: '/confirm',
      include: undefined,
      exclude: [],
      saveRedirectToCookie: true,
    },
  },
})
