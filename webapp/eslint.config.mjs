// @ts-check
import antfu from '@antfu/eslint-config'
import withNuxt from './.nuxt/eslint.config.mjs'

export default withNuxt(
  antfu({
    rules: {
      'antfu/if-newline': 'off',
      'import/order': 'off',
      'ts/no-use-before-define': 'off',
      'vue/max-attributes-per-line': ['error', {
        singleline: 1,
      }],
      'pnpm/json-enforce-catalog': 'off',
    },
  }),
  {
    ignores: [
      './app/types/database.types.ts',
    ],
  },
)
