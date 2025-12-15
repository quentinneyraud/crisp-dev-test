<script setup lang="ts">
import type { Tables } from '../../types/database.types'

export interface RoomHeaderProps {
  name: string
  users: Tables<'profile'>[]
}

const props = defineProps<RoomHeaderProps>()

const isUserListModalOpen = ref(false)
</script>

<template>
  <div class="RoomHeader">
    <p class="AppTitle-2">
      {{ props.name }}
    </p>

    <button @click="isUserListModalOpen = true">
      View members
    </button>

    <UserListModal
      v-model:is-open="isUserListModalOpen"
      :users="props.users"
    />
  </div>
</template>

<style lang="scss" scoped>
.RoomHeader {
  display: flex;
  padding-bottom: toRem(15);
  justify-content: space-between;
  border-bottom: 1px solid $app-light-grey;
}
</style>
