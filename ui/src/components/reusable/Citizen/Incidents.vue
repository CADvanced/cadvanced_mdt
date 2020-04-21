<template>
    <div>
        <Incident
            v-for="incident in offences"
            :key="incident.id"
            :incident="incident"
        />
    </div>
</template>

<script>
import Incident from './Incident.vue';
import clientSender from '../../../mixins/clientSender';
export default {
    props: {
        citizen: {
            type: Object,
            required: true
        }
    },
    computed: {
        offences() {
            return this.citizen.offences;
        }
    },
    components: {
        Incident
    },
    mixins: [clientSender],
    mounted: function () {
        this.sendClientMessage('getCitizenOffences', { id: this.citizen.id });
    }
};
</script>
