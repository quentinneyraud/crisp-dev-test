<script setup lang="ts">
const user = useSupabaseUser()
const client = useSupabaseClient()

console.log(user)
console.log(client)
</script>

<template>
  <main class="Index">
    Index
  </main>
</template>

<style lang="scss" scoped>
</style>
