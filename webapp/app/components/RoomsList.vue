<script setup lang="ts">
const { userRooms, createRoom } = useRoom()
const name = ref('')
</script>

<template>
  <div class="RoomsList">
    <p class="RoomsList-title AppSubtitle-1">
      My channels
    </p>

    <ul class="RoomsList-list">
      <li
        v-for="room in userRooms"
        :key="room.id"
      >
        <NuxtLink
          class="RoomsList-roomLink AppText-1"
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

    <div class="RoomsList-actions">
      <AppButton
        class="RoomsList-addChannelButton"
        label="Add a new channel"
      />

      <AppButton
        class="RoomsList-addChannelButton"
        label="Join a channel"
      />
    </div>

    <form @submit.prevent="createRoom(name)">
      <input v-model="name">
      <button>Créer</button>
    </form>
  </div>
</template>

<style lang="scss" scoped>
.RoomsList-list {
  margin-top: toRem(10);
  display: flex;
  flex-direction: column;
  gap: toRem(10);
  margin-bottom: toRem(30);
}

.RoomsList-roomLink {
  padding-block: toRem(10);
}

.RoomsList-actions {
  margin-top: auto;
}

.RoomsList-addChannelButton {
  width: 100%;
}
</style>
