import { debounce } from 'vue-debounce';
import { Howl } from 'howler';

export default {
    methods: {
        playSound(sound) {
            const conf = this.$store.getters.getResourceConfig;
            if (conf && conf.sound_volume) {
                const player = new Howl({
                    src: [sound],
                    volume: parseFloat(conf.sound_volume)
                });
                const debounced = debounce(() => player.play(), 1500);
                debounced();
            }
        },
        playRoger() {
            const sound = './sounds/roger.ogg';
            this.playSound(sound);
        }
    }
};
