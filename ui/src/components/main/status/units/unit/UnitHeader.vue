<template>
    <div class="unit-header">
        <div class="top-row">
            <div class="key-info">
                <div
                    class="callsign"
                    :style="{ color: '#' + unit.unitState.colour }"
                >
                    {{ unit.callSign }}
                </div>
                <div @click="toggled" class="expand-button">
                    <i v-if="!isOpen" class="fas fa-toggle-off"></i>
                    <i v-else class="fas fa-toggle-on"></i>
                </div>
            </div>
            <div class="unit-state-name">
                {{ unit.unitState.name }}
            </div>
            <div class="unit-rank-name">{{ rankOnUnit }}</div>
        </div>
        <div class="bottom-row">
            <div class="unit-actions">
                <MiniButton
                    class="unit-state-button"
                    @miniClick="openStatusModal"
                    text="Unit state"
                    colour="rgba(0,0,0,0.2)"
                />
                <MiniButton
                    v-if="isAssignedToUnit"
                    @miniClick="leaveUnit"
                    text="Leave"
                    colour="rgba(255, 0, 0, 0.5)"
                />
                <MiniButton
                    v-else
                    @miniClick="openRanksModal"
                    text="Join"
                    colour="rgba(0, 255, 0, 0.5)"
                />
            </div>
        </div>
    </div>
</template>

<script>
    import MiniButton from '../../../../MiniButton.vue';
    export default {
        components: {
            MiniButton
        },
        props: {
            unit: {
                type: Object,
                required: true
            },
            isOpen: {
                type: Boolean,
                required: true
            }
        },
        computed: {
            rankOnUnit() {
                const unitStatus = this.userUnitStatus;
                return unitStatus
                    ? this.$store.getters.getRank(unitStatus.UserRankId)
                    : null;
            },
            isAssignedToUnit() {
                return this.userUnitStatus ? true : false;
            },
            userUnitStatus() {
                const user = this.$store.getters.getUser;
                const userUnits = this.$store.getters.getUserUnits;
                return userUnits.find(
                    uu => uu.UserId === user.id && uu.UnitId === this.unit.id
                );
            }
        },
        methods: {
            leaveUnit() {
                this.$emit('leaveUnit');
            },
            openRanksModal() {
                this.$emit('beingEdited');
                this.$store.commit('setModal', {
                    type: 'ranks',
                    data: { open: true }
                });
            },
            openStatusModal() {
                this.$emit('beingEdited');
                this.$store.commit('setModal', {
                    type: 'unitStates',
                    data: { open: true }
                });
            },
            toggled() {
                this.$emit('toggled');
            }
        }
    };
</script>

<style scoped>
    .unit-header {
        background: rgba(0, 0, 0, 0.1);
        padding: 20px;
        margin-bottom: 14px;
        min-height: 98px;
    }
    .top-row {
        margin-bottom: 20px;
    }
    .key-info {
        display: flex;
    }
    .expand-button {
        flex-grow: 1;
        font-size: 25px;
        color: rgba(255, 255, 255, 0.5);
        text-align: right;
        color: rgba(0, 0, 0, 0.3);
    }
    .expand-button i {
        display: block;
    }
    .callsign {
        font-size: 20px;
        letter-spacing: 0.1em;
    }
    .bottom-row {
        display: flex;
        justify-content: space-between;
        align-items: top;
        font-size: 14px;
        color: rgba(255, 255, 255, 0.5);
    }
    .unit-state-name,
    .unit-rank-name {
        font-size: 14px;
        color: rgba(255, 255, 255, 0.5);
        text-transform: uppercase;
        letter-spacing: 0.1em;
    }
    .unit-actions {
        display: flex;
        flex-grow: 1;
        justify-content: flex-end;
    }
    .unit-state-button {
        margin-right: 10px;
    }
</style>
