<script setup lang="ts">
</script>

<template>
  <div class="ChatLayout">
    <AppAside />

    <main class="ChatLayout-main">
      <NuxtPage />
    </main>
  </div>
</template>

<style lang="scss" scoped>
.ChatLayout {
  height: 100vh;
}

.ChatLayout-main {
  padding-left: $app-aside-width;
  height: 100dvh;
}
</style>
