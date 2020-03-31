<template>
    <div class="incident">
        <SectionProperty class="section" label="Incident" />
        <div class="details">
            <div class="time-location">
                <div class="spread">
                    <Property class="incident-date" :value="incident.date" />
                    &nbsp;
                    <Property class="incident-time" :value="incident.time" />
                </div>
                <Property class="location" :value="incident.location" />
            </div>
            <div class="arrest">
                <div class="label">Arrest</div>
                <div class="arrest-details">
                    <div v-if="!incident.arrest">Not made</div>
                    <div v-if="incident.arrest">
                        <div class="arrest-date-time">
                            <span class="label">Arrest</span>
                            <div class="spread">
                                <Property
                                    class="arrest-date"
                                    :value="incident.arrest.date"
                                />
                                &nbsp;
                                <Property
                                    class="arrest-time"
                                    :value="incident.arrest.time"
                                />
                            </div>
                        </div>
                        <div class="arrest-officer">
                            <span class="label">Arresting officer</span>
                            <div class="spread">
                                <Property
                                    :value="incident.arrest.officer.firstName"
                                />
                                &nbsp;
                                <Property
                                    :value="incident.arrest.officer.lastName"
                                />
                            </div>
                        </div>
                        <div class="arrest-charges">
                            <span class="label">Charges</span>
                            <Property
                                :value="
                                    incident.arrest.charges
                                        .map(c => c.name)
                                        .join(', ')
                                "
                            />
                        </div>
                    </div>
                </div>
            </div>
            <div class="tickets">
                <div class="label">Ticket</div>
                <div class="ticket-list">
                    <div v-if="!incident.ticket">Not issued</div>
                    <div v-if="incident.ticket">
                        <ul>
                            <li>
                                <Property
                                    :label="'Date & time'"
                                    :value="
                                        incident.ticket.date +
                                            ' ' +
                                            incident.ticket.time
                                    "
                                />
                            </li>
                            <li>
                                <Property
                                    :label="'Location'"
                                    :value="incident.ticket.location"
                                />
                            </li>
                            <li class="ticket-officer">
                                <Property
                                    :label="'Issuing officer'"
                                    :value="incident.ticket.officer.firstName"
                                />
                                &nbsp;
                                <Property
                                    :value="incident.ticket.officer.lastName"
                                />
                            </li>
                            <li>
                                <Property
                                    :label="'Points issued'"
                                    :value="incident.ticket.points"
                                />
                            </li>
                            <li>
                                <Property
                                    :label="'Fine issued'"
                                    :value="incident.ticket.fine"
                                />
                            </li>
                            <li>
                                <Property
                                    :label="'Notes'"
                                    :value="incident.ticket.notes"
                                />
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import Property from './Property.vue';
import SectionProperty from './SectionProperty.vue';
export default {
    props: {
        incident: {
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
.incident {
    color: rgba(255, 255, 255, 0.7);
    font-size: 14px;
    min-height: 40px;
    display: flex;
    border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}
.incident:last-child {
    border-bottom: 0;
}
.label {
    font-weight: bold;
}
.details {
    display: flex;
    flex-grow: 1;
    align-items: stretch;
    line-height: 18px;
}
.time-location {
    padding: 10px 15px;
    flex-basis: 15%;
    align-items: top;
    border-right: 1px solid rgba(255, 255, 255, 0.1);
}
.spread {
    display: flex;
}
.arrest {
    padding: 10px 15px;
    flex-basis: 50%;
    display: flex;
    align-items: top;
    border-right: 1px solid rgba(255, 255, 255, 0.1);
}
.arrest-details {
    padding-left: 30px;
}
.arrest-date-time,
.arrest-officer {
    margin-right: 15px;
}
.tickets {
    padding: 10px 15px;
    display: flex;
    align-items: top;
}
.ticket-list {
    padding-left: 30px;
}
.ticket-officer {
    display: flex;
}
</style>
