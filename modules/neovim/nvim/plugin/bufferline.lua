local bufferline = require('bufferline')
bufferline.setup({
  options = {
    style_preset = bufferline.style_preset.minimal, -- or bufferline.style_preset.minimal,

    separator_style = 'slant', -- 'slant' | 'slope' | 'thick' | 'thin' | { 'any', 'any' },
  },
})
