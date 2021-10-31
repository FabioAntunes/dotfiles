module.exports = {
  bracketSpacing: true,
  semi: false,
  singleQuote: true,
  trailingComma: 'es5',
  overrides: [
    {
      files: ['*.yaml', '*.yml'],
      options: {
        singleQuote: false,
      },
    },
  ],
}
