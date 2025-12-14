<script setup lang="ts">
const { user, logout } = useUser()

const isLoginModalOpen = ref(false)
</script>

<template>
  <header class="AppHeader">
    <template v-if="user">
      <p>logged as {{ user.email }}</p>

      <button @click="logout">
        log out
      </button>
    </template>

    <button
      v-else
      @click="isLoginModalOpen = true"
    >
      login
    </button>

    <Modal v-model:is-open="isLoginModalOpen">
      <LoginModal />
    </Modal>
  </header>
</template>

<style lang="scss" scoped>
.AppHeader {
  background: rgba($black, 0.2);
}
</style>
