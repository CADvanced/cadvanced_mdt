<template>
    <div
        v-if="!ownUnits || (ownUnits && isAssignedToUnit)"
        id="unit"
        :class="{ inPanic: isInPanic }"
    >
        <UnitHeader
            @beingEdited="beingEdited"
            @leaveUnit="leaveUnit"
            @toggled="toggle"
            :unit="unit"
            :isOpen="isOpen"
        />
        <div
            v-show="isOpen"
            :class="{ maskedcalls: !isAssignedToUnit }"
            class="calls-container"
        >
            <Call
                v-for="(call, index) in assignedCalls"
                @changed="callChanged"
                :key="index"
                :call="call"
            />
            <div class="no-calls-container">
                <div v-if="!hasCalls" class="no-calls">
                    No assigned calls
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import soundPlayer from '../../../../../mixins/soundPlayer';
import UnitHeader from './UnitHeader.vue';
import Call from './Call.vue';
export default {
    props: {
        unit: {
            type: Object,
            required: true
        },
        isOpen: {
            type: Boolean,
            required: true
        },
        ownUnits: {
            type: Boolean,
            required: true
        }
    },
    components: {
        UnitHeader,
        Call
    },
    mixins: [soundPlayer],
    computed: {
        assignedCalls() {
            return this.$store.getters.getCalls.filter(call =>
                call.assignedUnits.some(unit => unit.id == this.unit.id)
            );
        },
        hasCalls() {
            return this.assignedCalls.length > 0;
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
        },
        isInPanic() {
            return this.unit.unitState.code === 'PANIC';
        }
    },
    methods: {
        leaveUnit() {
            this.$emit('leaveUnit');
        },
        beingEdited() {
            this.$emit('beingEdited');
        },
        toggle() {
            this.$emit('unitToggle');
        },
        callChanged() {
            if (this.isAssignedToUnit) {
                this.playRoger();
            }
        }
    },
    watch: {
        isAssignedToUnit() {
            this.playRoger();
        },
        assignedCalls(newVal, oldVal) {
            if (this.isAssignedToUnit && newVal.length !== oldVal.length) {
                this.playRoger();
            }
        },
        'unit.unitState.id': function(newV, oldV) {
            if (this.isAssignedToUnit && newV !== oldV) {
                this.playRoger();
            }
        }
    }
};
</script>

<style scoped>
#unit {
    display: flex;
    flex-direction: column;
    border: 3px solid rgba(255, 255, 255, 0.5);
    box-sizing: border-box;
    border-radius: 10px;
}
#unit.inPanic {
    border: 3px solid #e20000;
}
#unit:first-child {
    margin-left: 0;
}
#unit:last-child {
    margin-right: 0;
}
.calls-container {
    display: flex;
    flex-direction: column;
    height: 100%;
    overflow-y: auto;
}
.no-calls-container {
    display: flex;
    flex-direction: column;
    justify-content: center;
    height: 100%;
}
.no-calls {
    font-size: 20px;
    color: rgba(255, 255, 255, 1);
    text-align: center;
}
.maskedcalls {
    opacity: 0.3;
}
</style>
