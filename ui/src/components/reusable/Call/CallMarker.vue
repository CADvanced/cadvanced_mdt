<template>
    <div v-if="showButtons" class="markers">
        <div
            @click="setActiveMarker"
            class="marker-button"
            :class="{ active: markerButtonActive }"
        >
            <i class="fas fa-map-marker-alt"></i>
        </div>
        <div
            @click="setActiveRoute"
            :class="{
                active: routeButtonActive,
                disabled: !markerButtonActive
            }"
        >
            <i class="fas fa-route"></i>
        </div>
    </div>
</template>

<script>
import clientSender from '../../../mixins/clientSender';
export default {
    props: {
        call: {
            type: Object,
            required: true
        }
    },
    mixins: [clientSender],
    computed: {
        showButtons() {
            return this.call.markerX && this.call.markerY;
        },
        markerButtonActive() {
            return this.$store.getters.getActiveMarker == this.call.id;
        },
        routeButtonActive() {
            return this.$store.getters.getActiveRoute == this.call.id;
        }
    },
    methods: {
        setActiveMarker() {
            if (this.$store.getters.getActiveMarker != this.call.id) {
                this.$store.commit('setActiveMarker', this.call.id);
                this.$store.commit('setActiveRoute', -1);
                this.sendClientMessage('setCallMarker', { call: this.call });
                this.sendClientMessage('clearCallRoute');
            } else {
                this.$store.commit('setActiveMarker', -1);
                this.$store.commit('setActiveRoute', -1);
                this.sendClientMessage('clearCallMarker');
                //                this.sendClientMessage('clearCallRoute');
            }
        },
        setActiveRoute() {
            if (this.markerButtonActive) {
                if (this.$store.getters.getActiveRoute != this.call.id) {
                    this.$store.commit('setActiveRoute', this.call.id);
                    this.sendClientMessage('setCallRoute');
                } else {
                    this.$store.commit('setActiveRoute', -1);
                    this.sendClientMessage('clearCallRoute');
                }
            }
        }
    }
};
</script>

<style scoped>
.markers {
    display: flex;
}
.marker-button {
    margin-right: 5px;
}
.active {
    color: rgba(0, 255, 0, 0.5);
}
.disabled {
    color: rgba(255, 255, 255, 0.2);
}
</style>
