<template>
    <div id="create-container">
        <div id="arrest">
            <div class="create-header">
                ARREST
            </div>
            <div class="create-content">
                <div class="date"><input placeholder="DATE" /></div>
                <div class="time"><input placeholder="TIME" /></div>
                <div class="charges">CHARGES:</div>
            </div>
        </div>
    </div>
</template>

<style scoped>
#create-container {
    display: flex;
    flex-direction: column;
    border: 2px solid rgba(255, 255, 255, 0.3);
}
.create-header {
    flex: 1;
    background: rgba(255,255,255,0.1);
    color: rgba(255, 255, 255, 0.7);
    padding: 10px;
    font-size: 24px;
    letter-spacing: 0.1em;
    border-bottom: 1px solid rgba(255,255,255,0.3);
}
.create-content {
    font-size: 24px;
    flex: 1;
    letter-spacing: 0.1em;
    display: flex;
}
.create-content > div {
    display: flex;
    color: rgba(255, 255, 255, 0.7);
    border-right: 1px solid rgba(255,255,255,0.3)
}
.create-content > div:last-child {
    border: 0;
}
#arrest .date,
#arrest .time,
#arrest .officer {
    flex-grow: 1;
}
#arrest .charges {
    flex-grow: 3;
}
.create-content input {
    color: rgba(255, 255, 255, 0.7);
    outline: none;
    font-size: 18px;
    flex: 1;
    padding: 10px;
    background: none;
    border: 0;
}
.officer-select >>> .vs__dropdown-toggle {
    border: 0;
    background: none;
    color: rgba(255, 255, 255, 0.5);
    font-weight: 500;
    font-size: 18px;
    letter-spacing: 0.12em;
}
.officer-select >>> .vs__dropdown-menu {
    background: #4a4a4a;
    border: 2px solid rgba(255, 255, 255, 0.5);
    border-top: 0;
    color: rgba(255, 255, 255, 0.5);
    font-weight: 500;
    font-size: 18px;
    letter-spacing: 0.12em;
    overflow-x: hidden;
    overflow-y: auto;
}
.officer-select >>> .vs__search,
.officer-select >>> .vs__dropdown-option {
    color: rgba(255, 255, 255, 0.5);
    overflow-x: hidden;
}
.officer-select >>> .vs__dropdown-option--highlight {
    background: rgba(0, 0, 0, 0.5);
}
.officer-select >>> .vs__selected-options {
    overflow-x: hidden;
    overflow-y: hidden;
    white-space: nowrap;
}
.officer-select >>> .vs__selected {
    color: rgba(255, 255, 255, 0.5);
}
.officer-select >>> .vs__clear {
    fill: rgba(255, 255, 255, 0.5);
}
.officer-select >>> .vs__open-indicator {
    fill: rgba(255, 255, 255, 0.5);
    margin-right: 10px;
}
</style>
