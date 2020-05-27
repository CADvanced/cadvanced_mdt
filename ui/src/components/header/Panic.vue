<template>
    <div @click="startPanic">&gt; Panic &lt;</div>
</template>

<script>
import clientSender from '../../mixins/clientSender';
export default {
    methods: {
        startPanic() {
            this.sendClientMessage('startPanic');
        }
    },
    mixins: [clientSender]
};
</script>

<style scoped>
div {
    flex: 2 2 0;
    text-align: right;
    color: rgba(255, 0, 0, 0.9);
}
</style>
