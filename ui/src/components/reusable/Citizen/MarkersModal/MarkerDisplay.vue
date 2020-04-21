<template>
    <div class="marker-container">
        <MiniButton
            @miniClick="toggleMarker"
            :text="marker.name"
            :icon="icon"
            fontSize="17px"
            colour="rgba(0, 0, 0, 0.2)"
            borderColour="rgba(255,255,255,0.5)"
            padding="7px"
        />
    </div>
</template>

<script>
import MiniButton from '../../../MiniButton.vue';
export default {
    props: {
        marker: {
            type: Object,
            required: true
        },
        isSelected: {
            type: Boolean,
            required: false
        }
    },
    components: {
        MiniButton
    },
    computed: {
        icon() {
            return this.isSelected ? 'fa-minus-circle' : 'fa-plus-circle';
        }
    },
    methods: {
        toggleMarker() {
            if (this.isSelected) {
                this.$emit('removeMarker', { id: this.marker.id });
            } else {
                this.$emit('addMarker', { id: this.marker.id });
            }
        }
    }
};
</script>

<style scoped>
.marker-container {
    margin: 10px;
}
.marker-container:first-child {
    margin-left: 0;
}
.marker-container:last-child {
    margin-right: 0;
}
</style>
