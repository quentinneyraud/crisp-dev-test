<script setup lang="ts">
import type { NuxtLinkProps } from '#app'
import { NuxtLink } from '#components'

export type AppButtonProps = NuxtLinkProps & {
  as?: keyof HTMLElementTagNameMap
  label?: string
}

const props = withDefaults(defineProps<AppButtonProps>(), {
  prefetch: undefined,
  noPrefetch: undefined,
  viewTransition: undefined,
})

const nuxtLinkProps = computed(() => {
  const { label, ...rest } = props

  return rest
})
</script>

<template>
  <Component
    :is="props.as ? props.as : NuxtLink"
    class="AppButton"
    v-bind="!props.as && nuxtLinkProps"
  >
    <span
      v-if="props.label"
      class="AppText-3"
    >{{ label }}</span>
  </Component>
</template>

<style lang="scss" scoped>
.AppButton {
  display: inline-block;
  background-color: $app-brown;
  border-radius: 5px;
  padding: toRem(12) toRem(22);
  color: $white;
  box-shadow: 0 0 3px 0 $app-brown;
  text-align: center;
}
</style>
