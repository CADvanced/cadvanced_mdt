<template>
    <div>
        <div id="search-results" v-if="results.length > 0">
            <Vehicle
                class="result"
                v-for="vehicle in results"
                :key="vehicle.id"
                :vehicle="vehicle"
            ></Vehicle>
        </div>
        <UpdateMessage
            v-if="searched && results.length === 0"
            message="No results found"
        />
    </div>
</template>

<script>
    import Vehicle from '../../../reusable/Vehicle/Vehicle.vue';
    import UpdateMessage from '../../../reusable/UpdateMessage.vue';
    export default {
        components: {
            Vehicle,
            UpdateMessage
        },
        props: {
            searched: {
                type: Boolean,
                required: true
            }
        },
        data: function() {
            return {
                open: '0'
            };
        },
        methods: {
            setOpen(open) {
                this.open = open;
            }
        },
        computed: {
            results() {
                return this.$store.getters.getVehicleSearchResults;
            }
        }
    };
</script>

<style scoped>
    #search-results {
        margin-top: 70px;
        overflow-y: auto;
    }
    .result {
        border-right: 1px solid rgba(255, 255, 255, 0.7);
        border-left: 1px solid rgba(255, 255, 255, 0.7);
    }
    .result:first-child {
        border-top: 1px solid rgba(255, 255, 255, 0.7);
    }
</style>
