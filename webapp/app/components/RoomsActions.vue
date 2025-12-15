<script setup lang="ts">
const isCreateRoomModalOpen = ref(false)
const isJoinRoomModalOpen = ref(false)
</script>

<template>
  <div class="RoomsActions">
    <AppButton
      as="button"
      label="Add a new channel"
      icon="fa7-regular:plus-square"
      @click="isCreateRoomModalOpen = true"
    />

    <AppButton
      as="button"
      label="Join a channel"
      icon="fa7-regular:comments"
      @click="isJoinRoomModalOpen = true"
    />

    <CreateRoomModal v-model:is-open="isCreateRoomModalOpen" />
    <JoinRoomModal v-model:is-open="isJoinRoomModalOpen" />
  </div>
</template>

<style lang="scss" scoped>
.RoomsActions {
  display: flex;
  flex-direction: column;
  gap: toRem(10);
}
</style>
