import '@mdi/font/css/materialdesignicons.css'

import {createVuetify} from 'vuetify'
import {mdi} from "vuetify/lib/iconsets/mdi"

export default defineNuxtPlugin(nuxtApp => {
    const vuetify = createVuetify({
        icons: {
            defaultSet: 'mdi',
            sets: {
                mdi,
            }
        },
    })

    nuxtApp.vueApp.use(vuetify)
})