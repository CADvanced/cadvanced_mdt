<template>
    <div class="section">
        <div class="label">{{ label }}</div>
    </div>
</template>

<script>
export default {
    props: {
        label: {
            type: String,
            required: true
        }
    }
};
</script>

<style scoped>
.section {
    background: rgba(0, 0, 0, 0.1);
    color: rgba(255, 255, 255, 0.7);
    text-transform: uppercase;
    min-width: 100px;
    display: flex;
    align-items: center;
    justify-content: center;
}
</style>
