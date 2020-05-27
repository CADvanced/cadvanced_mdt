import { debounce } from 'vue-debounce';
import { Howl } from 'howler';

export default {
    methods: {
        playSound(sound, repeatWhilePanic) {
            const conf = this.$store.getters.getResourceConfig;
            if (conf && conf.sound_volume) {
                const player = new Howl({
                    src: [sound],
                    loop: repeatWhilePanic,
                    volume: parseFloat(conf.sound_volume),
                    onend: () => {
                        const isPanicActive = this.$store.getters
                            .getPanicActive;
                        if (!isPanicActive) {
                            player.loop(false);
                        }
                    }
                });
                const debounced = debounce(() => player.play(), 1500);
                debounced();
            }
        },
        playRoger() {
            this.playSound('./sounds/roger.ogg');
        },
        playPanic() {
            const conf = this.$store.getters.getResourceConfig;
            if (conf.panic_play_tone) {
                this.playSound('./sounds/panic.ogg', true);
            }
        }
    }
};
