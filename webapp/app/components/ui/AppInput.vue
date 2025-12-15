<script setup lang="ts">
export interface AppInputProps {
  label: string
  id?: string
  name: string
  required?: boolean
  placeholder?: string
  type: 'text' | 'email'
}

export interface AppInputModel {
  value: string
  error?: string
}

const props = defineProps<AppInputProps>()

const model = defineModel<AppInputModel>({
  required: true,
})

const inputId = computed(() => {
  return props.id ?? props.name
})
</script>

<template>
  <div class="AppInput">
    <label
      class="AppText-1"
      :for="inputId"
    >{{ props.label }}</label>

    <input
      :id="inputId"
      v-model="model.value"
      class="AppInput-input"
      :name="props.name"
      :type="props.type"
      :placeholder="props.placeholder"
      :required="props.required"
    >

    <span
      v-if="model.error"
      class="AppInput-error"
    >{{ model.error }}</span>
  </div>
</template>

<style lang="scss" scoped>
.AppInput {
  display: flex;
  gap: toRem(10);
  flex-direction: column;
}

.AppInput-input {
  border-radius: 5px;
  height: toRem(50);
  padding: toRem(10);
  border: 1px solid $app-medium-grey;
}

.AppInput-error {
  color: red;
}
</style>
