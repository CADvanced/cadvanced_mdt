<template>
    <div id="container">
        <div id="home-text">{{ getText || 'WELCOME TO THE MDT' }}</div>
    </div>
</template>

<script>
export default {
    computed: {
        getText() {
            const conf = this.$store.getters.getResourceConfig;
            return conf.homepage;
        }
    }
};
</script>

<style scoped>
#container {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100%;
    font-size: 40px;
    color: rgba(255, 255, 255, 0.5);
}
</style>
