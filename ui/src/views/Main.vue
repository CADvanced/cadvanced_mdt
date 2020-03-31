<template>
    <main>
        <router-view name="status"></router-view>
        <router-view name="search"></router-view>
        <router-view name="create"></router-view>
        <router-view name="messaging"></router-view>
        <router-view name="notes"></router-view>
        <router-view name="panic"></router-view>
    </main>
</template>

<style scoped>
    main {
        grid-area: 2/1/3/1;
        padding: 40px 35px;
        overflow-y: auto;
    }
</style>
