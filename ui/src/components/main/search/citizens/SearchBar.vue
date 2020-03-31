<template>
    <div id="search-bar">
        <input
            v-model="firstName"
            type="text"
            id="search-first-name"
            placeholder="First name"
            v-debounce:1s="handleUpdate"
        />
        <input
            v-model="lastName"
            type="text"
            id="search-surname"
            placeholder="Surname"
            v-debounce:1s="handleUpdate"
        />
        <input
            v-model="dateOfBirth"
            type="text"
            id="search-date-of-birth"
            placeholder="Date of birth"
            v-debounce:1s="handleUpdate"
        />
        <input
            v-model="id"
            type="text"
            id="search-id"
            placeholder="Citizen ID"
            v-debounce:1s="handleUpdate"
        />
    </div>
</template>

<script>
    export default {
        data: function() {
            return {
                firstName: '',
                lastName: '',
                dateOfBirth: '',
                id: ''
            };
        },
        computed: {
            preppedSearch() {
                let toSend = {};
                Object.keys(this.$data).forEach(key => {
                    const value = this.$data[key]
                        ? this.$data[key].toString().trim()
                        : null;
                    if (value && value.length > 0) {
                        toSend[key] = value;
                    }
                });
                return toSend;
            }
        },
        methods: {
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
        width: 310px;
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
</style>
