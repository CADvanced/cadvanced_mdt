<template>
    <div>
        <div id="search-results" v-if="results.length > 0">
            <Citizen
                v-for="citizen in results"
                @openCitizenResult="setOpen($event)"
                :key="citizen.id"
                :citizen="citizen"
                :open="open"
                :setOpen="setOpen"
            ></Citizen>
        </div>
        <UpdateMessage
            v-if="searched && results.length === 0"
            message="No results found"
        />
    </div>
</template>

<script>
    import Citizen from '../../../reusable/Citizen/Citizen.vue';
    import UpdateMessage from '../../../reusable/UpdateMessage.vue';
    export default {
        components: {
            Citizen,
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
                return this.$store.getters.getCitizenSearchResults;
            }
        }
    };
</script>

<style scoped>
    #search_results {
        overflow-y: auto;
    }
</style>
