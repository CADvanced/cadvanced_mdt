<template>
    <div class="alert">
        <i v-if="icon" :class="['fas', icon]"></i>
        <div class="alert-text" v-if="text && text.length > 0">{{ text }}</div>
    </div>
</template>

<script>
export default {
    props: {
        icon: {
            type: String,
            required: false
        },
        text: {
            type: String,
            required: false
        }
    }
};
</script>

<style scoped>
.alert {
    display: flex;
    align-items: baseline;
    background: rgba(255, 0, 0, 0.5);
    border-radius: 4px;
    padding: 6px 8px;
    font-size: 14px;
    font-weight: bold;
    text-transform: uppercase;
    text-align: center;
    letter-spacing: 0.1em;
    color: rgba(255, 255, 255, 0.7);
}
.alert-text {
    margin-left: 10px;
}
</style>
