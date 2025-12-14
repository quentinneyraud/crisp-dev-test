<script setup lang="ts">
const { user, logout } = useUser()

const isLoginModalOpen = ref(false)
</script>

<template>
  <aside class="AppAside">
    <div class="AppAside-top">
      <RoomsList v-if="user" />
    </div>

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
  padding: toRem(15);

  display: flex;
  flex-direction: column;

  @include after {
    position: absolute;
    top: toRem(15);
    right: 0;
    width: 1px;
    height: calc(100% - toRem(60));
    background: $app-gradient-bottom;
  }
}

.AppAside-separator {
  width: 100%;
  height: 1px;
  background: $app-gradient-right;
  margin-top: auto;
}

.AppAside-bottom {
  padding-block: toRem(10);
}

.AppAside-loginButton {
  width: 100%;
}
</style>
