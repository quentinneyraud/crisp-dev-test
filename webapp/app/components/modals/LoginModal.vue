<script setup lang="ts">
const user = useUser()
const email = ref('')

function login() {
  user.login(email.value)
}
</script>

<template>
  <div class="LoginModal">
    <button @click="login">
      Sign In with E-Mail
    </button>

    <input
      v-model="email"
      type="email"
    >
  </div>
</template>

<style lang="scss" scoped>

</style>
