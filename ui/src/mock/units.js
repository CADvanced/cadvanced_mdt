export default {
    data: {
        allUnits: [
            {
                id: '7',
                callSign: 'ojoijjo',
                unitType: {
                    id: '10',
                    name: 'Dog',
                    __typename: 'UnitType'
                },
                unitState: {
                    id: '9',
                    name: 'Inactive',
                    colour: 'd0021b',
                    __typename: 'UnitState'
                },
                assignedCalls: [
                    {
                        callIncidents: [
                            {
                                id: '9',
                                name: 'Arson',
                                __typename: 'IncidentType'
                            }
                        ],
                        callLocations: [
                            {
                                id: '32',
                                name: 'Conquistador Street',
                                __typename: 'Location'
                            }
                        ],
                        __typename: 'Call'
                    },
                    {
                        callIncidents: [
                            {
                                id: '9',
                                name: 'Arson',
                                __typename: 'IncidentType'
                            },
                            {
                                id: '10',
                                name: 'Murder',
                                __typename: 'IncidentType'
                            }
                        ],
                        callLocations: [
                            {
                                id: '2',
                                name: 'Abe Milton Parkway',
                                __typename: 'Location'
                            }
                        ],
                        __typename: 'Call'
                    }
                ],
                users: [],
                __typename: 'Unit'
            },
            {
                id: '8',
                callSign: 'pjpojpojp',
                unitType: {
                    id: '11',
                    name: 'Terrorism',
                    __typename: 'UnitType'
                },
                unitState: {
                    id: '8',
                    name: 'Active',
                    colour: '7ed321',
                    __typename: 'UnitState'
                },
                assignedCalls: [],
                users: [],
                __typename: 'Unit'
            },
            {
                id: '9',
                callSign: 'U1',
                unitType: {
                    id: '12',
                    name: 'UT1',
                    __typename: 'UnitType'
                },
                unitState: {
                    id: '10',
                    name: 'US1',
                    colour: '4a90e2',
                    __typename: 'UnitState'
                },
                assignedCalls: [
                    {
                        callIncidents: [
                            {
                                id: '9',
                                name: 'Arson',
                                __typename: 'IncidentType'
                            }
                        ],
                        callLocations: [
                            {
                                id: '32',
                                name: 'Conquistador Street',
                                __typename: 'Location'
                            }
                        ],
                        __typename: 'Call'
                    }
                ],
                users: [],
                __typename: 'Unit'
            },
            {
                id: '6',
                callSign: 'Alpha Bravo',
                unitType: {
                    id: '9',
                    name: 'Traffic',
                    __typename: 'UnitType'
                },
                unitState: {
                    id: '8',
                    name: 'Active',
                    colour: '7ed321',
                    __typename: 'UnitState'
                },
                assignedCalls: [],
                users: [
                    {
                        id: '9',
                        avatarUrl:
                            'https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/f9/f9305834bd3f043a980bb352cbe66ab9c9e55888.jpg',
                        userName: 'Chuckatron',
                        character: {
                            id: '4',
                            firstName: 'Bill',
                            lastName: 'James',
                            active: true,
                            UserId: '9',
                            __typename: 'Officer'
                        },
                        __typename: 'User'
                    }
                ],
                __typename: 'Unit'
            }
        ]
    }
};
