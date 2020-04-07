<template>
    <div class="licence">
        <SectionProperty class="section" label="Licence" />
        <div class="details">
            <Property
                :value="
                    licence.licenceType
                        ? licence.licenceType.name
                        : '[ Unknown licence type ]'
                "
            />
            &nbsp; : &nbsp;
            <Property
                :value="
                    licence.licenceStatus
                        ? licence.licenceStatus.name
                        : '[ Unknown status ]'
                "
            />
        </div>
    </div>
</template>

<script>
    import Property from './Property.vue';
    import SectionProperty from './SectionProperty.vue';
    export default {
        props: {
            licence: {
                type: Object,
                required: true,
            },
        },
        components: {
            Property,
            SectionProperty,
        },
    };
</script>

<style scoped>
    .licence {
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
