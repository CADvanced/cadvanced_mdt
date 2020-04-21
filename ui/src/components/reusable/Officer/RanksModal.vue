<template>
    <Modal :open="isOpen" @close="close">
        <template v-slot:header>
            Choose a rank
        </template>
        <template v-slot:body>
            <div class="ranks">
                <Rank
                    @selectRank="selectRank(rank.id)"
                    v-for="rank in ranks"
                    :key="rank.id"
                    :rank="rank"
                />
            </div>
        </template>
    </Modal>
</template>

<script>
import Modal from '../Modal.vue';
import MiniButton from '../../MiniButton.vue';
import Rank from './Rank.vue';
export default {
    components: {
        Modal,
        MiniButton,
        Rank
    },
    computed: {
        ranks() {
            return this.$store.getters.getUserRanks;
        },
        isOpen() {
            return this.$store.getters.getIsModalOpen('ranks');
        }
    },
    methods: {
        selectRank(id) {
            this.$emit('selectRank', id);
            this.$store.commit('resetModal', {
                type: 'ranks'
            });
        },
        close() {
            this.$store.commit('resetModal', {
                type: 'ranks'
            });
        }
    }
};
</script>

<style scoped>
.ranks {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
}
</style>
