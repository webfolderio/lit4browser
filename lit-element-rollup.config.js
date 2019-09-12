export default {
  input: 'lit-element.js',
  output: [{
    file: '../dist/lit-element.js',
    format: 'esm'
  },
  {
    file: '../dist/lit-element.iife.js',
    format: 'iife',
    name: 'lit'
  }],
  plugins: []
}