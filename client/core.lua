-- client.lua
lib = lib or exports.ox_lib

local openVehicleSelectionMenu
local openVehicleCustomMenu
local PreviewVeh = nil
local TestDriveVeh = nil

local function debugPrint(...)
    if Config.Debug then
        print("[VehicleShop Debug]", ...)
    end
end

local function PreviewVehicle(shopId, vehicleData)
    debugPrint("Previewing vehicle:", vehicleData.model)

    local shop = Config.Dealerships[shopId]
    local previewCoords = shop.preview or vector4(230.0, -1000.0, 29.0, 90.0)

    local modelHash = joaat(vehicleData.model)

    if not IsModelInCdimage(modelHash) or not IsModelAVehicle(modelHash) then
        debugPrint("Invalid vehicle model:", vehicleData.model)
        lib.notify({
            title = 'Invalid Model',
            description = ('Model "%s" is not valid or not a vehicle.'):format(vehicleData.model),
            type = 'error'
        })
        return
    end

    RequestModel(modelHash)
    local timeout = 5000
    while not HasModelLoaded(modelHash) and timeout > 0 do
        Wait(100)
        timeout -= 100
    end

    if not HasModelLoaded(modelHash) then
        debugPrint("Model failed to load:", vehicleData.model)
        lib.notify({
            title = 'Model Load Failed',
            description = ('Failed to load model "%s".'):format(vehicleData.model),
            type = 'error'
        })
        return
    end

    Wait(500) -- buffer delay

    if DoesEntityExist(PreviewVeh) then
        DeleteEntity(PreviewVeh)
        PreviewVeh = nil
    end

    PreviewVeh = CreateVehicle(modelHash, previewCoords.x, previewCoords.y, previewCoords.z, previewCoords.w, false, false)

    if not DoesEntityExist(PreviewVeh) then
        debugPrint("Vehicle spawn failed for:", vehicleData.model)
        lib.notify({
            title = 'Spawn Failed',
            description = ('Could not spawn preview vehicle "%s".'):format(vehicleData.label),
            type = 'error'
        })
        return
    end

    -- Now we know PreviewVeh exists
    if PreviewVeh then
        pcall(function()
SetVehicleNumberPlateText(PreviewVeh, (vehicleData.price and vehicleData.price > 0) and tostring(vehicleData.price) or "PREVIEW")
            SetEntityAsMissionEntity(PreviewVeh, true, true)
            SetEntityInvincible(PreviewVeh, true)
            SetVehicleDoorsLocked(PreviewVeh, 4)
            SetVehicleDoorsLockedForAllPlayers(PreviewVeh, true)
            SetVehicleUndriveable(PreviewVeh, true)
            FreezeEntityPosition(PreviewVeh, true)
            SetVehicleCanBreak(PreviewVeh, false)
            SetBlockingOfNonTemporaryEvents(PreviewVeh, true)
            SetVehicleEngineOn(PreviewVeh, false, true, false)
            SetEntityProofs(PreviewVeh, true, true, true, true, true, true, true, true)
            SetEntityCollision(PreviewVeh, false, false)

            SetVehicleModKit(PreviewVeh, 0)
            SetVehicleCustomPrimaryColour(PreviewVeh, 255, 255, 255)
            SetVehicleCustomSecondaryColour(PreviewVeh, 0, 0, 0)
        end)
    end
end

local function sellMyVehicleMenu(shopId)
    local allOwnedVehicles = lib.callback.await('vehicleShop:getOwnedVehiclesForSale', false)
    if not allOwnedVehicles or #allOwnedVehicles == 0 then
        lib.notify({
            title = 'No Vehicles',
            description = 'You don’t own any sellable vehicles.',
            type = 'error'
        })
        return
    end

    -- Get models sold at this dealership
    local shopVehicles = Config.Dealerships[shopId] and Config.Dealerships[shopId].vehicles or {}
    local allowedModels = {}
    for _, vehicle in ipairs(shopVehicles) do
        allowedModels[vehicle.model] = true
    end

    -- Filter owned vehicles
    local validVehicles = {}
    for _, v in ipairs(allOwnedVehicles) do
        if allowedModels[v.model] then
            table.insert(validVehicles, v)
        end
    end

    if #validVehicles == 0 then
        lib.notify({
            title = 'No Vehicles',
            description = 'You don’t own any vehicles this dealership buys.',
            type = 'error'
        })
        return
    end

    local options = {}
    for _, v in pairs(validVehicles) do
        table.insert(options, {
            title = ('%s (%s)'):format(v.label, v.plate),
            description = ('Sell for $%s'):format(v.sellPrice),
            icon = 'fas fa-dollar-sign',
            onSelect = function()
                TriggerServerEvent('vehicleShop:sellBackVehicle', v.model, v.plate, v.sellPrice, shopId)
            end
        })
    end

    lib.registerContext({
        id = 'sell_owned_vehicles_' .. shopId,
        title = 'Sell My Vehicles',
        options = options
    })

    lib.showContext('sell_owned_vehicles_' .. shopId)
end

function openVehicleSelectionMenu(vehicleList, shopId)
    debugPrint("Opening vehicle selection menu for:", shopId)

    table.sort(vehicleList, function(a, b)
        return a.label:lower() < b.label:lower()
    end)

    local options = {}
    local updatedVehicleList = {}

    for _, v in pairs(vehicleList) do
        local basePrice = tonumber(v.price)

        -- ?? Skip if price is missing or invalid
        if not basePrice or basePrice < 1 then
            debugPrint("Skipping vehicle with invalid price:", v.label, v.price)
            if Config.Debug then
                v.price = 0
                table.insert(updatedVehicleList, v)
            end
            goto continue
        end

        local model = v.model
        local count = lib.callback.await('vehicleShop:getModelStats', false, model, basePrice)

        local limit = v.maxOwned
        if not limit and Config.HighValueThreshold and basePrice >= Config.HighValueThreshold then
            limit = Config.MaxHighValuePerModel
        end
        

        if limit and count >= limit then
            debugPrint(("Model %s has %s/%s owned"):format(model, count, limit or "8"))
            if Config.Debug then
                v.price = 0
                table.insert(updatedVehicleList, v)
            else
                goto continue
            end
        else
            v.price = basePrice
            table.insert(updatedVehicleList, v)
        end

        ::continue::
    end

    -- Context menu logic continues...


    for _, v in pairs(updatedVehicleList) do
local priceLabel = (v.price == 0 and not Config.Debug) and 'Sold Out' or ('&pound;' .. v.price)
local testDriveDisabled = not Config.Debug and (not Config.Dealerships[shopId] or not Config.Dealerships[shopId].testDrive)
local buyDisabled = not Config.Debug and v.price == 0

lib.registerContext({
    id = 'confirm_or_test_' .. v.model,
    title = 'Test or Purchase?',
    options = {
        {
            title = 'Test Drive',
            icon = 'fas fa-road',
            onSelect = function()
                debugPrint("Test drive selected for:", v.model)
                if DoesEntityExist(PreviewVeh) then DeleteEntity(PreviewVeh) end
                TriggerServerEvent('vehicleShop:testDrive', v.model, shopId)
            end,
            disabled = not Config.Debug and (not Config.Dealerships[shopId] or not Config.Dealerships[shopId].testDrive)
        },
        {
            title = 'Buy Vehicle',
            icon = 'fas fa-money-bill-wave',
            onSelect = function()
                if DoesEntityExist(PreviewVeh) then DeleteEntity(PreviewVeh) end
                openVehicleCustomMenu(shopId, v)
            end,
            disabled = not Config.Debug and v.price == 0
        }
    }
})

        table.insert(options, {
            title = v.label,
            label = string.format('%s - %s', v.label, priceLabel),
            description = ("Model: %s | Price: %s"):format(v.model, priceLabel),
onSelect = function()
    CreateThread(function()
        PreviewVehicle(shopId, v)
        Wait(250) -- let rendering catch up
        lib.showContext('confirm_or_test_' .. v.model)
    end)
end
        })
    end

    if #options == 0 then
        lib.notify({
            title = 'No Vehicles',
            description = 'No vehicles found for this category.',
            type = 'error'
        })
        return
    end

    local contextId = 'shop_vehicles_' .. shopId

    lib.registerContext({
        id = contextId,
        title = 'Available Vehicles',
        options = options
    })

    lib.showContext(contextId)
end


function generateRandomPlate()
    local charset = {}
    for i = 48, 57 do table.insert(charset, string.char(i)) end -- 0-9
    for i = 65, 90 do table.insert(charset, string.char(i)) end -- A-Z

    local plate = ""
    for i = 1, 8 do
        plate = plate .. charset[math.random(1, #charset)]
    end
    return plate
end

function openVehicleCustomMenu(shopId, vehicleData)
    debugPrint("Opening custom menu for vehicle:", vehicleData.model)

    local dialogOptions = {
        { type = 'color', label = 'Primary Color', default = '#ffffff' },
        { type = 'color', label = 'Secondary Color', default = '#000000' },
        { type = 'select', label = 'Payment Method', options = {
            { label = 'Cash', value = 'cash' },
            { label = 'Bank', value = 'bank' },
        }}
    }

    if Config.AllowCustomPlate then
        table.insert(dialogOptions, 1, {
            type = 'input',
            label = 'Plate',
            placeholder = 'Custom plate',
            default = 'CUSTM',
            min = 3,
            max = 7
        })
    end

    local input = lib.inputDialog('Customize Vehicle', dialogOptions)

    if not input or #input < (#dialogOptions) then
        debugPrint("Vehicle customization cancelled or invalid input")
        return
    end

    debugPrint("Dialog result:", json.encode(input))

    local plate
    local color1
    local color2
    local payment

    if Config.AllowCustomPlate then
        plate = input[1] or "CUSTM"
        color1 = input[2] or "#ffffff"
        color2 = input[3] or "#000000"
        payment = input[4] or "cash"
    else
        plate = generateRandomPlate()
        color1 = input[1] or "#ffffff"
        color2 = input[2] or "#000000"
        payment = input[3] or "cash"
    end

    local data = {
        vehicle = vehicleData,
        plate = plate,
        color1 = color1,
        color2 = color2,
        payment = payment,
    }

    debugPrint("Customization submitted:", json.encode(data))

    TriggerServerEvent('vehicleShop:purchaseVehicle', shopId, data)
end

local function openShopMenu(shopId)
    debugPrint("Opening shop menu for:", shopId)
    local shop = Config.Dealerships[shopId]
    if not shop then debugPrint("Shop not found: " .. tostring(shopId)) return end

    if not shop.vehicles or #shop.vehicles == 0 then
        debugPrint("No vehicles defined for shop: " .. tostring(shopId))
        lib.notify({
            title = shop.label,
            description = 'No vehicles available.',
            type = 'error'
        })
        return
    end

    local categories = {}
    for _, v in pairs(shop.vehicles) do
        if v.category then
            categories[v.category] = categories[v.category] or {}
            table.insert(categories[v.category], v)
            debugPrint("Assigning vehicle to category:", v.label, v.model, v.category)
        else
            debugPrint("Vehicle has no category:", json.encode(v))
        end
    end

    debugPrint("Final categories table:", json.encode(categories))

    -- Alphabetical sort of categories
    local sortedCategories = {}
    for name in pairs(categories) do
        table.insert(sortedCategories, name)
    end
    table.sort(sortedCategories)

    local categoryOptions = {}
    for _, name in ipairs(sortedCategories) do
        local vehicles = categories[name]
        debugPrint("Adding category option:", name)
        local option = {
            label = name,
            description = 'Browse ' .. name .. ' vehicles',
            onSelect = function()
                debugPrint("Category clicked:", name)
                openVehicleSelectionMenu(vehicles, shopId)
            end
        }
        table.insert(categoryOptions, option)
    end

    debugPrint("Prepared category options")

    if #categoryOptions == 0 then
        lib.notify({
            title = 'No Categories',
            description = 'No categories were found with vehicles.',
            type = 'error'
        })
        return
    end

    local contextId = 'shop_categories_'..shopId

    debugPrint("Registering category context:", contextId)
    lib.registerContext({
        id = contextId,
        title = shop.label,
        options = categoryOptions
    })

    debugPrint("Showing context:", contextId)
    lib.showContext(contextId)
end

local function setupDealerships()
    debugPrint("Setting up dealerships...")
    for id, data in pairs(Config.Dealerships) do
        debugPrint("Loading model for ped:", data.pedModel)
        RequestModel(data.pedModel)
        while not HasModelLoaded(data.pedModel) do Wait(0) end

        debugPrint("Spawning ped for dealership:", id)
        local ped = CreatePed(4, data.pedModel, data.coords.x, data.coords.y, data.coords.z - 1, data.heading or 0.0, false, true)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        SetEntityHeading(ped, data.heading or 0.0)

        debugPrint("Adding ped to ox_target for:", id)
        local options = {
            {
                label = 'Browse Vehicles',
                icon = 'fas fa-car',
                onSelect = function()
                    debugPrint("Ped selected for shop:", id)
                    openShopMenu(id)
                end
            }
        }
        
if (data.allowSellBack ~= nil and data.allowSellBack) or
   (data.allowSellBack == nil and Config.SellVehicle) then
    table.insert(options, {
        label = 'Sell My Vehicle',
        icon = 'fas fa-hand-holding-usd',
        onSelect = function()
            sellMyVehicleMenu(id)
        end
    })
end
        
        exports.ox_target:addLocalEntity(ped, options)
        
    end
end

RegisterNetEvent('vehicleShop:startTestDrive', function(model, shopId)
    debugPrint("Starting Test Drive with: " .. tostring(model))

    if not shopId then
        debugPrint("shopId is nil")
        return
    end

    local shop = Config.Dealerships[shopId]
    if not shop then
        debugPrint("Shop is empty: " .. tostring(shopId))
        return
    end

    local coords = shop.testDriveSpawn or shop.coords
    debugPrint("Using coords:", coords)

    local playerPed = PlayerPedId()
    SetEntityCoords(playerPed, coords.x, coords.y, coords.z, false, false, false, false)
    Wait(100)

    TestDriveVeh = CreateVehicle(joaat(model), coords.x, coords.y, coords.z, coords.w or 0.0, true, false)
    SetEntityAsMissionEntity(TestDriveVeh, true, true)
    SetVehicleOnGroundProperly(TestDriveVeh)
    SetVehicleEngineOn(TestDriveVeh, true, true, false)
    SetVehicleDoorsLocked(TestDriveVeh, 1)
    
    local randomNumber = math.random(1000, 9999)
    SetVehicleNumberPlateText(TestDriveVeh, (shop.testDrivePlate or 'TESTDRV') .. tostring(randomNumber))
    SetVehicleUndriveable(TestDriveVeh, false)
    FreezeEntityPosition(TestDriveVeh, false)
    TaskWarpPedIntoVehicle(playerPed, TestDriveVeh, -1)

    if Config.GiveVehicleKeys and GiveVehicleKeys then
        debugPrint("Giving Vehicle Keys")
        GiveVehicleKeys(TestDriveVeh)
    end

    -- Give the rental item
    if Config.RentalItem then
        local plate = GetVehicleNumberPlateText(TestDriveVeh)
        local modelHash = GetEntityModel(TestDriveVeh)
        local modelName = GetLabelText(GetDisplayNameFromVehicleModel(modelHash))
        TriggerServerEvent('vehicleShop:giveTestDriveItem', plate, GetPlayerName(PlayerId()), shop.id, shop.label, modelName)
    end

lib.notify({
    title = 'Test Drive Started',
    description = Config.debug and 'You have 60 seconds! Press [y] to return early.' or 'You have 60 seconds! Press [y] to return early.',
    type = 'info'
})

local timer = (Config.Debug and 60 or (shop.testDriveLength or 60)) * 1000
    local interval = 1000
    local notifyId = 'testdrive-timer'
    local secondsLeft = math.floor(timer / 1000)

    lib.notify({
        id = notifyId,
        title = 'Test Drive',
        description = ('Time remaining: %ss'):format(secondsLeft),
        position = 'top',
        duration = false,
        type = 'inform'
    })
EnableControlAction(0, 246, true) -- Y

while timer > 0 do
    Wait(interval)
    timer = timer - interval
    secondsLeft = math.floor(timer / 1000)

    lib.notify({
        id = notifyId,
        title = 'Test Drive',
        description = ('Time remaining: %ss'):format(secondsLeft),
        position = 'top',
        duration = false,
        type = 'inform'
    })
if IsControlJustPressed(0, 246) then
    print("Y key pressed")
end

if Config.Debug and IsControlJustPressed(0, 246) then -- [Y] key
    debugPrint("Test drive cancelled early with [Y] in debug mode")
    TaskLeaveVehicle(playerPed, TestDriveVeh, 0)
    Wait(1000)
    DeleteVehicle(TestDriveVeh)
    TestDriveVeh = nil
    break
end
if not DoesEntityExist(TestDriveVeh) then
    debugPrint("Test drive vehicle no longer exists. Returning to dealership.")
        TestDriveVeh = nil

    break
end

end 

    -- End test drive

if DoesEntityExist(TestDriveVeh) then
    TaskLeaveVehicle(playerPed, TestDriveVeh, 0)
    Wait(1000)
    DeleteVehicle(TestDriveVeh)
    TestDriveVeh = nil
end

-- Teleport player back to shop coords
if shop and shop.coords then
-- Fade out
DoScreenFadeOut(500)
Wait(600)

-- Teleport back
SetEntityCoords(playerPed, shop.coords.x, shop.coords.y, shop.coords.z, false, false, false, false)

-- Fade in
Wait(500)
DoScreenFadeIn(1000)

lib.notify({
    title = 'Returned to Dealership',
    description = 'You were returned after the test drive.',
    type = 'info'
})

    debugPrint("Player returned to dealership after test drive.")
end

-- Remove rental item if used
if Config.RentalItem then
    TriggerServerEvent('vehicleShop:removeTestDriveItem')
end


    lib.notify({
        title = 'Test Drive Ended',
        description = 'Thank you for trying the vehicle.',
        type = 'success'
    })

    -- Clear the persistent notification
    lib.notify({
        id = notifyId,
        title = 'Test Drive',
        description = 'Test drive complete.',
        position = 'top',
        duration = 5000,
        type = 'inform'
    })
end)

RegisterNetEvent('vehicleShop:spawnPurchasedVehicle', function(model, plate, shopId, color1, color2)
    local playerPed = PlayerPedId()
    if not shopId then
        debugPrint("shopId is nil")
        return
    end

    local shop = Config.Dealerships[shopId]
    if not shop then
        debugPrint("Shop is empty: " .. tostring(shopId))
        return
    end

    local coords = shop.testDriveSpawn or shop.coords

    RequestModel(model)
    while not HasModelLoaded(model) do Wait(0) end

    local veh = CreateVehicle(joaat(model), coords.x, coords.y, coords.z, coords.w or 0.0, true, false)
    SetEntityAsMissionEntity(veh, true, true)
    SetVehicleOnGroundProperly(veh)
    SetVehicleNumberPlateText(veh, plate)
    TaskWarpPedIntoVehicle(playerPed, veh, -1)

    -- Convert HEX to RGB
    local function hexToRGB(hex)
        hex = hex:gsub("#", "")
        return tonumber("0x"..hex:sub(1,2)), tonumber("0x"..hex:sub(3,4)), tonumber("0x"..hex:sub(5,6))
    end

    -- Make sure mod kit is set *before* applying custom color
    SetVehicleModKit(veh, 0)

    if color1 then
        local r1, g1, b1 = hexToRGB(color1)
        SetVehicleCustomPrimaryColour(veh, r1 or 255, g1 or 255, b1 or 255)
        debugPrint("Primary color applied:", r1, g1, b1)
    end
    if color2 then
        local r2, g2, b2 = hexToRGB(color2)
        SetVehicleCustomSecondaryColour(veh, r2 or 255, g2 or 255, b2 or 255)
        debugPrint("Secondary color applied:", r2, g2, b2)
    end

    if Config.GiveVehicleKeys and GiveVehicleKeys then
        GiveVehicleKeys(veh)
    end

    lib.notify({
        title = 'Vehicle Delivered',
        description = 'Your new vehicle has been spawned!',
        type = 'success'
    })
end)


CreateThread(function()
    if not Config.GlobalBlipToggle then return end
    if not Config.Dealerships then
        print("[VehicleShop Debug] No dealerships defined in Config.Dealerships!")
        return
    end

    for shopId, shop in pairs(Config.Dealerships) do
        if shop.blip then
            local label = not Config.BlipUseDealershipLabel and "Dealership" or shop.label
            local icon = Config.BlipUseDealershipLabel and Config.GlobalBlipIcon or tonumber(shop.blipicon) or Config.GlobalBlipIcon
            local coords = shop.coords

            if coords then
                local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
                SetBlipSprite(blip, icon)
                SetBlipDisplay(blip, 4)
                SetBlipScale(blip, 0.6)
                SetBlipColour(blip, 3)
                SetBlipAsShortRange(blip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(label)
                EndTextCommandSetBlipName(blip)

                if Config.Debug then
                    print(("[VehicleShop Debug] Created blip for %s at %.2f, %.2f"):format(label, coords.x, coords.y))
                end
            end
        end
    end
end)
CreateThread(function()
    while true do
        Wait(500)
        if DoesEntityExist(PreviewVeh) then
            local ped = GetPedInVehicleSeat(PreviewVeh, -1)
            if ped and ped ~= 0 then
                TaskLeaveVehicle(ped, PreviewVeh, 16)
                debugPrint("Kicked someone from preview vehicle")
            end
        end
    end
end)


CreateThread(setupDealerships)