<template>
    <div id="search-bar">
        <input
            v-model="licencePlate"
            type="text"
            id="search-licence-plate"
            placeholder="Licence plate"
            v-debounce:1s="handleUpdate"
        />
        <input
            v-model="colour"
            type="text"
            id="search-colour"
            placeholder="Colour"
            v-debounce:1s="handleUpdate"
        />
        <v-select
            class="vehicle-select"
            v-model="vehicleModel"
            label="name"
            :options="vehicleModels"
            @input="handleSelectUpdate"
        />
    </div>
</template>

<script>
export default {
    data: function () {
        return {
            licencePlate: '',
            colour: '',
            vehicleModel: {}
        };
    },
    computed: {
        preppedSearch() {
            let toSend = {};
            Object.keys(this.$data).forEach(key => {
                let value = this.$data[key];
                if (value instanceof Object) {
                    value = value.id;
                }
                value = value ? value.toString().trim() : null;
                if (value && value.length > 0) {
                    toSend[key] = value;
                }
            });
            return toSend;
        },
        vehicleModels() {
            return this.$store.getters.getVehicleModels;
        }
    },
    methods: {
        handleSelectUpdate(val) {
            this.vehicleModel = val;
            this.handleUpdate();
        },
        handleUpdate() {
            const toSend = this.preppedSearch;
            // Don't send empty searches
            if (Object.keys(toSend).length > 0) {
                this.$emit('searchChanged', this.preppedSearch);
            }
        }
    }
};
</script>

<style scoped>
#search-bar {
    display: flex;
    justify-content: space-between;
}
#search-bar > input {
    width: 410px;
    height: 16px;
    border-radius: 5px;
    border: 2px solid rgba(255, 255, 255, 0.5);
    background: none;
    padding: 20px 20px 24px 20px;
    color: rgba(255, 255, 255, 0.5);
    font-weight: 500;
    font-size: 24px;
    letter-spacing: 0.12em;
}
.vehicle-select >>> .vs__dropdown-toggle {
    width: 410px;
    height: 64px;
    border-radius: 5px;
    border: 2px solid rgba(255, 255, 255, 0.5);
    background: none;
    color: rgba(255, 255, 255, 0.5);
    font-weight: 500;
    font-size: 24px;
    letter-spacing: 0.12em;
}
.vehicle-select >>> .vs__dropdown-menu {
    background: #4a4a4a;
    border: 2px solid rgba(255, 255, 255, 0.5);
    border-top: 0;
    color: rgba(255, 255, 255, 0.5);
    font-weight: 500;
    font-size: 24px;
    letter-spacing: 0.12em;
    overflow-x: hidden;
    overflow-y: auto;
}
.vehicle-select >>> .vs__search,
.vehicle-select >>> .vs__dropdown-option {
    color: rgba(255, 255, 255, 0.5);
    overflow-x: hidden;
}
.vehicle-select >>> .vs__dropdown-option--highlight {
    background: rgba(0, 0, 0, 0.5);
}
.vehicle-select >>> .vs__selected-options {
    overflow-x: hidden;
    overflow-y: hidden;
    white-space: nowrap;
}
.vehicle-select >>> .vs__selected {
    color: rgba(255, 255, 255, 0.5);
}
.vehicle-select >>> .vs__clear {
    fill: rgba(255, 255, 255, 0.5);
}
.vehicle-select >>> .vs__open-indicator {
    fill: rgba(255, 255, 255, 0.5);
    margin-right: 10px;
}
</style>
