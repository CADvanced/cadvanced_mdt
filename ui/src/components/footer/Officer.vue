<template>
    <div>{{ activeOfficer }}</div>
</template>

<script>
export default {
    computed: {
        activeOfficer() {
            const officer = this.$store.getters.getActiveOfficer;
            return officer
                ? 'Officer: ' + officer.firstName + ' ' + officer.lastName
                : 'No active officer';
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
