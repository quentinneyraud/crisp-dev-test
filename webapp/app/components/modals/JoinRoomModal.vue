<script setup lang="ts">
import type { AppInputModel } from '../ui/AppInput.vue'

const { joinRoom } = useRoom()

const isOpen = defineModel<boolean>('isOpen', {
  required: true,
})

async function handleSubmit() {
  await joinRoom(roomNameInput.value)

  roomNameInput.value = ''
  isOpen.value = false
}

const roomNameInput: AppInputModel = {
  value: '',
  error: undefined,
}
</script>

<template>
  <Modal
    v-model:is-open="isOpen"
    title="Join a channel"
    icon="fa7-regular:comments"
  >
    <form
      class="JoinRoomModal-form"
      @submit.prevent="handleSubmit"
    >
      <div class="JoinRoomModal-fields">
        <AppInput
          type="text"
          name="room_name"
          :model-value="roomNameInput"
          label="Channel name"
          placeholder="Enter a channel name"
          required
        />
      </div>

      <AppButton
        class="JoinRoomModal-submitButton"
        as="button"
        type="submit"
        label="Sign in"
      />
    </form>
  </modal>
</template>

<style lang="scss" scoped>
.JoinRoomModal-submitButton {
  margin-top: toRem(50);
}
</style>
