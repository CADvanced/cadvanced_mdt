<template>
    <div @click="hideMdt">Exit</div>
</template>

<script>
import clientSender from '../../mixins/clientSender';
export default {
    methods: {
        hideMdt() {
            this.sendClientMessage('hideMdt');
            this.$store.commit('setHide');
        }
    },
    mixins: [clientSender]
};
</script>

<style scoped>
div {
    flex: 2 2 0;
    text-align: right;
    color: rgba(255, 255, 255, 0.8);
    cursor: pointer;
}
</style>
