<script setup lang="ts">
const props = defineProps<{
  roomId: string
}>()

const roomId = ref(props.roomId)
const { messages, sendMessage } = useMessages(roomId)

const content = ref('')

async function submit() {
  await sendMessage(content.value)
  content.value = ''
}
</script>

<template>
  <div class="Chat">
    <ul>
      <li
        v-for="m in messages"
        :key="m.id"
      >
        {{ m.content }}
      </li>
    </ul>

    <form @submit.prevent="submit">
      <input v-model="content">
      <button>Envoyer un message</button>
    </form>
  </div>
</template>
