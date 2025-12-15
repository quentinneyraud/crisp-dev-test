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
  height: 100dvh;
}

.ChatLayout-main {
  height: 100dvh;
}
</style>
