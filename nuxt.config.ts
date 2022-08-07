import {defineNuxtConfig} from 'nuxt'

// https://v3.nuxtjs.org/api/configuration/nuxt.config
export default defineNuxtConfig({
    ssr: false, // Disable Server Side rendering
    css: [
        'vuetify/lib/styles/main.sass',
        'mdi/css/materialdesignicons.min.css'
    ],
    build: {
        transpile: ['vuetify'],
    },
    vite: {
        define: {
            'process.env.DEBUG': false,
        },
        server: {
            proxy: {
                '/api': {
                    target: 'http://localhost:8000',
                    ws: true,
                },
            },
        },
    },
})
