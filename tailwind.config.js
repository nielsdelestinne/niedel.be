/** @type {import('tailwindcss').Config} */
module.exports = {
    content: ["./_layouts/*.{html,js}", "./_includes/*.{html,js}"],
    theme: {
        extend: {
            colors: {
                'gray': {
                    100: '#f1f1f1',
                    200: '#dfdfdf',
                    300: '#d6d6d6',
                    400: '#838383',
                    500: '#505050',
                    600: '#5e5e5e',
                    700: '#3c3c3c',
                    800: '#263238',
                    900: '#212121',
                    950: '#0b0b0b'
                }
            }
        }
    },
    plugins: [],
}

