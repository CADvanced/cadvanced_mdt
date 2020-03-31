<template>
    <div class="property-container">
        <span class="label" v-if="label && label.length > 0">
            {{ label }}:
        </span>
        {{ value }}
    </div>
</template>

<script>
export default {
    props: {
        label: {
            type: String,
            required: false
        },
        value: {
            type: String,
            required: false,
            default: 'Unknown'
        }
    }
};
</script>

<style scoped>
.label {
    font-weight: bold;
}
</style>
