/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*',
  ],
  theme: {
    extend: {},
    screens: {
      'sm': { 'max': '767px'},
      // => @media (min-width: 640px) { ... }
    }
  },
  plugins: [],
}