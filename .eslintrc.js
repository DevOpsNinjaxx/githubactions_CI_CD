module.exports = {
  extends: 'airbnb-base',
  plugins: ['node'],
  rules: {
    'indent': ['error', 2],
    'semi': ['error', 'always'],
    'quotes': ['error', 'single'],
    'no-var': 'error',
    'prefer-arrow-callback': 'error',
    'no-unused-vars': 'error',
    'arrow-parens': ['error', 'always'],
    'func-style': ['error', 'expression'],
    'object-curly-spacing': ['error', 'always'],
    'max-params': ['error', 3],
    // Other rules or overrides can be added here
  },
};
