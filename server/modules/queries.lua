local queries = {}

function _doSub(str, sub)
    return string.gsub(str, "%$(%w+)", sub)
end

function queries.get_whitelisted()
    local query = {
        operationName = null,
        query = "{ allWhitelisted{ steamId } }"
    }
    return json.encode(query)
end

function queries.get_user(steam_id)
    local query = {
        operationName = null,
        query = _doSub(
            '{ getUser(steamId: "$x") { id userName steamId avatarUrl x y roles { id name code } character { ... on Citizen { id firstName lastName active __typename } ... on Officer { id firstName lastName active __typename } } } }',
            {x = steam_id}
        )
    }
    return json.encode(query)
end

function queries.start_panic(steam_id)
    local query = {
        operationName = null,
        variables = {
            steamId = steam_id
        },
        query = 'mutation ($steamId: String!) { startPanic(steamId: $steamId) { id callerInfo markerX markerY callType { id name code readonly } callGrade { id name code readonly } callLocations { id name code readonly } callIncidents { id name code readonly } callDescriptions { id text } } }'
    }
    return json.encode(query)
end

function queries.get_all_calls()
    local query = {
        operationName = null,
        query = "{ allCalls { id callerInfo markerX markerY callGrade { id name } callType { id name } callLocations { id name } callIncidents { id name } callDescriptions { id text } assignedUnits { id } } }"
    }
    return json.encode(query)
end

function queries.get_all_units()
    local query = {
        operationName = null,
        query = "{ allUnits { id callSign unitType { id name } unitState { id name colour code } UnitTypeId UnitStateId } }"
    }
    return json.encode(query)
end

function queries.get_all_user_units()
    local query = {
        operationName = null,
        query = "{ allUserUnits { UserId UnitId UserRankId } }"
    }
    return json.encode(query)
end

function queries.get_all_user_ranks()
    local query = {
        operationName = null,
        query = "{ allUserRanks { id name position } } "
    }
    return json.encode(query)
end

function queries.get_unit(unit_id)
    local query = {
        operationname = null,
        query = _doSub(
            "{ getUnit(id: $x) { id callSign unitType { id name } unitState { id name colour code } UnitTypeId UnitStateId } }",
            {x = unit_id}
        )
    }
    return json.encode(query)
end

function queries.get_call(call_id)
    local query = {
        operationname = null,
        query = _doSub(
            "{ getCall(id: $x) { id callerInfo markerX markerY callGrade { id name } callType { id name } callLocations { id name } callIncidents { id name } callDescriptions { id text } assignedUnits { id } } }",
            {x = call_id}
        )
    }
    return json.encode(query)
end

function queries.search_citizens(props)
    -- Ensure all properties are populated, as we need to substitute
    -- all placeholders in the query
    local to_send = {}
    local allProps = {'firstName', 'lastName', 'dateOfBirth', 'id'};
    for _, key in ipairs(allProps) do
        if props[key] ~= nil and string.len(props[key]) > 0 then
            to_send[key] = props[key]
        else
            to_send[key] = ""
        end
    end
    local query = {
        operationname = null,
        query = _doSub(
            '{ searchCitizens(firstName: "$firstName", lastName: "$lastName", dateOfBirth: "$dateOfBirth", id: "$id" ) { id firstName lastName address postalCode GenderId gender { id name } EthnicityId ethnicity { id name } vehicles { id colour licencePlate vehicleModel { id name } insuranceStatus { id name } markers { id name } } weapons { id weaponType { id name } weaponStatus { id name } } licences { id licenceType { id name } licenceStatus { id name } } warrants { id validFrom validTo details } markers { id name } dateOfBirth weight height hair eyes active createdAt } }',
            to_send
        )
    }
    return json.encode(query)
end

function queries.search_vehicles(props)
    -- Ensure all properties are populated, as we need to substitute
    -- all placeholders in the query
    local to_send = {}
    local allProps = {'licencePlate', 'colour', 'vehicleModel'};
    for _, key in ipairs(allProps) do
        if props[key] ~= nil and string.len(props[key]) > 0 then
            to_send[key] = props[key]
        else
            to_send[key] = ""
        end
    end
    local query = {
        operationname = null,
        query = _doSub(
            '{ searchVehicles(licencePlate: "$licencePlate", colour: "$colour", vehicleModel: "$vehicleModel") { id colour licencePlate vehicleModel { id name } insuranceStatus { id name } markers { id name } citizen { id firstName lastName address postalCode markers { id name } licences { id licenceType { id name } licenceStatus { id name } } } } }',
            to_send
        )
    }
    return json.encode(query)
end

function queries.update_user_units(props)
    local query = {
        operationname = null,
        variables = {
            userId = props.user_id,
            assignments = props.user_units
        },
        query = "mutation ($assignments: [UserUnitInput], $userId: ID!) { updateUserAssignments(assignments: $assignments, userId: $userId) { UserId UnitId UserRankId } }"
    }
    return json.encode(query)
end

function queries.get_citizen_offences(data)
    local query = {
        operationname = null,
        query = _doSub(
            '{ getCitizen(id: "$id") { id offences { id date time location ArrestId arrest { id date time OfficerId officer { id firstName lastName } charges { id name } } charges { id name } TicketId ticket { id date time location points fine notes OfficerId officer { id firstName lastName } } } } }',
            data
        )
    }
    return json.encode(query)
end

function queries.get_all_unit_states()
    local query = {
        operationName = null,
        query = "{ allUnitStates { id name colour } } "
    }
    return json.encode(query)
end

function queries.get_all_citizen_markers()
    local query = {
        operationName = null,
        query = "{ allCitizenMarkers { id name } } "
    }
    return json.encode(query)
end

function queries.get_all_vehicle_markers()
    local query = {
        operationName = null,
        query = "{ allVehicleMarkers { id name } } "
    }
    return json.encode(query)
end

function queries.get_all_vehicle_models()
    local query = {
        operationName = null,
        query = "{ allVehicleModels { id name } } "
    }
    return json.encode(query)
end

function queries.set_unit_state(props, unit)
    local query = {
        operationname = null,
        variables = {
            id = props.unitId,
            callSign = unit.callSign,
            UnitStateId = props.stateId,
            UnitTypeId = unit.UnitTypeId
        },
        query = "mutation ($id: ID!, $callSign: String!, $UnitTypeId: ID!, $UnitStateId: ID!) { updateUnit(id: $id, callSign: $callSign, UnitTypeId: $UnitTypeId, UnitStateId: $UnitStateId) { id callSign unitType { id name } unitState { id name colour code } UnitTypeId UnitStateId } }"
    }
    return json.encode(query)
end

function queries.attach_marker_to_citizen(props)
    local query = {
        operationname = null,
        variables = {
            CitizenId = props.typeId,
            MarkerId = props.markerId
        },
        query = "mutation ($CitizenId: ID!, $MarkerId: ID!) { attachMarkerToCitizen(CitizenId: $CitizenId, MarkerId: $MarkerId) { id name type } }"
    }
    return json.encode(query)
end

function queries.detach_marker_from_citizen(props)
    local query = {
        operationname = null,
        variables = {
            CitizenId = props.typeId,
            MarkerId = props.markerId
        },
        query = "mutation ($CitizenId: ID!, $MarkerId: ID!) { detachMarkerFromCitizen(CitizenId: $CitizenId, MarkerId: $MarkerId) }"
    }
    return json.encode(query)
end

function queries.attach_marker_to_vehicle(props)
    local query = {
        operationname = null,
        variables = {
            VehicleId = props.typeId,
            MarkerId = props.markerId
        },
        query = "mutation ($VehicleId: ID!, $MarkerId: ID!) { attachMarkerToVehicle(VehicleId: $VehicleId, MarkerId: $MarkerId) { id name type } }"
    }
    return json.encode(query)
end

function queries.detach_marker_from_vehicle(props)
    local query = {
        operationname = null,
        variables = {
            VehicleId = props.typeId,
            MarkerId = props.markerId
        },
        query = "mutation ($VehicleId: ID!, $MarkerId: ID!) { detachMarkerFromVehicle(VehicleId: $VehicleId, MarkerId: $MarkerId) }"
    }
    return json.encode(query)
end

return queries
