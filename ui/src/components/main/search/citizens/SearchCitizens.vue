<template>
    <div>
        <MarkersModal />
        <SearchBar v-on:searchChanged="sendSearch($event)" />
        <UpdateMessage v-if="isLoading" message="Contacting control..." />
        <SearchResults v-else :searched="searched" />
    </div>
</template>

<script>
import UpdateMessage from '../../../reusable/UpdateMessage.vue';
import SearchBar from './SearchBar.vue';
import SearchResults from './SearchResults.vue';
import MarkersModal from '../../../reusable/Citizen/MarkersModal/MarkersModal.vue';
import clientSender from '../../../../mixins/clientSender';
export default {
    components: {
        SearchBar,
        SearchResults,
        UpdateMessage,
        MarkersModal
    },
    data: function () {
        return {
            searched: false,
            isLoading: false
        };
    },
    mixins: [clientSender],
    methods: {
        sendSearch(sendObject) {
            this.isLoading = true;
            this.searched = true;
            this.sendClientMessage('searchCitizen', sendObject);
        }
    },
    watch: {
        results: function () {
            this.isLoading = false;
        }
    },
    computed: {
        results() {
            return this.$store.getters.getCitizenSearchResults;
        }
    },
    destroyed: function () {
        this.$store.commit('setCitizenSearchResults', []);
    }
};
</script>
