<template>
    <div class="vehicle">
        <SectionProperty class="section" label="Vehicle" />
        <div class="vehicle-container">
            <div class="details">
                <div class="licence-plate">
                    <Property
                        :label="''"
                        :value="
                            vehicle.licencePlate || '[ Unknown licence plate ]'
                        "
                    />
                </div>
                <div class="colour">
                    <Property
                        :label="''"
                        :value="vehicle.colour || '[ Unknown colour ]'"
                    />
                    &nbsp;
                    <Property
                        :label="''"
                        :value="
                            vehicle.vehicleModel
                                ? vehicle.vehicleModel.name
                                : '[ Unknown model ]'
                        "
                    />
                </div>
                <div class="insurance">
                    <Property
                        :label="'Insurance'"
                        :value="
                            vehicle.insuranceStatus
                                ? vehicle.insuranceStatus.name
                                : '[ Unknown status ]'
                        "
                    />
                </div>
            </div>
            <div class="vehicle-markers">
                <Markers v-if="hasMarkers" :markers="vehicle.markers" />
                <MiniButton
                    @miniClick="openMarkersModal()"
                    text="Edit markers"
                    colour="rgba(0,0,0,0.2)"
                    borderRadius="3px"
                    icon="fa-pen-alt"
                    padding="6px 8px"
                />
            </div>
        </div>
    </div>
</template>

<script>
    import Property from './Property.vue';
    import SectionProperty from './SectionProperty.vue';
    import Markers from './Markers.vue';
    import MiniButton from '../../MiniButton.vue';
    export default {
        props: {
            vehicle: {
                type: Object,
                required: true,
            },
        },
        computed: {
            hasMarkers() {
                return this.vehicle.markers && this.vehicle.markers.length > 0;
            },
        },
        components: {
            Property,
            SectionProperty,
            Markers,
            MiniButton,
        },
        methods: {
            openMarkersModal() {
                this.$store.commit('setModal', {
                    type: 'markers',
                    data: {
                        open: true,
                        type: 'Vehicle',
                        entity: this.vehicle,
                        updateMutation: 'updateVehicleInCitizenSearchResult',
                    },
                });
            },
        },
    };
</script>

<style scoped>
    .vehicle {
        display: flex;
        color: rgba(255, 255, 255, 0.7);
        border-bottom: 1px solid rgba(255, 255, 255, 0.7);
        font-size: 14px;
        min-height: 40px;
    }
    .vehicle:last-child {
        border: 0;
    }
    .vehicle-container {
        display: flex;
        flex-grow: 1;
        flex-direction: column;
        padding: 10px 0;
    }
    .details {
        display: flex;
        align-items: center;
        flex-grow: 1;
        padding: 0 30px;
    }
    .licence-plate {
        margin-right: 30px;
    }
    .colour {
        display: flex;
    }
    .details > div.insurance {
        margin-left: auto;
    }
    .vehicle-markers {
        padding: 10px 0 0 30px;
        display: flex;
    }
</style>
