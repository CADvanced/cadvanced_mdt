<template>
    <header>
        <MainNav />
        <Panic />
        <Exit />
    </header>
</template>

<script>
import MainNav from '../header/MainNav.vue';
import Panic from '../header/Panic.vue';
import Exit from '../header/Exit.vue';

export default {
    components: {
        MainNav,
        Panic,
        Exit
    }
};
</script>

<style scoped>
header {
    background: #333;
    grid-area: 1/1/2/1;
    border-radius: 5px 5px 0 0;
    padding: 0 30px;
    display: flex;
    align-items: center;
    text-transform: uppercase;
    color: rgba(255, 255, 255, 0.5);
    font-weight: 500;
    font-size: 24px;
    letter-spacing: 0.1em;
}
</style>
