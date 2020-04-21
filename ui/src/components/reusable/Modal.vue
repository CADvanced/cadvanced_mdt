<template>
    <div v-if="open" class="modal-mask">
        <div class="modal-wrapper">
            <div class="modal-container">
                <div v-if="hasHeader" class="modal-header">
                    <slot name="header"></slot>
                </div>
                <div class="modal-body">
                    <slot name="body"></slot>
                </div>
                <div class="modal-footer">
                    <div class="modal-close" @click="doClose">Close</div>
                    <slot name="footer"></slot>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    props: ['open'],
    computed: {
        hasHeader() {
            return !!this.$slots.header;
        }
    },
    methods: {
        doClose() {
            this.$emit('close');
        }
    }
};
</script>

<style scoped>
.modal-mask {
    position: fixed;
    z-index: 9998;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    display: table;
}
.modal-wrapper {
    display: table-cell;
    vertical-align: middle;
}

.modal-container {
    max-width: 50%;
    margin: 0px auto;
    background-color: #4a4a4a;
    box-shadow: 10px 10px 10px rgba(0, 0, 0, 0.5);
    border: 2px solid rgba(255, 255, 255, 0.7);
}

.modal-header {
    padding: 10px 20px;
    color: rgba(255, 255, 255, 0.5);
    letter-spacing: 0.1em;
    text-transform: uppercase;
    background: #333;
}

.modal-body {
    padding: 20px;
    margin: 20px 0;
}

.modal-footer {
    padding: 20px;
    display: flex;
    justify-content: flex-end;
    align-items: center;
}
.modal-footer > * {
    margin-right: 10px;
}
.modal-footer > *:last-child {
    margin-right: 0;
}
.modal-close {
    color: rgba(255, 255, 255, 0.8);
    letter-spacing: 0.1em;
    text-transform: uppercase;
    font-size: 13px;
    cursor: pointer;
}
</style>
