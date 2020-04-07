<template>
    <div class="citizen">
        <div class="header">
            <div class="name">
                {{ citizen.firstName }} {{ citizen.lastName }}
            </div>
            <div class="markers">
                <Markers :markers="citizen.markers" />
                <MiniButton
                    @miniClick="openMarkersModal()"
                    text="Edit markers"
                    colour="rgba(0,0,0,0.2)"
                    borderRadius="3px"
                    icon="fa-pen-alt"
                    padding="6px 8px"
                />
            </div>
            <div class="shove-right">
                <div v-if="getAlerts" class="alerts-container">
                    <Alert :icon="'fa-exclamation-triangle'" />
                </div>
                <div @click="setOpen">
                    <i v-show="!isOpen" class="fas fa-chevron-down"></i>
                    <i v-show="isOpen" class="fas fa-chevron-up"></i>
                </div>
            </div>
        </div>
        <div v-if="isOpen" class="details">
            <Property
                class="ethnicity property"
                :label="'Ethnicity'"
                :value="
                    citizen.ethnicity
                        ? citizen.ethnicity.name
                        : '[ Unknown ethnicity ]'
                "
            />
            <Property
                class="gender property"
                :label="'Gender'"
                :value="
                    citizen.gender ? citizen.gender.name : '[ Unknown gender ]'
                "
            />
            <Property
                class="height property"
                :label="'Height'"
                :value="citizen.height"
            />
            <Property
                class="weight property"
                :label="'Weight'"
                :value="citizen.weight"
            />
            <Property
                class="hair property"
                :label="'Hair'"
                :value="citizen.hair"
            />
            <Property
                class="eyes property"
                :label="'Eyes'"
                :value="citizen.eyes"
            />
            <Property
                class="address property"
                :label="'Address'"
                :value="citizen.address"
            />
            <Property
                class="postal-code property"
                :label="'Postal code'"
                :value="citizen.postalCode"
            />
            <Property
                class="dob property"
                :label="'DOB'"
                :value="citizen.dateOfBirth"
            />
            <div class="vehicles">
                <Vehicle
                    v-for="vehicle in citizen.vehicles"
                    :key="vehicle.id"
                    :vehicle="vehicle"
                />
            </div>
            <div class="weapons">
                <Weapon
                    v-for="weapon in citizen.weapons"
                    :key="weapon.id"
                    :weapon="weapon"
                />
            </div>
            <div class="licences">
                <Licence
                    v-for="licence in citizen.licences"
                    :key="licence.id"
                    :licence="licence"
                />
            </div>
            <div class="warrants">
                <Warrant
                    v-for="warrant in citizen.warrants"
                    :key="warrant.id"
                    :warrant="warrant"
                />
            </div>
            <div class="incidents">
                <Incidents :citizen="citizen" />
            </div>
        </div>
    </div>
</template>

<script>
    import Property from './Property.vue';
    import Vehicle from './Vehicle.vue';
    import Weapon from './Weapon.vue';
    import Licence from './Licence.vue';
    import Warrant from './Warrant.vue';
    import Markers from './Markers.vue';
    import Incidents from './Incidents.vue';
    import Alert from '../widgets/Alert.vue';
    import MiniButton from '../../MiniButton.vue';
    export default {
        components: {
            Property,
            Vehicle,
            Weapon,
            Licence,
            Warrant,
            Incidents,
            Alert,
            Markers,
            MiniButton,
        },
        props: {
            citizen: {
                type: Object,
                required: true,
            },
            open: {
                type: String,
                required: true,
            },
        },
        methods: {
            setOpen() {
                this.$emit(
                    'openCitizenResult',
                    this.isOpen ? '0' : this.citizen.id
                );
            },
            openMarkersModal() {
                this.$store.commit('setModal', {
                    type: 'markers',
                    data: {
                        open: true,
                        type: 'Citizen',
                        entity: this.citizen,
                        updateMutation: 'updateCitizenSearchResult',
                    },
                });
            },
        },
        computed: {
            isOpen() {
                // Is this citizen's pane open
                return this.open == this.citizen.id;
            },
            getAlerts() {
                // Collect together all the alerts
                /* 
                Temporarily disabled
                const alerts = this.getWarrants;
                return alerts.length > 0 ? alerts : null;
                */
                return null;
            },
            getWarrants() {
                return this.citizen.warrants;
            },
        },
    };
</script>

<style scoped>
    .citizen {
        letter-spacing: 0.1em;
        margin-top: 5px;
        border: 2px solid rgba(255, 255, 255, 0.3);
    }
    .citizen:first-child {
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
    .name,
    .shove-right {
        margin: 15px 23px 19px 23px;
    }
    .shove-right {
        display: flex;
        padding-left: 40px;
        margin-left: auto;
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
        grid-template-columns: repeat(12, 1fr);
        border-top: 1px solid rgba(255, 255, 255, 0.7);
    }
    .property {
        color: rgba(255, 255, 255, 0.7);
        padding: 15px;
    }
    .ethnicity {
        grid-area: 1/1/1/3;
        border-bottom: 1px solid rgba(255, 255, 255, 0.7);
        border-right: 1px solid rgba(255, 255, 255, 0.7);
    }
    .gender {
        grid-area: 1/3/1/5;
        border-bottom: 1px solid rgba(255, 255, 255, 0.7);
        border-right: 1px solid rgba(255, 255, 255, 0.7);
    }
    .height {
        grid-area: 1/5/1/7;
        border-bottom: 1px solid rgba(255, 255, 255, 0.7);
        border-right: 1px solid rgba(255, 255, 255, 0.7);
    }
    .weight {
        grid-area: 1/7/1/9;
        border-bottom: 1px solid rgba(255, 255, 255, 0.7);
        border-right: 1px solid rgba(255, 255, 255, 0.7);
    }
    .hair {
        grid-area: 1/9/1/11;
        border-bottom: 1px solid rgba(255, 255, 255, 0.7);
        border-right: 1px solid rgba(255, 255, 255, 0.7);
    }
    .eyes {
        grid-area: 1/11/1/13;
        border-bottom: 1px solid rgba(255, 255, 255, 0.7);
    }
    .address {
        grid-area: 2/1/2/7;
        border-right: 1px solid rgba(255, 255, 255, 0.7);
    }
    .postal-code {
        grid-area: 2/7/2/11;
        border-right: 1px solid rgba(255, 255, 255, 0.7);
    }
    .dob {
        grid-area: 2/11/2/13;
    }
    .vehicles {
        grid-area: 3/1/3/13;
        border-top: 1px solid rgba(255, 255, 255, 0.7);
    }
    .weapons {
        grid-area: 4/1/4/13;
        display: grid;
        grid-template-columns: repeat(auto-fill, 33%);
        border-top: 1px solid rgba(255, 255, 255, 0.7);
    }
    .licences {
        grid-area: 5/1/5/13;
        display: grid;
        grid-template-columns: repeat(auto-fill, 33%);
        border-top: 1px solid rgba(255, 255, 255, 0.7);
    }
    .warrants {
        grid-area: 6/1/6/13;
        display: grid;
        border-top: 1px solid rgba(255, 255, 255, 0.7);
    }
    .incidents {
        grid-area: 7/1/7/13;
        display: grid;
        grid-template-columns: auto;
        border-top: 1px solid rgba(255, 255, 255, 0.7);
    }
</style>
