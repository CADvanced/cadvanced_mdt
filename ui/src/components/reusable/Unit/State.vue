<template>
    <div class="state-container">
        <div
            :style="{ background: '#' + stateColour }"
            class="state-indicator"
        ></div>
        <MiniButton
            @miniClick="selectState"
            :fontSize="'17px'"
            :text="state.name"
            :colour="'rgba(0, 0, 0, 0.2)'"
            :borderColour="'rgba(255,255,255,0.5)'"
            :borderRadius="'0 4px 4px 0'"
        />
    </div>
</template>

<script>
import MiniButton from '../../MiniButton.vue';
export default {
    props: {
        state: {
            type: Object,
            required: true
        }
    },
    components: {
        MiniButton
    },
    methods: {
        selectState() {
            this.$emit('selectState');
        }
    },
    computed: {
        stateColour() {
            return this.state.colour;
        }
    }
};
</script>

<style scoped>
.state-container {
    display: flex;
    margin: 10px;
}
.state-container:first-child {
    margin-left: 0;
}
.state-container:last-child {
    margin-right: 0;
}
.state-indicator {
    width: 15px;
    border-radius: 4px 0 0 4px;
}
</style>
