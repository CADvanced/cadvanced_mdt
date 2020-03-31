<template>
    <div class="warrant">
        <SectionProperty class="section" label="Warrant" />
        <div class="details">
            <Property :label="'From'" :value="warrant.validFrom" />
            &nbsp;-&nbsp;
            <Property :label="'To'" :value="warrant.validTo" />
            <Property
                class="warrant-details"
                :label="'Details'"
                :value="warrant.details"
            />
        </div>
    </div>
</template>

<script>
import Property from './Property.vue';
import SectionProperty from './SectionProperty.vue';
export default {
    props: {
        warrant: {
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
.warrant {
    display: flex;
    color: rgba(255, 255, 255, 0.7);
    font-size: 14px;
    min-height: 40px;
}
.details {
    display: flex;
    align-items: center;
    flex-grow: 1;
    padding: 10px 30px;
}
.warrant-details {
    margin-left: 20px;
}
</style>
