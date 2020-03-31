import logger from './logger';
export default {
    created: function() {
        // Create listener for incoming messages coming from
        // client Lua
        window.addEventListener('message', event => this.processMessage(event));
    },
    destroyed: function() {
        // Destroy listener for incoming messages coming from
        // client Lua
        window.removeEventListener('message', event =>
            this.processMessage(event)
        );
    },
    mixins: [logger],
    methods: {
        // Handler for incoming messages from client Lua
        // const event = new Event('message');event.data = {action:'showMdt'};window.dispatchEvent(event);
        processMessage() {
            this.doLog('PROCESSING MESSAGE ' + JSON.stringify(event.data));
            if (
                event.data.hasOwnProperty('action') &&
                event.data.action == 'showMdt'
            ) {
                this.$store.commit('setVisible');
            } else if (event.data.hasOwnProperty('data')) {
                // Identify what sort of data we're receiving
                if (event.data.hasOwnProperty('object') && event.data.object) {
                    // Animate the "receiving" indicator
                    this.$store.commit('setConnectionIsActive');
                    switch (event.data.object) {
                        case 'config':
                            this.doLog('RECEIVED CONFIG');
                            this.$store.commit(
                                'setResourceConfig',
                                event.data.data
                            );
                            break;
                        case 'units':
                            this.doLog('RECEIVED UNITS');
                            this.$store.commit('setUnits', event.data.data);
                            break;
                        case 'unit_states':
                            this.doLog('RECEIVED UNIT STATES');
                            this.$store.commit(
                                'setUnitStates',
                                event.data.data
                            );
                            break;
                        case 'users':
                            this.doLog('RECEIVED USERS');
                            this.$store.commit('setUsers', event.data.data);
                            break;
                        case 'calls':
                            this.doLog('RECEIVED CALLS');
                            this.$store.commit('setCalls', event.data.data);
                            break;
                        case 'user_units':
                            this.doLog('RECEIVED USER_UNITS');
                            this.$store.commit('setUserUnits', event.data.data);
                            break;
                        case 'user_ranks':
                            this.doLog('RECEIVED USER_RANKS');
                            this.$store.commit('setUserRanks', event.data.data);
                            break;
                        case 'citizen_markers':
                            this.doLog('RECEIVED CITIZEN_MARKERS');
                            this.$store.commit(
                                'setCitizenMarkers',
                                event.data.data
                            );
                            break;
                        case 'vehicle_markers':
                            this.doLog('RECEIVED VEHICLE_MARKERS');
                            this.$store.commit(
                                'setVehicleMarkers',
                                event.data.data
                            );
                            break;
                        case 'vehicle_models':
                            this.doLog('RECEIVED VEHICLE_MODELS');
                            this.$store.commit(
                                'setVehicleModels',
                                event.data.data
                            );
                            break;
                        case 'steam_id':
                            this.doLog('RECEIVED STEAM ID');
                            this.$store.commit('setSteamId', event.data.data);
                            break;
                        case 'citizen_search_results':
                            this.doLog('RECEIVED CITIZEN SEARCH RESULTS');
                            this.$store.commit(
                                'setCitizenSearchResults',
                                event.data.data
                            );
                            break;
                        case 'vehicle_search_results':
                            this.doLog('RECEIVED VEHICLE SEARCH RESULTS');
                            this.$store.commit(
                                'setVehicleSearchResults',
                                event.data.data
                            );
                            break;
                        case 'citizen_offences':
                            this.doLog('RECEIVED CITIZEN OFFENCES');
                            this.$store.commit(
                                'setCitizenOffences',
                                event.data.data
                            );
                            break;
                        default:
                            this.doLog('Unknown object received');
                    }
                }
            }
        }
    }
};
