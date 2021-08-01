return {
  formatCommand = 'fish_indent "${INPUT}"',
  formatStdin = true,
  lintCommand = 'fish -n "${INPUT}"',
  lintStdin = true,
  lintFormats = { "%f (line %l): %m" },
}
