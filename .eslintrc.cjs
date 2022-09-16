module.exports = {
  'env': {
    'browser': true,
    'commonjs': true,
    node: true
  },
  'extends': [
    'eslint:recommended',
    'plugin:vue/essential'
    // "plugin:prettier/recommended"
  ],
  'parserOptions': {
    'ecmaVersion': 2020
  },
  'plugins': [
    'vue'
  ],
  'rules': {
    'no-console': process.env.NODE_ENV === 'production' ? 'warn' : 'off',
    'no-debugger': process.env.NODE_ENV === 'production' ? 'warn' : 'off',
    'no-unused-vars': 'off',
    'no-undef': 'error',
    'indent': ["error", 2, { "SwitchCase": 1 }],
    'quotes': ['error', 'single'],
    'keyword-spacing': ['error', {'before': true, 'after': true}],
    'comma-spacing': ['error', {'before': false, 'after': true}],
    'vue/multi-word-component-names': 'off',
    "vue/no-v-model-argument": "off",
    // 'prettier/prettier': [
    //   'error',
    //   {
    //     'singleQuote': true,
    //     'semi': false,
    //     'useTabs': false,
    //     'trailingComma': 'none'
    //   }
    // ]
  }
}
