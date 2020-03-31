export default {
    methods: {
        doLog(content) {
            const conf = this.$store.getters.getResourceConfig;
            if (conf && conf.debug) {
                console.log('CADVANCED NUI: ' + content);
            }
        }
    }
};
