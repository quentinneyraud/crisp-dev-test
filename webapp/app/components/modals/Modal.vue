<script setup lang="ts">
import type { Fn } from '@vueuse/core'

export interface ModalProps {
  title: string
  icon: string
}

const props = defineProps<ModalProps>()

const isOpen = defineModel<boolean>('isOpen', {
  required: true,
})

let stopClickOutsideListener: Fn
let stopKeyStrokeListener: Fn

const mainRef = useTemplateRef('mainRef')
const rootRef = useTemplateRef('rootRef')

function close() {
  isOpen.value = false
}

// watch(isOpen, (isOpen) => {
//   stopClickOutsideListener?.()
//   stopKeyStrokeListener?.()

//   const tl = gsap.timeline({
//     paused: true,
//   })
//     .fromTo(rootRef.value, {
//       autoAlpha: 0,
//     }, {
//       autoAlpha: 1,
//       duration: 0.5,
//     })
//     .fromTo(mainRef.value, {
//       y: 50,
//       autoAlpha: 0,
//     }, {
//       y: 0,
//       autoAlpha: 1,
//       duration: 0.5,
//     }, '<')

//   if (isOpen) {
//     tl.play()
//     stopClickOutsideListener = onClickOutside(mainRef, close)
//     stopKeyStrokeListener = onKeyStroke('Escape', close)
//   }
//   else {
//     tl.reverse()
//   }
// }, {
//   flush: 'post',
// })

function onModalEnter(el: Element, done: () => void) {
  gsap.timeline({
    onStart: () => {
      stopClickOutsideListener = onClickOutside(mainRef, close)
      stopKeyStrokeListener = onKeyStroke('Escape', close)
    },
    onComplete: done,
  })
    .fromTo(el, {
      autoAlpha: 0,
    }, {
      autoAlpha: 1,
      duration: 0.2,
    })
    .fromTo(el.querySelector('.Modal-main'), {
      y: 30,
      autoAlpha: 0,
    }, {
      y: 0,
      autoAlpha: 1,
      duration: 0.5,
      ease: 'power2.out',
    }, '<')
}

function onModalLeave(el: Element, done: () => void) {
  gsap.timeline({
    onStart: () => {
      stopClickOutsideListener?.()
      stopKeyStrokeListener?.()
    },
    onComplete: done,
  })
    .to(el, {
      autoAlpha: 0,
      duration: 0.2,
    })
}
</script>

<template>
  <Teleport
    to="body"
  >
    <Transition
      @enter="onModalEnter"
      @leave="onModalLeave"
    >
      <div
        v-if="isOpen"
        ref="rootRef"
        class="Modal"
      >
        <div
          ref="mainRef"
          class="Modal-main"
        >
          <div class="Modal-heading AppTitle-2">
            <Icon
              class="Modal-icon"
              :name="props.icon"
            />

            <p class="Modal-title">
              {{ props.title }}
            </p>
          </div>

          <div class="Modal-content">
            <slot />
          </div>
        </div>
      </div>
    </Transition>
  </Teleport>
</template>

<style lang="scss" scoped>
.Modal {
  position: fixed;
  z-index: $z-index-popup;
  inset: 0;
  background-color: rgba($black, 0.5);
  @include flex-parent-center;
}

.Modal-main {
  background-color: $app-dark-grey;
  width: max(500px, 50vw);
  padding: toRem(50);
  border-radius: 15px;
}

.Modal-heading {
  display: flex;
  align-items: center;
  gap: toRem(20);
}

.Modal-content {
  margin-top: toRem(30);
}
</style>
