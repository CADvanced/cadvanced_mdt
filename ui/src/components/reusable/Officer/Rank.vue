<template>
    <div class="rank-container">
        <MiniButton
            @miniClick="selectRank"
            :fontSize="'17px'"
            :text="rank.name"
            :colour="'rgba(0, 0, 0, 0.2)'"
            :borderColour="'rgba(255,255,255,0.5)'"
        />
    </div>
</template>

<script>
import MiniButton from '../../MiniButton.vue';
export default {
    props: {
        rank: {
            type: Object,
            required: true
        }
    },
    components: {
        MiniButton
    },
    methods: {
        selectRank() {
            this.$emit('selectRank');
        }
    }
};
</script>

<style scoped>
.rank-container {
    margin: 10px;
}
.rank-container:first-child {
    margin-left: 0;
}
.rank-container:last-child {
    margin-right: 0;
}
</style>
