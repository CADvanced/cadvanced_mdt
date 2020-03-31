<template>
    <div>
        {{ counter }}
        08:35&nbsp;&nbsp;&nbsp;2019-12-09
    </div>
</template>

<script>
export default {
    computed: {
        counter() {
            return this.$store.getters.getCounter;
        }
    }
};
</script>

<style scoped>
div {
    flex: 1 1 0;
    text-align: right;
}
</style>
