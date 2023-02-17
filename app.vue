<template>
    <div>
        <v-card
            class="mx-auto"
            width="400"
            prepend-icon="mdi-home">
            <template v-slot:title>
                Hello
                <v-icon v-if="pending" icon="mdi-loading mdi-spin" size="small"></v-icon>
                <span v-else>{{ api.hello }}</span>
                from Vuetify!
            </template>
            <v-card-text>
                <v-icon icon="mdi-antenna"></v-icon>
                When you see this inside a card, it worked!
            </v-card-text>
        </v-card>
    </div>
</template>

<script setup>
const {pending, data: api} = await useLazyFetch('/api')
</script>
