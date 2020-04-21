<template>
    <Modal :open="isOpen" @close="close">
        <template v-slot:header>
            Choose a state
        </template>
        <template v-slot:body>
            <div class="states">
                <State
                    @selectState="selectState(state.id)"
                    v-for="state in states"
                    :key="state.id"
                    :state="state"
                >
                </State>
            </div>
        </template>
    </Modal>
</template>

<script>
import Modal from '../Modal.vue';
import MiniButton from '../../MiniButton.vue';
import State from './State.vue';
export default {
    components: {
        Modal,
        MiniButton,
        State
    },
    computed: {
        states() {
            return this.$store.getters.getUnitStates;
        },
        isOpen() {
            return this.$store.getters.getIsModalOpen('unitStates');
        }
    },
    methods: {
        selectState(id) {
            this.$emit('selectState', id);
            this.$store.commit('resetModal', {
                type: 'unitStates'
            });
        },
        close() {
            this.$store.commit('resetModal', {
                type: 'unitStates'
            });
        }
    }
};
</script>

<style scoped>
.states {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
}
</style>
