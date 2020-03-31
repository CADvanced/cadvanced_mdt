import axios from 'axios';
import logger from './logger';

export default {
    mixins: [logger],
    methods: {
        // Handler for sending messages to client Lua
        sendClientMessage(path, payload) {
            this.doLog('Sending message to ' + path);
            // Animate the "receiving" indicator
            this.$store.commit('setConnectionIsActive');
            axios.post(
                `http://cadvanced_mdt/${path}`,
                payload ? JSON.stringify(payload) : null
            );
        }
    }
};
