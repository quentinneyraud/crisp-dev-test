<script setup lang="ts">
import type { Tables } from '../../types/database.types'

export interface UserListModalProps {
  users: Tables<'profile'>[]
}

const props = defineProps<UserListModalProps>()

const isOpen = defineModel<boolean>('isOpen', {
  required: true,
})
</script>

<template>
  <Modal
    v-model:is-open="isOpen"
    title="Users"
    icon="fa7-regular:rectangle-list"
  >
    <ul>
      <li
        v-for="user in props.users"
        :key="user.id"
      >
        {{ user.email }}
      </li>
    </ul>
  </modal>
</template>

<style lang="scss" scoped>
.JoinRoomModal-submitButton {
  margin-top: toRem(50);
}
</style>
