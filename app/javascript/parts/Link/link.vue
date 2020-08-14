
<template>
    <a v-if="isDelete" :class="className" v-on:click="deleteMethod">{{ text }}</a>
    <a v-else :class="className" :href="href">{{ text }}</a>
</template>

<script>
    import axios from 'axios'
    export default {
        props: ['isDelete', 'className', 'href', 'text'],
        data: function() {
            return {};
        },
        methods: {
            deleteMethod: function () {
                axios.delete(href)
            }
        }
    };
</script>
