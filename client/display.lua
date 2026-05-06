local function debugPrint(...)
    if Config.Debug then
        print("[VehicleShop Debug]", ...)
    end
end

local function isLEOJob(job)
    for _, j in ipairs(Config.LEOJobs) do
        if j == job then return true end
    end
    return false
end


local vehicleDisplay = Config.VehicleDisplay or {}
local spawnedVehicles = {}

function spawnVehicles()
    for i, v in ipairs(vehicleDisplay) do
        RequestModel(GetHashKey(v.model))
        while not HasModelLoaded(GetHashKey(v.model)) do
            Wait(0)
        end

        local vehicle = CreateVehicle(GetHashKey(v.model), v.coords.x, v.coords.y, v.coords.z, v.coords.w, false, false)

        SetVehicleDoorsLocked(vehicle, 4) -- Locked for everyone
        SetVehicleDoorsLockedForAllPlayers(vehicle, true)
        SetEntityInvincible(vehicle, true)
        SetVehicleOnGroundProperly(vehicle)
        FreezeEntityPosition(vehicle, true)
        SetVehicleCanBeLockedOn(vehicle, false, false)
        SetEntityAsMissionEntity(vehicle, true, true)

        spawnedVehicles[i] = vehicle

        if Config.Debug then
            debugPrint(("Spawned display vehicle %s at [%.2f, %.2f]"):format(v.model, v.coords.x, v.coords.y))
        end
    end
end

function checkVehicles()
    CreateThread(function()
        while true do
            Wait(5000)
            for i, v in ipairs(vehicleDisplay) do
                local vehicle = spawnedVehicles[i]
                if not DoesEntityExist(vehicle) then
                    debugPrint(("Respawning missing display vehicle %s"):format(v.model))
                    RequestModel(GetHashKey(v.model))
                    while not HasModelLoaded(GetHashKey(v.model)) do
                        Wait(0)
                    end

                    local newVeh = CreateVehicle(GetHashKey(v.model), v.coords.x, v.coords.y, v.coords.z, v.coords.w, false, false)
                    SetVehicleDoorsLocked(newVeh, 4)
                    SetVehicleDoorsLockedForAllPlayers(newVeh, true)
                    SetEntityInvincible(newVeh, true)
                    SetVehicleOnGroundProperly(newVeh)
                    FreezeEntityPosition(newVeh, true)
                    SetVehicleCanBeLockedOn(newVeh, false, false)
                    SetEntityAsMissionEntity(newVeh, true, true)

                    spawnedVehicles[i] = newVeh
                end
            end
        end
    end)
end

function despawnVehicles()
    for _, vehicle in ipairs(spawnedVehicles) do
        if DoesEntityExist(vehicle) then
            DeleteEntity(vehicle)
        end
    end
    spawnedVehicles = {}
end

AddEventHandler("onResourceStop", function(resource)
    if resource == GetCurrentResourceName() then
        despawnVehicles()
    end
end)

CreateThread(function()
    spawnVehicles()
    checkVehicles()
end)
