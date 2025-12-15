<script setup lang="ts">
const { user, logout } = useUser()

const isLoginModalOpen = ref(false)
</script>

<template>
  <aside class="AppAside">
    <template v-if="user">
      <p class="AppAside-title AppSubtitle-1">
        My channels
      </p>

      <div class="AppAside-separator" />

      <RoomsList
        v-if="user"
        class="AppAside-roomsList"
      />

      <RoomsActions
        class="AppAside-actions"
      />
    </template>

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

        <AppButton
          class="AppAside-logoutButton"
          as="button"
          label="log out"
          @click="logout"
        />
      </template>

      <AppButton
        v-else
        class="AppAside-loginButton"
        as="button"
        label="Login"
        icon="fa7-regular:user"
        @click="isLoginModalOpen = true"
      />

      <LoginModal v-model:is-open="isLoginModalOpen" />
    </div>
  </aside>
</template>

<style lang="scss" scoped>
.AppAside {
  position: fixed;
  top: $app-layout-padding;
  bottom: $app-layout-padding;
  left: $app-layout-padding;
  width: $app-aside-width;
  padding: toRem(20) toRem(25);
  z-index: 10;

  display: flex;
  flex-direction: column;
  gap: toRem(20);
  background-color: $app-dark-grey;
  border-radius: 15px;
}

.AppAside-title {
  margin-top: toRem(15);
}

.AppAside-roomsList {
  flex-grow: 1;
  padding-inline: toRem(15);
}

.AppAside-separator {
  margin-top: auto;
  width: 100%;
  height: 1px;
  background: $app-gradient-right;
}

.AppAside-loginButton, .AppAside-logoutButton {
  width: 100%;
}

.AppAside-logoutButton  {
  margin-top: toRem(10);
}
</style>
