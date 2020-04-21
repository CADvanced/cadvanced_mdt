<template>
    <div>
        <div v-if="units.length > 0" id="units-filter">
            <span>Only show my units</span>
            <i
                @click="toggleOwnUnits"
                v-if="!ownUnits"
                class="fas fa-toggle-off"
            ></i>
            <i @click="toggleOwnUnits" v-else class="fas fa-toggle-on"></i>
        </div>
        <div v-if="units.length > 0" id="units">
            <Unit
                @leaveUnit="leaveUnit(unit.id)"
                @beingEdited="setEditedUnit(unit.id)"
                @unitToggle="setUnitOpen(unit.id)"
                v-for="unit in units"
                :key="unit.id"
                :unit="unit"
                :ownUnits="ownUnits"
                :isOpen="isUnitOpen(unit.id)"
                :class="{ open: isUnitOpen(unit.id) }"
            ></Unit>
            <RanksModal @selectRank="joinUnit" />
            <StatesModal @selectState="selectState" />
        </div>
        <div v-if="!units || units.length == 0" id="no-units">
            <div id="no-units-text">No units available</div>
        </div>
    </div>
</template>

<script>
import Unit from './unit/Unit.vue';
import clientSender from '../../../../mixins/clientSender';
import RanksModal from '../../../reusable/Officer/RanksModal.vue';
import StatesModal from '../../../reusable/Unit/StatesModal.vue';
export default {
    data: function () {
        return {
            unitBeingEdited: 0,
            unitsOpen: [],
            ownUnits: false
        };
    },
    mixins: [clientSender],
    components: {
        Unit,
        RanksModal,
        StatesModal
    },
    computed: {
        units() {
            return this.$store.getters.getUnits;
        }
    },
    methods: {
        setEditedUnit(unitId) {
            this.unitBeingEdited = unitId;
        },
        leaveUnit(unitId) {
            const user = this.$store.getters.getUser;
            this.sendClientMessage('removeUserFromUnit', {
                userId: user.id,
                unitId: unitId
            });
        },
        joinUnit(rankId) {
            const user = this.$store.getters.getUser;
            this.sendClientMessage('addUserToUnit', {
                userId: user.id,
                unitId: this.unitBeingEdited,
                rankId
            });
            this.unitBeingEdited = 0;
        },
        selectState(stateId) {
            this.sendClientMessage('setUnitState', {
                stateId: stateId,
                unitId: this.unitBeingEdited
            });
            this.unitBeingEdited = 0;
        },
        isUnitOpen(id) {
            return this.unitsOpen.includes(id);
        },
        setUnitOpen(id) {
            if (!this.isUnitOpen(id)) {
                this.unitsOpen.push(id);
            } else {
                this.unitsOpen.splice(
                    this.unitsOpen.findIndex(u => u == id),
                    1
                );
            }
        },
        toggleOwnUnits() {
            this.ownUnits = !this.ownUnits;
        }
    }
};
</script>

<style scoped>
#units-filter {
    display: flex;
    margin-bottom: 20px;
    justify-content: flex-end;
    align-items: center;
    font-size: 20px;
    color: rgba(255, 255, 255, 0.5);
    text-transform: uppercase;
}
#units-filter span {
    display: block;
}
#units-filter i {
    display: block;
    margin-left: 20px;
}
#units {
    display: grid;
    grid-gap: 10px;
    grid-template-columns: repeat(auto-fit, minmax(300px, auto));
    grid-auto-rows: 145px;
    grid-auto-flow: dense;
}
.open {
    grid-row: span 4;
}
i.fas {
    cursor: pointer;
}
#no-units {
    display: flex;
    width: 100%;
    justify-content: center;
    padding-top: 380px;
    font-size: 30px;
    color: rgba(255, 255, 255, 0.5);
}
</style>
