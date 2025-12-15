<script setup lang="ts">
const { user, logout } = useUser()

const isLoginModalOpen = ref(false)
</script>

<template>
  <aside class="AppAside">
    <RoomsList
      v-if="user"
      class="AppAside-roomsList"
    />

    <div class="AppAside-separator" />

    <div class="AppAside-bottom">
      <template v-if="user">
        <div>
          <p class="text-1">
            Logged as
          </p>

          <p class="text-2">
            {{ user.email }}
          </p>
        </div>

        <button @click="logout">
          log out
        </button>
      </template>

      <AppButton
        v-else
        class="AppAside-loginButton"
        as="button"
        label="Login"
        @click="isLoginModalOpen = true"
      />

      <LoginModal v-model:is-open="isLoginModalOpen" />
    </div>
  </aside>
</template>

<style lang="scss" scoped>
.AppAside {
  position: fixed;
  top: 0;
  left: 0;
  width: $app-aside-width;
  height: 100dvh;
  padding: toRem(30) toRem(15);

  display: flex;
  flex-direction: column;
  gap: toRem(20);

  @include after {
    position: absolute;
    top: toRem(15);
    right: 0;
    width: 1px;
    height: calc(100% - toRem(60));
    background: $app-gradient-bottom;
  }
}

.AppAside-roomsList {
  flex-grow: 1;
}

.AppAside-separator {
  margin-top: auto;
  width: 100%;
  height: 1px;
  background: $app-gradient-right;
}

.AppAside-loginButton {
  width: 100%;
}
</style>
