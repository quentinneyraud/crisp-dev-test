<script setup lang="ts">
import type { AppInputModel } from '../ui/AppInput.vue'

const user = useUser()

const linkSent = ref(false)

const isOpen = defineModel<boolean>('isOpen', {
  required: true,
})

async function login() {
  await user.login(emailInput.value)
  linkSent.value = true
}

const emailInput: AppInputModel = {
  value: '',
  error: undefined,
}
</script>

<template>
  <Modal
    v-model:is-open="isOpen"
    title="Login"
    icon="fa7-regular:user"
  >
    <form @submit.prevent="login">
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

    <p
      v-if="linkSent"
      class="LoginModal-instruction"
    >
      Click on the link sent by email
    </p>
  </modal>
</template>

<style lang="scss" scoped>
.LoginModal-submitButton {
  margin-top: toRem(50);
}

.LoginModal-instruction {
  margin-top: toRem(20);
}
</style>
