<template>
    <div class="vehicle">
        <div class="header">
            <div class="summary">
                {{ vehicle.licencePlate || '[ Unknown licence plate ]' }}
                {{ vehicle.colour || '[ Unknown colour ]' }}
                {{
                    vehicle.vehicleModel
                        ? vehicle.vehicleModel.name
                        : '[ Unknown model ]'
                }}
            </div>
            <div class="markers">
                <Markers :markers="vehicle.markers" />
                <MiniButton
                    @miniClick="openVehicleMarkersModal(vehicle)"
                    text="Edit markers"
                    colour="rgba(0,0,0,0.2)"
                    borderRadius="3px"
                    icon="fa-pen-alt"
                    padding="6px 8px"
                />
            </div>
        </div>
        <div class="details">
            <div class="detail-section">
                <SectionProperty label="Owner" />
                <div class="owner-details">
                    <div>
                        <div class="name-alerts">
                            <Property
                                class="name property"
                                :value="getCitizenName"
                            />
                            <div
                                v-if="citizenHasWarrants"
                                class="alerts-container"
                            >
                                <Alert :icon="'fa-exclamation-triangle'" />
                            </div>
                        </div>
                        <Property
                            class="address property"
                            :value="getCitizenAddress"
                        />
                        <div class="vehicle-markers">
                            <Markers
                                v-if="citizenHasMarkers"
                                :markers="vehicle.citizen.markers"
                            />
                            <MiniButton
                                @miniClick="
                                    openCitizenMarkersModal(vehicle.citizen)
                                "
                                text="Edit markers"
                                colour="rgba(0,0,0,0.2)"
                                borderRadius="3px"
                                icon="fa-pen-alt"
                                padding="6px 8px"
                            />
                        </div>
                    </div>
                </div>
            </div>
            <div class="detail-section">
                <SectionProperty label="Licences" />
                <div class="licences-details">
                    <div>
                        <div
                            v-for="licence in vehicle.citizen.licences"
                            :key="licence.id"
                        >
                            <Property
                                class="licence property"
                                :label="
                                    licence.licenceType
                                        ? licence.licenceType.name
                                        : '[ Unknown licence type ]'
                                "
                                :value="
                                    licence.licenceStatus
                                        ? licence.licenceStatus.name
                                        : '[ Unknown status ]'
                                "
                            />
                        </div>
                    </div>
                </div>
            </div>
            <div class="detail-section">
                <SectionProperty label="Insurance" />
                <div class="insurance-details">
                    <Property
                        class="name property"
                        :value="
                            vehicle.insuranceStatus
                                ? vehicle.insuranceStatus.name
                                : '[ Unknown insurance status ]'
                        "
                    />
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import logger from '../../../mixins/logger';
    import SectionProperty from '../Citizen/SectionProperty.vue';
    import Property from '../Citizen/Property.vue';
    import Licence from '../Citizen/Licence.vue';
    import Markers from '../Citizen/Markers.vue';
    import Warrant from '../Citizen/Warrant.vue';
    import Alert from '../widgets/Alert.vue';
    import MiniButton from '../../MiniButton.vue';
    export default {
        components: {
            Property,
            Licence,
            Warrant,
            Alert,
            Markers,
            MiniButton,
            SectionProperty,
        },
        props: {
            vehicle: {
                type: Object,
                required: true,
            },
        },
        mixins: [logger],
        methods: {
            openVehicleMarkersModal(entity) {
                this.doLog(JSON.parse(JSON.stringify(entity)));
                this.$store.commit('setModal', {
                    type: 'markers',
                    data: {
                        open: true,
                        type: 'Vehicle',
                        entity,
                        updateMutation: 'updateVehicleSearchResult',
                    },
                });
            },
            openCitizenMarkersModal(entity) {
                this.doLog(JSON.parse(JSON.stringify(entity)));
                this.$store.commit('setModal', {
                    type: 'markers',
                    data: {
                        open: true,
                        type: 'Citizen',
                        entity,
                        updateMutation: 'updateCitizenInVehicleSearchResult',
                    },
                });
            },
        },
        computed: {
            getAlerts() {
                // Collect together all the alerts
            },
            getCitizenName() {
                return `${this.vehicle.citizen.firstName} ${this.vehicle.citizen.lastName}`;
            },
            getCitizenAddress() {
                return `${this.vehicle.citizen.address} ${this.vehicle.citizen.postalCode}`;
            },
            citizenHasMarkers() {
                return (
                    this.vehicle.citizen.markers &&
                    this.vehicle.citizen.markers.length > 0
                );
            },
            citizenHasWarrants() {
                return (
                    this.vehicle.citizen.warrants &&
                    this.vehicle.citizen.warrants.length > 0
                );
            },
        },
    };
</script>

<style scoped>
    .vehicle {
        letter-spacing: 0.1em;
        margin-top: 5px;
        border: 2px solid rgba(255, 255, 255, 0.3);
    }
    .vehicle:first-child {
        margin-top: 70px;
    }
    .label {
        font-weight: bold;
    }
    .header {
        display: flex;
        align-items: center;
        background: rgba(255, 255, 255, 0.1);
        font-weight: 500;
        font-size: 24px;
        letter-spacing: 0.1em;
        color: rgba(255, 255, 255, 0.7);
    }
    .summary {
        margin: 15px 23px 19px 23px;
    }
    .markers {
        margin-left: 30px;
        display: flex;
    }
    .alerts-container {
        margin: 0 50px 0 auto;
    }
    .details {
        display: grid;
        grid-template-columns: 4fr 1fr 1fr;
        border-top: 1px solid rgba(255, 255, 255, 0.7);
    }
    .detail-section {
        display: flex;
    }
    .vehicle-markers {
        display: flex;
        padding: 8px 15px;
    }
    .property {
        color: rgba(255, 255, 255, 0.7);
        padding: 8px 15px;
    }
    .licences-details,
    .insurance-details,
    .warrant-details,
    .name-alerts,
    .owner-details {
        display: flex;
        align-items: center;
    }
</style>
