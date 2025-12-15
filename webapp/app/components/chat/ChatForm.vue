<script setup lang="ts">
export interface ChatFormSubmitEventOptions { message: string }

const emit = defineEmits<{
  submit: [ChatFormSubmitEventOptions]
}>()

const message = ref('')
function onSubmit() {
  emit('submit', {
    message: message.value,
  })
}

function clear() {
  message.value = ''
}

defineExpose({
  clear,
})
</script>

<template>
  <form
    class="ChatForm"
    @submit.prevent="onSubmit"
  >
    <input
      v-model="message"
      required
      class="ChatForm-input"
      placeholder="Envoyer un nouveau message"
    >

    <AppButton
      class="ChatForm-submitButton"
      as="button"
      type="submit"
      label="Envoyer"
    />
  </form>
</template>

<style lang="scss" scoped>
.ChatForm {
  display: flex;
  box-shadow: inset 0 0 50px 0 rgba(white, 0.1);
  background: transparent;
  border-radius: 15px;
  padding: toRem(15);
  padding-left: toRem(30);
  gap: toRem(15);
}

.ChatForm-input {
  flex-grow: 1;
}

.ChatForm-submitButton {
  margin-left: auto;
}
</style>
