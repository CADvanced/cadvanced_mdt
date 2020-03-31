<template>
    <div id="main_nav">
        <ul id="top_level">
            <router-link tag="li" to="/status">Status</router-link>
            <li
                class="dropdown_trigger"
                :class="{ 'router-link-active': isRoute('search') }"
            >
                Search
                <ul class="dropdown_container">
                    <router-link tag="li" to="/search/citizens"
                        >Citizens</router-link
                    >
                    <router-link tag="li" to="/search/vehicles"
                        >Vehicles</router-link
                    >
                    <router-link tag="li" to="/search/incidents"
                        >Incidents</router-link
                    >
                    <router-link tag="li" to="/search/bolo">BOLO</router-link>
                </ul>
            </li>
            <li
                class="dropdown_trigger"
                :class="{ 'router-link-active': isRoute('create') }"
            >
                Create
                <ul class="dropdown_container">
                    <router-link tag="li" to="/create/incident"
                        >Incident</router-link
                    >
                    <router-link tag="li" to="/create/bolo">BOLO</router-link>
                </ul>
            </li>
            <router-link tag="li" to="/messaging">Messaging</router-link>
            <router-link tag="li" to="/notes">Notes</router-link>
        </ul>
    </div>
</template>

<script>
export default {
    methods: {
        isRoute(path) {
            const regex = new RegExp(path);
            return regex.exec(this.$route.path);
        }
    }
};
</script>

<style scoped>
#main_nav {
    flex: 8 8 0;
}
ul {
    list-style-type: none;
    margin: 0;
    padding: 0;
}
#top_level {
    display: flex;
}
#top_level > li {
    color: rgba(255, 255, 255, 0.5);
    padding: 0 15px;
    border-right: 1px solid rgba(255, 255, 255, 0.71);
    border-left: 1px solid rgba(255, 255, 255, 0.71);
    cursor: pointer;
    position: relative;
}
#top_level > li:hover {
    color: rgba(0, 178, 255, 0.5);
}
#top_level > li.router-link-active {
    color: #00b2ff;
}
#top_level > li:first-child {
    border-left: 0;
    padding-left: 0;
}
#top_level > li:last-child {
    border-right: 0;
    padding-right: 0;
}
.dropdown_trigger:hover .dropdown_container,
.dropdown_container {
    display: flex;
}
.dropdown_container {
    display: none;
    flex-direction: column;
    position: absolute;
    top: 25px;
    left: -1px;
    padding-top: 5px;
    background: #333;
}
.dropdown_container li {
    padding: 10px;
    border-top: 1px solid rgba(255, 255, 255, 0.7);
    border-right: 1px solid rgba(255, 255, 255, 0.7);
    border-left: 1px solid rgba(255, 255, 255, 0.7);
    color: rgba(255, 255, 255, 0.5);
}
.dropdown_container > li.router-link-active {
    color: #00b2ff;
}
.dropdown_container li:hover {
    color: rgba(0, 178, 255, 0.5);
}
.dropdown_container li:last-child {
    border-bottom: 1px solid rgba(255, 255, 255, 0.7);
}
</style>
