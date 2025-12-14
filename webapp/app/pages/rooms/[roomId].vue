<script setup lang="ts">
import type { ChatFormSubmitEventOptions } from '../../../layers/supabase/app/components/chat/ChatForm.vue'

definePageMeta({
  name: 'room-detail',
  layout: 'chat',
})

const route = useRoute()
const roomId = route.params.roomId as string

const { messages, sendMessage } = useMessages(roomId)
const { userRooms } = useRoom()
const { users } = useRoomUsers(roomId)

const chatFormRef = useTemplateRef('chatForm')

const roomName = computed(() => {
  return userRooms.value
    .find(room => room.id === roomId)
    ?.name
})

async function submit({ message }: ChatFormSubmitEventOptions) {
  await sendMessage(message)

  chatFormRef.value?.clear()
}
</script>

<template>
  <div class="RoomDetail">
    <div class="RoomDetail-heading">
      Channels > {{ roomName }}

      <pre>{{ users }}</pre>
    </div>

    <div class="RoomDetail-main">
      <ChatMessagesList
        class="RoomDetail-messagesList"
        :messages="messages"
      />

      <ChatForm
        ref="chatForm"
        class="RoomDetail-form"
        @submit="submit"
      />
    </div>
  </div>
</template>

<style lang="scss" scoped>
.RoomDetail {
  padding: toRem(15);
  display: flex;
  flex-direction: column;
  gap: toRem(20);
  height: 100vh;
  min-height: 0px;
}

.RoomDetail-main {
  display: flex;
  flex-direction: column;
  gap: toRem(30);
  border: 1px solid rgba($app-brown, 0.1);
  padding: toRem(15);
  border-radius: 15px;
  min-height: 0px;
  flex-grow: 1;
}

.RoomDetail-messagesList {
  flex-grow: 1;
}

.RoomDetail-form {
  flex-shrink: 0;
}
</style>
