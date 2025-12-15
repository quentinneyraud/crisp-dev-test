<script setup lang="ts">
import type { AppInputModel } from '../AppInput.vue'

const isOpen = defineModel<boolean>('isOpen', {
  required: true,
})

const { createRoom } = useRoom()

async function handleSubmit() {
  await createRoom(roomNameInput.value)

  isOpen.value = false
}

const roomNameInput: AppInputModel = {
  value: '',
  error: undefined,
}
</script>

<template>
  <Modal v-model:is-open="isOpen">
    <p class="AppTitle-1">
      Create room
    </p>

    <form
      class="CreateRoomModal-form"
      @submit.prevent="handleSubmit"
    >
      <div class="CreateRoomModal-fields">
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
        class="CreateRoomModal-submitButton"
        as="button"
        type="submit"
        label="Sign in"
      />
    </form>
  </modal>
</template>

<style lang="scss" scoped>
.CreateRoomModal-form {
  margin-top: toRem(40);
}

.CreateRoomModal-submitButton {
  margin-top: toRem(50);
}
</style>
