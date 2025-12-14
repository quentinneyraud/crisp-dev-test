<script setup lang="ts">
import type { Fn } from '@vueuse/core'

const isOpen = defineModel<boolean>('isOpen', {
  required: true,
})

let stopClickOutsideListener: Fn
let stopKeyStrokeListener: Fn

const mainRef = useTemplateRef('mainRef')

function close() {
  isOpen.value = false
}

watch(isOpen, (isOpen) => {
  stopClickOutsideListener?.()
  stopKeyStrokeListener?.()

  if (isOpen) {
    stopClickOutsideListener = onClickOutside(mainRef, close)
    stopKeyStrokeListener = onKeyStroke('Escape', close)
  }
})
</script>

<template>
  <Teleport
    v-if="isOpen"
    to="body"
  >
    <div class="Modal">
      <div
        ref="mainRef"
        class="Modal-main"
      >
        <slot />
      </div>
    </div>
  </Teleport>
</template>

<style lang="scss" scoped>
.Modal {
  position: fixed;
  inset: 0;
  background-color: rgba($black, 0.5);
  @include flex-parent-center;
}

.Modal-main {
  background-color: $white;
  box-shadow: 3px 3px 5px 0 $app-brown;
  width: max(500px, 50vw);
  padding: toRem(50);
  border-radius: 5px;
}
</style>
