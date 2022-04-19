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
            '{ getUser(steamId: "$x") { id userName steamId avatarUrl x y roles { id name code } character { ... on Citizen { id firstName lastName active __typename } ... on Officer { id firstName lastName active department { id colour logo name bolo } __typename } } } }',
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
        query = 'mutation ($steamId: String!) { startPanic(steamId: $steamId) { id callerInfo markerX markerY DepartmentId callType { id name code readonly DepartmentId } callGrade { id name code readonly DepartmentId } callLocations { id name code readonly } callIncidents { id name code readonly DepartmentId } callDescriptions { id text } } }'
    }
    return json.encode(query)
end

function queries.get_all_calls()
    local query = {
        operationName = null,
        query = "{ allCalls { id callerInfo markerX markerY DepartmentId callGrade { id name code readonly DepartmentId } callType { id name code readonly DepartmentId } callLocations { id name } callIncidents { id name code readonly DepartmentId } callDescriptions { id text } assignedUnits { id } } }"
    }
    return json.encode(query)
end

function queries.get_preference(key)
    local query = {
        operationName = null,
        query = _doSub(
            '{getPreference(key: "$x") {key value}}',
            {x = key}
        )
    }
    return json.encode(query)
end

function queries.get_all_bolos()
    local query = {
        operationName = null,
        query = "{ allBolos { id boloType DepartmentId details { description knownName weapons lastLocation reason licencePlate driverDescription occupants } updatedAt } }"
    }
    return json.encode(query)
end

function queries.get_all_departments()
    local query = {
        operationName = null,
        query = '{allDepartments{id name colour logo readonly bolo}}'
    }
    return json.encode(query)
end

function queries.get_department_announcements()
    local query = {
        operationName = null,
        query = 'query allDepartmentAnnouncements($id: ID) { allDepartmentAnnouncements(id: $id) { id text DepartmentId createdAt updatedAt } }'
    }
    return json.encode(query)
end

function queries.get_all_units()
    local query = {
        operationName = null,
        query = "{ allUnits { id callSign DepartmentId unitType { id name DepartmentId } unitState { id name colour code active DepartmentId } UnitTypeId UnitStateId } }"
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
        query = "{ allUserRanks { id name position DepartmentId } } "
    }
    return json.encode(query)
end

function queries.get_unit(unit_id)
    local query = {
        operationname = null,
        query = _doSub(
            "{ getUnit(id: $x) { id callSign DepartmentId unitType { id name DepartmentId } unitState { id name colour code DepartmentId } UnitTypeId UnitStateId } }",
            {x = unit_id}
        )
    }
    return json.encode(query)
end

function queries.get_call(call_id)
    local query = {
        operationname = null,
        query = _doSub(
            "{ getCall(id: $x) { id callerInfo markerX markerY DepartmentId callGrade { id name DepartmentId } callType { id name code readonly DepartmentId } callLocations { id name } callIncidents { id name DepartmentId } callDescriptions { id text } assignedUnits { id } } }",
            {x = call_id}
        )
    }
    return json.encode(query)
end

function queries.get_bolo(bolo_id)
    local query = {
        operationname = null,
        query = _doSub(
            "{getBolo(id:$x){id boloType details{description knownName weapons lastLocation reason licencePlate driverDescription occupants}updatedAt}}",
            {x = bolo_id}
        )
    }
    return json.encode(query)
end

function queries.get_citizen(citizen_id)
    local query = {
        operationname = null,
        query = _doSub(
            '{ getCitizen(id: $x) { id firstName lastName address postalCode GenderId gender { id name } EthnicityId ethnicity { id name } vehicles { id colour licencePlate vehicleModel { id name } insuranceStatus { id name } markers { id name } } weapons { id weaponType { id name } weaponStatus { id name } } licences { id licenceType { id name } licenceStatus { id name } } warrants { id validFrom validTo details } markers { id name } offences { id date time location ArrestId arrest { id date time OfficerId officer { id firstName lastName } charges { id name } } charges { id name } TicketId ticket { id date time location points fine notes OfficerId officer { id firstName lastName } } } dateOfBirth weight height hair eyes active createdAt } }',
            {x = citizen_id}
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

function queries.send_citizen_call(props)
    -- Ensure all properties are populated, as we need to substitute
    -- all placeholders in the query
    local query = {
        operationname = null,
        variables = {
            steamId = props.steamId,
            location = props.location,
            callerInfo = props.callerInfo,
            DepartmentId = props.DepartmentId,
            notes = props.notes
        },
        query = 'mutation ($steamId: String!, $location: String!, $callerInfo: String!, $notes: String!, $DepartmentId: ID!) { createCitizenCall(steamId: $steamId, location: $location, callerInfo: $callerInfo, notes: $notes, DepartmentId: $DepartmentId) { id } }'
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
        query = "{ allUnitStates { id name colour DepartmentId } } "
    }
    return json.encode(query)
end

function queries.get_all_unit_types()
    local query = {
        operationName = null,
        query = "{ allUnitTypes { id name DepartmentId } } "
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
            UnitTypeId = unit.UnitTypeId,
            DepartmentId = unit.DepartmentId
        },
        query = "mutation ($id: ID!, $callSign: String!, $UnitTypeId: ID!, $UnitStateId: ID!, $DepartmentId: ID!) { updateUnit(id: $id, callSign: $callSign, UnitTypeId: $UnitTypeId, UnitStateId: $UnitStateId, DepartmentId: $DepartmentId) { id callSign unitType { id name DepartmentId } unitState { id name colour code DepartmentId } UnitTypeId UnitStateId DepartmentId } }"
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

function queries.get_all_charges()
    local query = {
        operationName = null,
        query = "{ allCharges { id name } } "
    }
    return json.encode(query)
end

function queries.create_offence(props)
    local query = {
        operationName = null,
        variables = {
            CitizenId = props.CitizenId,
            charges = {},
            date = props.date,
            location = props.location,
            time = props.time
        },
        query = "mutation ($date: String, $time: String, $location: String, $charges: [ChargeInput], $CitizenId: ID! ) { createOffence(date: $date, time: $time, location: $location, charges: $charges, CitizenId: $CitizenId) { id date time location ArrestId arrest { id date time OfficerId officer { id firstName lastName } charges { id name } } charges { id name } TicketId ticket { id date time location points fine notes OfficerId officer { id firstName lastName } } }}"
    }
    return json.encode(query)
end

function queries.update_offence(props)
    local query = {
        operationName = null,
        variables = {
            id = props.id,
            CitizenId = props.CitizenId,
            charges = props.charges,
            date = props.date,
            location = props.location,
            time = props.time
        },
        query = "mutation ($id: ID!, $date: String, $time: String, $location: String, $charges: [ChargeInput], $CitizenId: ID! ) { updateOffence(id: $id, date: $date, time: $time, location: $location, charges: $charges, CitizenId: $CitizenId) { id date time location ArrestId arrest { id date time OfficerId officer { id firstName lastName } charges { id name } } charges { id name } TicketId ticket { id date time location points fine notes OfficerId officer { id firstName lastName } } }}"
    }
    return json.encode(query)
end

function queries.create_ticket(props)
    local query = {
        operationName = null,
        variables = {
            CitizenId = props.CitizenId,
            OffenceId = props.OffenceId,
            OfficerId = props.OfficerId,
            date = props.date,
            fine = props.fine,
            location = props.location,
            notes = props.notes,
            points = props.points,
            time = props.time
        },
        query = "mutation ($date: String, $time: String, $location: String, $points: String, $fine: String, $notes: String, $CitizenId: ID!, $OfficerId: ID!, $OffenceId: ID!) { createTicket(date: $date, time: $time, location: $location, points: $points, fine: $fine, notes: $notes, CitizenId: $CitizenId, OfficerId: $OfficerId, OffenceId: $OffenceId) { id date time location points fine notes OfficerId officer { id firstName lastName } }}"
    }
    return json.encode(query)
end

function queries.update_ticket(props)
    local query = {
        operationName = null,
        variables = {
            id = props.id,
            CitizenId = props.CitizenId,
            OffenceId = props.OffenceId,
            OfficerId = props.OfficerId,
            date = props.date,
            fine = props.fine,
            location = props.location,
            notes = props.notes,
            points = props.points,
            time = props.time
        },
        query = "mutation ($id: ID!, $date: String, $time: String, $location: String, $points: String, $fine: String, $notes: String, $CitizenId: ID!, $OfficerId: ID!, $OffenceId: ID!) { updateTicket(id: $id, date: $date, time: $time, location: $location, points: $points, fine: $fine, notes: $notes, CitizenId: $CitizenId, OfficerId: $OfficerId, OffenceId: $OffenceId) { id date time location points fine notes OfficerId officer { id firstName lastName } }}"
    }
    return json.encode(query)
end

function queries.create_arrest(props)
    local query = {
        operationName = null,
        variables = {
            date = props.date,
            time = props.time,
            charges = props.charges,
            OfficerId = props.OfficerId,
            OffenceId = props.OffenceId,
            CitizenId = props.CitizenId
        },
        query = "mutation ($date: String, $time: String, $charges: [ChargeInput], $OfficerId: ID!, $OffenceId: ID!, $CitizenId: ID!) { createArrest(date: $date, time: $time, charges: $charges, OfficerId: $OfficerId, OffenceId: $OffenceId, CitizenId: $CitizenId) { id date time OfficerId officer { id firstName lastName  } charges { id name  } OffenceId  }}"
    }
    return json.encode(query)
end

function queries.update_arrest(props)
    local query = {
        operationName = null,
        variables = {
            id = props.id,
            date = props.date,
            time = props.time,
            charges = props.charges,
            OfficerId = props.OfficerId,
            OffenceId = props.OffenceId,
            CitizenId = props.CitizenId
        },
        query = "mutation ($id: ID!, $date: String, $time: String, $charges: [ChargeInput], $OfficerId: ID!, $OffenceId: ID!, $CitizenId: ID!) { updateArrest(id: $id, date: $date, time: $time, charges: $charges, OfficerId: $OfficerId, OffenceId: $OffenceId, CitizenId: $CitizenId) { id date time OfficerId officer { id firstName lastName } charges { id name } OffenceId } }"
    }
    return json.encode(query)
end

function queries.delete_offence(props)
    local query = {
        operationName = null,
        variables = {
            id = props.id,
            CitizenId = props.CitizenId
        },
        query = "mutation ($id: ID!, $CitizenId: ID!) { deleteOffence(id: $id, CitizenId: $CitizenId)}"
    }
    return json.encode(query)
end

function queries.get_all_locations()
    local query = {
        operationName = null,
        query = "{ allLocations { id name } }"
    }
    return json.encode(query)
end

function queries.get_all_call_grades()
    local query = {
        operationName = null,
        query = "{ allCallGrades { id name code DepartmentId } }"
    }
    return json.encode(query)
end

function queries.get_all_call_types()
    local query = {
        operationName = null,
        query = "{ allCallTypes { id name code DepartmentId } }"
    }
    return json.encode(query)
end

function queries.get_all_call_incidents()
    local query = {
        operationName = null,
        query = "{ allIncidentTypes { id name code DepartmentId } }"
    }
    return json.encode(query)
end

function queries.create_call(props)
    local query = {
        operationName = null,
        variables = {
            DepartmentId = props.DepartmentId,
            callerInfo = props.callerInfo,
            callGrade = props.callGrade,
            callType = props.callType,
            callIncidents = props.callIncidents,
            callLocations = props.callLocations,
            callDescriptions = props.callDescriptions,
            markerX = 0,
            markerY = 0
        },
        query = "mutation ($callerInfo: String, $callGrade: CallGradeInput!, $callType: CallTypeInput!, $callIncidents: [IncidentTypeInput]!, $callLocations: [LocationInput!]!, $callDescriptions: [CallDescriptionInput], $markerX: Float, $markerY: Float, $DepartmentId: ID!) { createCall(callerInfo: $callerInfo, callGrade: $callGrade, callType: $callType, callIncidents: $callIncidents, callLocations: $callLocations, callDescriptions: $callDescriptions, markerX: $markerX, markerY: $markerY, DepartmentId: $DepartmentId) { id callerInfo markerX markerY DepartmentId callType { id name code readonly DepartmentId } callGrade { id name code readonly DepartmentId } callLocations { id name code readonly } callIncidents { id name code readonly DepartmentId } callDescriptions { id text } }}"
    }
    return json.encode(query)
end

function queries.update_call(props)
    local query = {
        operationName = null,
        variables = {
            id = props.id,
            DepartmentId = props.DepartmentId,
            callerInfo = props.callerInfo,
            callGrade = props.callGrade,
            callType = props.callType,
            callIncidents = props.callIncidents,
            callLocations = props.callLocations,
            callDescriptions = props.callDescriptions,
            markerX = props.markerX,
            markerY = props.markerY
        },
        query = "mutation ($id: ID!, $callerInfo: String, $callGrade: CallGradeInput!, $callType: CallTypeInput!, $callIncidents: [IncidentTypeInput]!, $callLocations: [LocationInput!]!, $callDescriptions: [CallDescriptionInput], $markerX: Float, $markerY: Float, $DepartmentId: ID!) { updateCall(id: $id, callerInfo: $callerInfo, callGrade: $callGrade, callType: $callType, callIncidents: $callIncidents, callLocations: $callLocations, callDescriptions: $callDescriptions, markerX: $markerX, markerY: $markerY, DepartmentId: $DepartmentId) { id callerInfo markerX markerY DepartmentId callType { id name code readonly DepartmentId } callGrade { id name code readonly DepartmentId } callLocations { id name code readonly } callIncidents { id name code readonly DepartmentId } callDescriptions { id text } }}"
    }
    return json.encode(query)
end

function queries.create_bolo(props)
    local query = {
        operationName = null,
        variables = {
            id = props.id,
            DepartmentId = props.DepartmentId,
            boloType = props.boloType,
            details = props.details
        },
        query = "mutation createBolo($boloType: String! $details: BoloDetailsInput! $DepartmentId: ID!) {createBolo(boloType: $boloType details: $details DepartmentId: $DepartmentId) {id boloType DepartmentId details { description licencePlate driverDescription occupants lastLocation reason } } }"
    }
    return json.encode(query)
end

function queries.update_bolo(props)
    local query = {
        operationName = null,
        variables = {
            id = props.id,
            DepartmentId = props.DepartmentId,
            boloType = props.boloType,
            details = props.details
        },
        query = "mutation ($id: ID! $boloType: String! $details: BoloDetailsInput! $DepartmentId: ID!){updateBolo(id: $id boloType: $boloType details: $details DepartmentId: $DepartmentId){id boloType DepartmentId details {licencePlate driverDescription occupants lastLocation reason}}}"
    }
    return json.encode(query)
end

function queries.delete_call(props)
    local query = {
        operationName = null,
        variables = {
            callId = props.id
        },
        query = "mutation ($callId: ID!) { deleteCall(id: $callId)}"
    }
    return json.encode(query)
end

function queries.delete_bolo(props)
    local query = {
        operationName = null,
        variables = {
            boloId = props.id
        },
        query = "mutation ($boloId: ID!) { deleteBolo(id: $boloId)}"
    }
    return json.encode(query)
end

function queries.create_unit(props)
    local query = {
        operationName = null,
        variables = {
            DepartmentId = props.DepartmentId,
            callSign = props.callSign,
            unitStateId = props.unitState.id,
            unitTypeId = props.unitType.id
        },
        query = "mutation ($callSign: String!, $unitTypeId: ID!, $unitStateId: ID!, $DepartmentId: ID!) { createUnit(callSign: $callSign, UnitTypeId: $unitTypeId, UnitStateId: $unitStateId, DepartmentId: $DepartmentId) { id } }"
    }
    return json.encode(query)
end

function queries.update_unit(props)
    local query = {
        operationName = null,
        variables = {
            id = props.id,
            DepartmentId = props.DepartmentId,
            callSign = props.callSign,
            unitStateId = props.unitState.id,
            unitTypeId = props.unitType.id
        },
        query = "mutation ($id: ID!, $callSign: String!, $unitTypeId: ID!, $unitStateId: ID!, $DepartmentId: ID!) { updateUnit(id: $id, callSign: $callSign, UnitTypeId: $unitTypeId, UnitStateId: $unitStateId, DepartmentId: $DepartmentId) { id } }"
    }
    return json.encode(query)
end

function queries.delete_unit(props)
    local query = {
        operationName = null,
        variables = {
            unitId = props.id
        },
        query = "mutation ($unitId: ID!) { deleteUnit(id: $unitId)}"
    }
    return json.encode(query)
end

function queries.toggle_assignment(props)
    local mutation = props.currentlyAssigned and "divestCallFromUnit" or "assignCallToUnit"
    local query = {
        operationName = null,
        variables = {
            callId = props.callId,
            unitId = props.unitId
        },
        query = "mutation ($callId: ID!, $unitId: ID!) { " .. mutation .. "(CallId: $callId, UnitId: $unitId) { callId unitId } }"
    }
    return json.encode(query)
end

return queries
