<script setup lang="ts">
const user = useSupabaseUser()
</script>

<template>
  <div>
    <div>
      client: {{ user?.email }}
    </div>
    <slot />
  </div>
</template>
