<script setup lang="ts">
const { userRooms, loadRooms, subscribe } = useRoom()
const { user } = useUser()

loadRooms()

watch(user, (u) => {
  if (u) {
    subscribe()
  }
})
</script>

<template>
  <ul class="RoomsList">
    <li
      v-for="room in userRooms"
      :key="room.id"
    >
      <NuxtLink
        class="RoomsList-link AppText-1"
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
</template>

<style lang="scss" scoped>
.RoomsList {
  margin-top: toRem(10);
  display: flex;
  flex-direction: column;
  gap: toRem(10);
  margin-bottom: toRem(30);
}

.RoomsList-link {
  position: relative;
  display: inline-block;
  width: 100%;
  padding-block: toRem(10);
  color: $white;
  border-radius: 5px;

  @include before {
    position: absolute;
    top: 50%;
    left: -5px - 10px;
    width: 5px;
    height: 5px;
    background-color: $white;
    border-radius: 50%;
    opacity: 0;
    transform: tXY(-100%, -50%);
    transition: transform 0.3s $ease-power2-in;
  }

  @include hover-focus {
    &:before {
      transform: tXY(0px, -50%);
      opacity: 1;
      transition: transform 0.3s $ease-power2-out, opacity 0.3s linear;
    }
  }

  &.router-link-active {
    pointer-events: none;
    color: $white;
    font-weight: bold;

    &:before {
      transform: tXY(0px, -50%);
      opacity: 1;
      transition: transform 0.3s $ease-power2-out;
    }
  }
}
</style>
