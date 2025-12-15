<script setup lang="ts">
const { userRooms } = useRoom()
</script>

<template>
  <div class="RoomsList">
    <p class="RoomsList-title AppSubtitle-1">
      <Icon name="fa7-regular:comments" />

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

    <RoomsActions class="RoomsList-actions" />
  </div>
</template>

<style lang="scss" scoped>
.RoomsList {
  display: flex;
  flex-direction: column;
}

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
