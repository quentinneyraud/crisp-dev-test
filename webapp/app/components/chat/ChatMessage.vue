<script setup lang="ts">
import type { Tables } from '../../types/database.types'

export interface ChatMessageProps {
  message: Tables<'message'>
  isOwnMessage: boolean
}
const props = defineProps<ChatMessageProps>()
</script>

<template>
  <div class="ChatMessage">
    <div
      class="ChatMessage-content"
      :style="props.isOwnMessage
        ? {
          borderBottomRightRadius: 0,
        }
        : {
          borderBottomLeftRadius: 0,
        }"
    >
      {{ props.message.content }}
    </div>

    <span
      v-if="props.message.created_at"
      class="ChatMessage-infos AppText-2"
      :style="{
        alignSelf: props.isOwnMessage ? 'flex-end' : 'flex-start',
      }"
    >sent at {{ useDateFormat(props.message.created_at, 'HH:mm') }} on {{ useDateFormat(props.message.created_at, 'DD/MM/YYYY') }}</span>
  </div>
</template>

<style lang="scss" scoped>
.ChatMessage {
  width: toRem(500);
  display: flex;
  flex-direction: column;
}

.ChatMessage-content {
  padding: toRem(15) toRem(30);
  border-radius: 15px;
  background-color: $white;
  color: $app-dark-grey;
}

.ChatMessage-infos {
  display: inline-block;
  margin-top: toRem(5);
  color: rgba($white, 0.5);
}
</style>
