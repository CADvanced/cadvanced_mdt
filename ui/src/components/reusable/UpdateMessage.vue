<template>
    <div class="update-message">{{ message }}</div>
</template>

<script>
    export default {
        props: {
            message: {
                type: String,
                required: true
            }
        }
    };
</script>

<style scoped>
    .update-message {
        color: rgba(255, 255, 255, 0.5);
        margin-top: 100px;
        text-align: center;
        font-size: 40px;
    }
</style>
