<script setup lang="ts">
import type { AppInputModel } from '../AppInput.vue'

const { joinRoom } = useRoom()

const isOpen = defineModel<boolean>('isOpen', {
  required: true,
})

function handleSubmit() {
  joinRoom(roomNameInput.value)
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
.JoinRoomModal-form {
  margin-top: toRem(40);
}

.JoinRoomModal-submitButton {
  margin-top: toRem(50);
}
</style>
