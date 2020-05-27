<template>
    <div
        id="mdt"
        :class="{ panic: shouldFlash }"
        v-bind:style="{ display: isVisible }"
    >
        <Header />
        <Main />
        <Footer />
    </div>
</template>

<script>
import Header from '../components/layout/Header.vue';
import Main from '../views/Main.vue';
import Footer from '../components/layout/Footer.vue';
// Import clientListener so we call its 'created' method
// to initialise the listener
import nuiListener from '../mixins/clientListener';
import clientSender from '../mixins/clientSender';

export default {
    created: function() {
        // Tell client we want some initial data
        this.sendClientMessage('init');
    },
    components: {
        Header,
        Main,
        Footer
    },
    mixins: [nuiListener, clientSender],
    computed: {
        isVisible() {
            return this.$store.getters.isVisible ? 'grid' : 'none';
        },
        shouldFlash() {
            const conf = this.$store.getters.getResourceConfig;
            return (
                conf.panic_flash_mdt === true &&
                this.$store.getters.getPanicActive
            );
        }
    }
};
</script>

<style>
body,
input,
textarea,
button {
    font-family: 'Jura', sans-serif;
}
#mdt {
    position: absolute;
    width: 95vw;
    height: 90vh;
    left: 2.5vw;
    top: 5vh;
    background: #4a4a4a;
    border: 5px solid #777;
    border-radius: 10px;
    display: grid;
    grid-template-columns: 1fr;
    grid-template-rows: 58px auto 48px;
}
div#mdt.panic {
    animation: blink 0.5s infinite alternate;
}
@keyframes blink {
    0% {
        border-color: #e20000;
    }
    50% {
        border-color: #777;
    }
}
</style>
