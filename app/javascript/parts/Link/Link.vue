
<template>
    <a v-if="isNotAnAnchor" >{{ text }}</a>
    <a v-else :href="href">{{ text }}</a>
</template>

<script>
export default {
    props: ['isNotAnAnchor', 'href', 'text'],
    data: function() {
        return {};
    },
};
</script>
