<template>
    <div class="weapon">
        <SectionProperty class="section" label="Weapon" />
        <div class="details">
            <div class="type">
                <Property :label="''" :value="weapon.weaponType.name" />
            </div>
            <div class="name">
                <Property :label="'Status'" :value="weapon.weaponStatus.name" />
            </div>
        </div>
    </div>
</template>

<script>
import Property from './Property.vue';
import SectionProperty from './SectionProperty.vue';
export default {
    props: {
        weapon: {
            type: Object,
            required: true
        }
    },
    components: {
        Property,
        SectionProperty
    }
};
</script>

<style scoped>
.weapon {
    display: flex;
    color: rgba(255, 255, 255, 0.7);
    font-size: 14px;
    min-height: 40px;
}
.details {
    display: flex;
    align-items: center;
    flex-grow: 1;
    padding: 0 30px;
}
.details > div.name {
    margin-left: auto;
}
</style>
