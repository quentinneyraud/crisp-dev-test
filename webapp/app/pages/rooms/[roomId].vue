<script setup lang="ts">
const route = useRoute()
const roomId = ref(route.params.roomId as string)

definePageMeta({
  name: 'room-detail',
  layout: 'chat',
})
</script>

<template>
  <div>
    <Chat :room-id="roomId" />
  </div>
</template>

<style lang="scss" scoped>
.RoomId {
  position: relative;
}
</style>
