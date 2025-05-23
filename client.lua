-- This resource is protected under the GNU General Public License v3.0.
-- You may not redistribute this code without providing clear attribution to the original author (Scorpion).
-- https://choosealicense.com/licenses/gpl-3.0/
--  Copyright © 2025 Scorpion <https://github.com/scorpion7162> 

local entityCreators = {}
local resourceName = lib.cache.resource

CreateVehicle = (function(original)
    return function(modelHash, x, y, z, heading, isNetworked, bScriptHostVeh)
        local entity = original(modelHash, x, y, z, heading, isNetworked, bScriptHostVeh)
        if entity ~= 0 then
            entityCreators[entity] = resourceName
            local modelName = GetDisplayNameFromVehicleModel(modelHash)
            local netId = NetworkGetNetworkIdFromEntity(entity)
            lib.print.info(resourceName, "spawned vehicle", modelName, "NetID:", netId)
        end
        return entity
    end
end)(CreateVehicle)

DeleteEntity = (function(original)
    return function(entity)
        if entity ~= 0 then
            local creator = entityCreators[entity]
            if creator then
                local modelName = GetDisplayNameFromVehicleModel(GetEntityModel(entity))
                lib.print.warn(resourceName, "deleted vehicle", modelName, "originally spawned by:", creator)
                entityCreators[entity] = nil
            end
        end
        return original(entity)
    end
end)(DeleteEntity)

CreateThread(function()
    while true do
        Wait(5000)
        for entity, creator in pairs(entityCreators) do
            if not DoesEntityExist(entity) then
                lib.print.error("Vehicle orphaned - spawned by:", creator, "Entity:", entity)
                entityCreators[entity] = nil
            end
        end
    end
end)

-- This resource is protected under the GNU General Public License v3.0.
-- You may not redistribute this code without providing clear attribution to the original author (Scorpion).
-- https://choosealicense.com/licenses/gpl-3.0/
--  Copyright © 2025 Scorpion <https://github.com/scorpion7162> 


-- Thank you ox team for ox_lib <3 