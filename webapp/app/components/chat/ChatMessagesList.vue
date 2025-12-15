<script setup lang="ts">
import type { Tables } from '../../types/database.types'
import Lenis from 'lenis'

const props = defineProps<ChatMessagesListProps>()

const user = useSupabaseUser()

export interface ChatMessagesListProps {
  messages: Tables<'message'>[]
}

function isOwnMessage(message: Tables<'message'>) {
  return message.created_by === user.value?.sub
}

const scrollableContentRef = useTemplateRef('scrollable-content')
const lenisInstance = ref<Lenis>()

function scrollToBottom(immediate?: boolean) {
  lenisInstance.value?.scrollTo(lenisInstance.value.limit, {
    immediate,
  })
}

onMounted(() => {
  lenisInstance.value = new Lenis({
    wrapper: scrollableContentRef.value!,
    __experimental__naiveDimensions: true,
  })

  gsap.ticker.add((time) => {
    lenisInstance.value!.raf(time * 1000)
  })

  window.setTimeout(() => {
    scrollToBottom(true)
  }, 100)
})

watch(() => props.messages, () => {
  scrollToBottom(false)
}, {
  deep: true,
  flush: 'post',
})
</script>

<template>
  <div
    ref="scrollable-content"
    class="ChatMessagesList"
  >
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
  position: relative;
  overflow-y: auto;

  &::-webkit-scrollbar {
    display: none;
  }
}

.ChatMessagesList-messages {
  display: flex;
  flex-direction: column;
  justify-content: flex-end;
  gap: toRem(15);
}
</style>
