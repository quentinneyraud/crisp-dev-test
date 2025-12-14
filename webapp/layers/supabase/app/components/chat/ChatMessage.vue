<script setup lang="ts">
import type { Tables } from '../../../../../app/types/database.types'

export interface ChatMessageProps {
  message: Tables<'message'>
  isOwnMessage: boolean
}
const props = defineProps<ChatMessageProps>()

const contentStyle = computed(() => {
  return props.isOwnMessage
    ? {
        borderBottomRightRadius: 0,
      }
    : {
        borderBottomLeftRadius: 0,
      }
})
</script>

<template>
  <div class="ChatMessage">
    <div
      class="ChatMessage-content"
      :style="contentStyle"
    >
      {{ props.message.content }}
    </div>

    <span
      v-if="props.message.created_at"
      class="ChatMessage-infos AppText-2"
    >{{ useDateFormat(props.message.created_at, 'sent at HH:mm the DD/MM/YYYY') }}</span>
  </div>
</template>

<style lang="scss" scoped>
.ChatMessage {
  width: toRem(500);
}

.ChatMessage-content {
  padding: toRem(15) toRem(30);
  border-radius: 15px;
  background-color: $app-light-purple;
  box-shadow: 0 1px 2px 0 rgba($app-brown, 0.25);
}

.ChatMessage-infos {
  display: inline-block;
  margin-top: toRem(5);
  color: $app-dark-grey;
}
</style>
