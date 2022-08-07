<template>
    <div>
        <h1>Hello World
            <v-chip>NEW</v-chip>
        </h1>
        <v-icon>alarm-plus</v-icon>
        <p>{{ message }}</p>
        <p>FOO</p>
    </div>
</template>

<script>
import axios from 'axios'

export default {
    name: "App",
    data: function () {
        return {
            message: "loading"
        }
    },
    mounted() {
        console.log("loading")
        axios.get("/api").then(response => this.message = response.data.hello)
    }
}
</script>
