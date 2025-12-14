<script setup lang="ts">
import type { AppInputModel } from '../AppInput.vue'

const user = useUser()

const isOpen = defineModel<boolean>('isOpen', {
  required: true,
})

function login() {
  user.login(emailInput.value)
}

const emailInput: AppInputModel = {
  value: '',
  error: undefined,
}
</script>

<template>
  <Modal v-model:is-open="isOpen">
    <p class="AppTitle-1">
      Login
    </p>

    <form
      class="LoginModal-form"
      @submit.prevent="login"
    >
      <div class="LoginModal-fields">
        <AppInput
          type="email"
          name="email"
          :model-value="emailInput"
          label="Email"
          placeholder="Votre email"
          required
        />
      </div>

      <AppButton
        class="LoginModal-submitButton"
        as="button"
        type="submit"
        label="Sign in"
      />
    </form>
  </modal>
</template>

<style lang="scss" scoped>
.LoginModal-form {
  margin-top: toRem(40);
}

.LoginModal-submitButton {
  margin-top: toRem(50);
}
</style>
