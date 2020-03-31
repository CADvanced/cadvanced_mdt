<template>
    <div id="connection_stat">
        <div :class="{ receiving: isReceiving }" id="connection_indicator" />
        <p>Connected to control</p>
    </div>
</template>

<script>
export default {
    computed: {
        isReceiving() {
            return this.$store.getters.getConnectionActive;
        }
    }
};
</script>

<style scoped>
div#connection_stat {
    flex: 1 1 0;
    display: flex;
    align-items: center;
}
div#connection_indicator {
    width: 24px;
    height: 24px;
    border-radius: 12px;
    background: rgba(82, 255, 0, 0.5);
    margin-right: 20px;
}
div#connection_indicator.receiving {
    animation: blink 0.2s infinite alternate;
}
@keyframes blink {
    50% {
        opacity: 0.5;
    }
}
</style>
