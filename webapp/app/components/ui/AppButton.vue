<script setup lang="ts">
import type { NuxtLinkProps } from '#app'
import { NuxtLink } from '#components'

export type AppButtonProps = NuxtLinkProps & {
  icon?: string
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
    <Icon
      v-if="props.icon"
      :name="props.icon"
      style="color: currentColor; font-size: 1.5em"
    />

    <span
      v-if="props.label"
      class="AppText-3"
    >{{ label }}</span>
  </Component>
</template>

<style lang="scss" scoped>
.AppButton {
  position: relative;
  min-height: toRem(45);
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: toRem(10);
  background-color: $white;
  border-radius: 10px;
  padding: toRem(7) toRem(22);
  color: $black;
  text-align: center;
  background-color: $white;
  overflow: hidden;
  border: 1px solid $white;

  transition: background-color 0.15s $ease-power2-in, color 0.15s $ease-power2-in, transform 0.3s $ease-power2-in;

  & > * {
    z-index: 1;
  }

  @include after {
    @include full-parent;
    background-color: $app-dark-grey;
    transform: tY(100%);
    opacity: 0;
    transition: transform 0.3s $ease-power2-in, opacity 0.15s linear;
  }

  @include hover-focus {
    transform: scale(0.98);
    background-color: $app-light-grey;
    color: $white;
    transition: background-color 0.15s  $ease-power2-out, color 0.15s  $ease-power2-out, transform 0.3s $ease-power2-out;

    &:after {
      transform: tY(0%) scaleX(1);
      opacity: 1;
      transition: transform 0.3s $ease-power2-out, opacity 0.15s linear;
    }

  }
}
</style>
