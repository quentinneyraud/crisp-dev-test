<script setup lang="ts">
const supabase = useSupabaseClient()
const email = ref('quentin.neyraud@gmail.com')
const runtimeConfig = useRuntimeConfig()

async function signInWithOtp() {
  const { error } = await supabase.auth.signInWithOtp({
    email: email.value,
    options: {
      emailRedirectTo: `${runtimeConfig.public.APP_URL}/confirm`,
    },
  })
  if (error) console.log('error:', error)
}
</script>

<template>
  <div>
    <button @click.prevent="signInWithOtp">
      Sign In with E-Mail
    </button>

    <input
      v-model="email"
      type="email"
    >
  </div>
</template>
