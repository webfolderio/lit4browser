export default {
  input: 'lit-html.js',
  output: [{
    file: '../dist/lit-html.js',
    format: 'esm'
  },
  {
    file: '../dist/lit-html.iife.js',
    format: 'iife',
    name: 'lit'
  }],
  plugins: []
}
