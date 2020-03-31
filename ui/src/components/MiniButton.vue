<template>
    <button @click="emitClick" :style="styles" type="button">
        <i v-if="icon" :class="['fas', icon]"></i>
        {{ text }}
    </button>
</template>

<script>
    export default {
        props: {
            text: {
                type: String,
                required: true
            },
            colour: {
                type: String,
                required: true
            },
            padding: {
                type: String,
                required: false
            },
            borderColour: {
                type: String,
                required: false
            },
            borderRadius: {
                type: String,
                required: false
            },
            fontSize: {
                type: String,
                required: false
            },
            icon: {
                type: String,
                required: false
            }
        },
        computed: {
            styles() {
                const computedStyles = {
                    background: this.colour ? this.colour : 'rgba(0,0,0,0.1)',
                    border: this.borderColour
                        ? '1px solid ' + this.borderColour
                        : 0,
                    fontSize: this.fontSize ? this.fontSize : '13px',
                    borderRadius: this.borderRadius ? this.borderRadius : '4px'
                };
                if (this.padding) {
                    computedStyles.padding = this.padding;
                }
                return computedStyles;
            }
        },
        methods: {
            emitClick() {
                this.$emit('miniClick');
            }
        }
    };
</script>

<style scoped>
    button {
        padding: 1px 6px 3px 6px;
        letter-spacing: 0.1em;
        min-width: 50px;
        text-transform: uppercase;
        color: rgba(255, 255, 255, 0.8);
        margin: 0;
        cursor: pointer;
    }
    button:first-child {
        margin-left: 0;
    }
    button:last-child {
        margin-right: 0;
    }
    .fas {
        margin-right: 5px;
    }
</style>
