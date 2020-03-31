import Vue from 'vue';
import Vuex from 'vuex';

import logger from '../mixins/logger';

Vue.use(Vuex);

const modalsInit = {
    ranks: {
        open: false
    },
    unitStates: {
        open: false
    },
    markers: {
        open: false
    },
    comingSoon: {
        open: false
    }
};

const store = new Vuex.Store({
    state: {
        resourceConfig: {},
        visible: false,
        connectionActive: false,
        steamId: '',
        activeMarker: -1,
        activeRoute: -1,
        character: {},
        users: [],
        calls: [],
        units: [],
        unitStates: [],
        userUnits: [],
        userRanks: [],
        citizenMarkers: [],
        vehicleMarkers: [],
        vehicleModels: [],
        citizenSearchResults: [],
        vehicleSearchResults: [],
        modals: modalsInit
    },
    getters: {
        getResourceConfig: state => state.resourceConfig,
        getUnits: state => state.units,
        getUnitStates: state => state.unitStates,
        getUsers: state => state.users,
        getCalls: state => state.calls,
        getCitizenMarkers: state => state.citizenMarkers,
        getVehicleMarkers: state => state.vehicleMarkers,
        getVehicleModels: state => state.vehicleModels,
        getUserUnits: state => state.userUnits,
        getUserRanks: state =>
            state.userRanks.sort((a, b) => a.position - b.position),
        getRank: (state, getters) => rankId => {
            const rank = getters.getUserRanks.find(r => r.id === rankId);
            return rank ? rank.name : null;
        },
        getSteamId: state => state.steamId,
        getCitizenSearchResults: state => state.citizenSearchResults,
        getVehicleSearchResults: state => state.vehicleSearchResults,
        isVisible: state => state.visible,
        getUser: state => {
            return state.users.find(user => user.steamId == state.steamId);
        },
        getActiveOfficer: (state, getters) => {
            const user = getters.getUser;
            return user &&
                user.hasOwnProperty('character') &&
                user.character.__typename == 'Officer'
                ? user.character
                : null;
        },
        getConnectionActive: state => state.connectionActive,
        getIsModalOpen: state => type => state.modals[type].open,
        getModalData: state => type => state.modals[type],
        getActiveMarker: state => state.activeMarker,
        getActiveRoute: state => state.activeRoute
    },
    mutations: {
        setResourceConfig: (state, passedConfig) =>
            (state.resourceConfig = passedConfig),
        setVisible: state => (state.visible = true),
        setHide: state => (state.visible = false),
        setUnits: (state, units) => (state.units = units),
        setUnitStates: (state, unitStates) => (state.unitStates = unitStates),
        setUserUnits: (state, userUnits) => (state.userUnits = userUnits),
        setUserRanks: (state, userRanks) => (state.userRanks = userRanks),
        setCitizenMarkers: (state, citizenMarkers) =>
            (state.citizenMarkers = citizenMarkers),
        setVehicleMarkers: (state, vehicleMarkers) =>
            (state.vehicleMarkers = vehicleMarkers),
        setVehicleModels: (state, vehicleModels) =>
            (state.vehicleModels = vehicleModels),
        setUsers: (state, users) => (state.users = users),
        setCalls: (state, calls) => (state.calls = calls),
        setSteamId: (state, steamId) => (state.steamId = steamId),
        setCitizenSearchResults: (state, searchResults) => {
            state.citizenSearchResults = searchResults.map(r => ({
                ...r,
                offences: []
            }));
        },
        setVehicleSearchResults: (state, searchResults) =>
            (state.vehicleSearchResults = searchResults),
        updateCitizenSearchResult: (state, updated) => {
            const resultIdx = state.citizenSearchResults.findIndex(
                r => r.id === updated.entity.id
            );
            state.citizenSearchResults.splice(resultIdx, 1, {
                ...state.citizenSearchResults[resultIdx],
                markers: updated.entity.markers
            });
        },
        updateVehicleSearchResult: (state, updated) => {
            const resultIdx = state.vehicleSearchResults.findIndex(
                r => r.id === updated.entity.id
            );
            state.vehicleSearchResults.splice(resultIdx, 1, {
                ...state.vehicleSearchResults[resultIdx],
                markers: updated.entity.markers
            });
        },
        updateVehicleInCitizenSearchResult: (state, updated) => {
            state.citizenSearchResults.forEach((result, resultIdx) => {
                const vehicleIdx = result.vehicles.findIndex(
                    v => v.id === updated.entity.id
                );
                if (vehicleIdx > -1) {
                    state.citizenSearchResults[resultIdx].vehicles.splice(
                        vehicleIdx,
                        1,
                        {
                            ...result.vehicles[vehicleIdx],
                            markers: updated.entity.markers
                        }
                    );
                }
            });
        },
        updateCitizenInVehicleSearchResult: (state, updated) => {
            state.vehicleSearchResults.forEach((result, resultIdx) => {
                if (result.citizen && result.citizen.id === updated.entity.id) {
                    state.vehicleSearchResults[resultIdx].citizen = {
                        ...state.vehicleSearchResults[resultIdx].citizen,
                        markers: updated.entity.markers
                    };
                }
            });
        },
        setConnectionIsActive: state => {
            state.connectionActive = true;
            setTimeout(() => (state.connectionActive = false), 1500);
        },
        setCitizenOffences: (state, citizen) => {
            if (citizen.offences.length > 0) {
                const foundIndex = state.citizenSearchResults.findIndex(
                    cit => cit.id == citizen.id
                );
                const found = state.citizenSearchResults[foundIndex];
                found.offences = citizen.offences;
                state.citizenSearchResults[foundIndex] = found;
            }
        },
        setModal: (state, args) =>
            (state.modals[args.type] = {
                ...state.modals[args.type],
                ...args.data
            }),
        resetModal: (state, args) =>
            (state.modals[args.type] = { open: false }),
        setActiveMarker: (state, callId) => (state.activeMarker = callId),
        setActiveRoute: (state, callId) => (state.activeRoute = callId)
    },
    subscribe: (mutation, state) => {
        logger.methods.doLog(mutation.type);
        logger.methods.doLog(mutation.payload);
        logger.methods.doLog(JSON.stringify(state));
    }
});

store.watch(
    state => state.modals,
    v => {
        logger.methods.doLog('VUEX WATCHER:');
        logger.methods.doLog(JSON.stringify(v));
    }
);

export default store;
