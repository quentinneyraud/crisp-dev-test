<script setup lang="ts">
const { rooms, createRoom } = useRooms()
const name = ref('')
</script>

<template>
  <ul>
    <li
      v-for="room in rooms"
      :key="room.id"
    >
      <NuxtLink
        :to="{
          name: 'room-detail',
          params: {
            roomId: room.id,
          },
        }"
      >
        {{ room.name }}
      </NuxtLink>
    </li>
  </ul>

  <form @submit.prevent="createRoom(name)">
    <input v-model="name">
    <button>Créer</button>
  </form>
</template>
