import Vue from 'vue';
import VueRouter from 'vue-router';

import Home from '../components/main/Home.vue';
import Status from '../components/main/status/Status.vue';
import SearchCitizens from '../components/main/search/citizens/SearchCitizens.vue';
import SearchVehicles from '../components/main/search/vehicles/SearchVehicles.vue';
import ComingSoon from '../components/reusable/ComingSoon.vue';

Vue.use(VueRouter);

const routes = [
    {
        path: '/',
        components: {
            status: Home
        }
    },
    {
        path: '/status',
        components: {
            status: Status
        }
    },
    {
        path: '/search/citizens',
        components: {
            search: SearchCitizens
        }
    },
    {
        path: '/search/vehicles',
        components: {
            search: SearchVehicles
        }
    },
    {
        path: '/search/incidents',
        components: {
            search: ComingSoon
        }
    },
    {
        path: '/search/bolo',
        components: {
            search: ComingSoon
        }
    },
    {
        path: '/create/incident',
        components: {
            create: ComingSoon
        }
    },
    {
        path: '/create/bolo',
        components: {
            create: ComingSoon
        }
    },
    {
        path: '/messaging',
        components: {
            messaging: ComingSoon
        }
    },
    {
        path: '/notes',
        components: {
            notes: ComingSoon
        }
    },
    {
        path: '/panic',
        components: {
            panic: ComingSoon
        }
    }
];

const router = new VueRouter({
    base: process.env.BASE_URL,
    routes
});

export default router;
