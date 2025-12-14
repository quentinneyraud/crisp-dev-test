<script setup lang="ts">
import type { Tables } from '../../../../../app/types/database.types'

const props = defineProps<ChatMessagesListProps>()

const user = useSupabaseUser()

export interface ChatMessagesListProps {
  messages: Tables<'message'>[]
}

function isOwnMessage(message: Tables<'message'>) {
  return message.created_by === user.value?.sub
}
</script>

<template>
  <div class="ChatMessagesList">
    <div class="ChatMessagesList-messages">
      <ChatMessage
        v-for="message in props.messages"
        :key="message.id"
        :message="message"
        :is-own-message="isOwnMessage(message)"
        :style="{
          alignSelf: isOwnMessage(message) ? 'flex-end' : 'flex-start',
        }"
      />
    </div>
  </div>
</template>

<style lang="scss" scoped>
.ChatMessagesList {
  overflow-y: auto;
}

.ChatMessagesList-messages {
  display: flex;
  flex-direction: column;
  justify-content: flex-end;
  gap: toRem(15);
}
</style>
