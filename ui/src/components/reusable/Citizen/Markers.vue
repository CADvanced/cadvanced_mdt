<template>
    <div class="markers-container">
        <Alert
            class="marker"
            v-for="marker in markers"
            :key="marker.id"
            :text="marker.name"
            icon="fa-exclamation-circle"
        />
    </div>
</template>

<script>
    import Alert from '../widgets/Alert.vue';
    export default {
        props: {
            markers: {
                type: Array,
                required: true
            }
        },
        components: {
            Alert
        }
    };
</script>

<style scoped>
    .markers-container {
        display: flex;
        margin-right: 10px;
    }

    .marker {
        margin-left: 10px;
    }

    .marker:first-child {
        margin-left: 0;
    }
</style>
