import Vue from 'vue';

import vueDebounce from 'vue-debounce';
import vSelect from 'vue-select';
import 'vue-select/dist/vue-select.css';

import MDT from './views/MDT.vue';

import router from './router';
import store from './store';

Vue.use(vueDebounce);
Vue.component('v-select', vSelect);

new Vue({
    router,
    store,
    el: '#app',
    render: h => h(MDT)
});
