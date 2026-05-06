local QBCore = exports['qb-core']:GetCoreObject()

local function debugPrint(...)
    if Config.Debug then
        print("[VehicleShop Debug]", ...)
    end
end

local function sendWebhookLog(url, title, description, color)
    if not url or url == "" then
        return
    end

    PerformHttpRequest(url, function()
    end, 'POST', json.encode({
        username = 'Vehicle Shop Logs',
        embeds = {{
            title = title,
            description = description,
            color = color or 16777215,
            footer = {
                text = os.date("%Y-%m-%d %H:%M:%S")
            }
        }}
    }), {
        ['Content-Type'] = 'application/json'
    })
end

function GetVehicleByPlate(plate)
    for _, veh in pairs(GetAllVehicles()) do
        if GetVehicleNumberPlateText(veh) == plate then
            return veh
        end
    end
    return nil
end


lib.callback.register('vehicleShop:getModelStats', function(source, model, price)
    local xPlayer = exports.qbx_core:GetPlayer(source)
    -- Ensure your database or ownership table is accurate
    local result = MySQL.query.await('SELECT COUNT(*) as count FROM player_vehicles WHERE citizenid = ? AND vehicle = ?', {
        xPlayer.PlayerData.citizenid,
        model
    })
debugPrint(("[DEBUG] Returning owned count for %s: %s"):format(model, result[1].count))

    return result and result[1] and result[1].count or 0
end)

function GetVehicleOwner(plate)
    local result = MySQL.single.await('SELECT citizenid FROM player_vehicles WHERE plate = ?', { plate })
    return result and result.citizenid or nil
end



function checkLicense(src, shopId)
    local xPlayer = exports.qbx_core:GetPlayer(src)
    local shop = Config.Dealerships[shopId]

    if not xPlayer then
        debugPrint("checkLicense failed: xPlayer is nil for source:", src)
    sendWebhookLog(Config.GlobalWebhook, "? Check license Failed (SRC NIL) @ " .. shop.label,
        ("A Player has attempted to purchase a vehicle but failed license checks due to a system error"), 16753920)

        return false
    end

    if not shop then
        debugPrint("checkLicense failed: shop config is nil for shopId:", shopId)

    sendWebhookLog(Config.GlobalWebhook, "? Check license Failed (SHOP CONFIG) @ " .. shop.label,
        ("A Player has attempted to purchase a vehicle but failed license checks due to a system error"), 16753920)
        return false
    end

    if shop.license and shop.CheckLicense then
        local checkType = string.lower(shop.CheckLicense)
        local requiredLicense = shop.license
        local requiredItem = shop.licenseItem or requiredLicense

        local hasMetaLicense = xPlayer.PlayerData.metadata.licences and xPlayer.PlayerData.metadata.licences[requiredLicense] == true
        local hasLicenseItem = exports.ox_inventory:Search(src, 'count', requiredItem) > 0

        debugPrint(("License Check for shop %s (%s):"):format(shopId, shop.label))
        debugPrint(("Check Type: %s | Required Meta: %s | Required Item: %s"):format(checkType, tostring(requiredLicense), tostring(requiredItem)))
debugPrint(("License Check Type: %s | Player has Meta License: %s | Player has Item: %s")
    :format(checkType, tostring(hasMetaLicense), tostring(hasLicenseItem)))

sendWebhookLog(Config.GlobalWebhook, "? Check License State: (Item/Meta) @ " .. shop.label,
    ("A player attempted to purchase a vehicle with the following licenses.\nCheck Type: %s\nMeta License: %s\nItem License: %s")
    :format(checkType, tostring(hasMetaLicense), tostring(hasLicenseItem)), 16776960)

        local passed = false
        if checkType == "meta" then
            passed = hasMetaLicense
        elseif checkType == "item" then
            passed = hasLicenseItem
        elseif checkType == "both" then
            passed = hasMetaLicense and hasLicenseItem
        end

        if not passed then
            local failReason = checkType == "both" and "Missing both meta and item license"
                or checkType == "meta" and "Missing meta license"
                or "Missing license item"

            debugPrint("License check failed:", failReason)

            TriggerClientEvent('ox_lib:notify', src, {
                type = 'error',
                title = 'License Required',
                description = checkType == "both" and "You need both a valid license and physical license item."
                    or checkType == "meta" and "You need a valid driver license." or "You need a physical license item."
            })

            -- Send to webhook for audit trail
            sendWebhookLog(Config.GlobalWebhook, "? License Check Failed",
                ("Player: %s (%s)\nShop: %s\nModel: UNKNOWN\nRequired: %s\nMeta: %s | Item: %s\nCheck Type: %s"):format(
                    GetPlayerName(src), xPlayer.PlayerData.citizenid, shop.label,
                    requiredLicense, tostring(hasMetaLicense), tostring(hasLicenseItem), checkType
                ), 16733440)

            return false
        end
    end

    return true
end
RegisterNetEvent('vehicleShop:purchaseVehicle')

AddEventHandler('vehicleShop:purchaseVehicle', function(shopId, data)
    local src = source
    local xPlayer = exports.qbx_core:GetPlayer(src)
    local customerName = GetPlayerName(src) or "Unknown"
    local fullName = xPlayer and xPlayer.PlayerData and xPlayer.PlayerData.charinfo
                         and ("%s %s"):format(xPlayer.PlayerData.charinfo.firstname, xPlayer.PlayerData.charinfo.lastname) or customerName

    local shop = Config.Dealerships[shopId]
    if not xPlayer or not shop then return end

    local vehicleData = data.vehicle

    -- ?? Ownership Count Check
    local model = vehicleData.model
    local maxLimit = vehicleData.maxOwned or (tonumber(vehicleData.price or 0) >= Config.HighValueThreshold and Config.MaxHighValuePerModel or nil)

    if maxLimit then
debugPrint(("Checking maxOwned for model %s (Limit: %s)"):format(model, maxLimit or "none"))

local count = MySQL.Sync.fetchScalar([[
    SELECT COUNT(*) FROM player_vehicles
    WHERE vehicle = @model
]], { ['@model'] = model })
debugPrint(("[MAXOWNED] %s (%s) attempting to buy %s. Current citywide count: %s / %s"):format(
    fullName, xPlayer.PlayerData.citizenid, model, count or "nil", maxLimit
))


        if count and count >= maxLimit then
    sendWebhookLog(Config.GlobalWebhook, "? Purchase Failed - Max Owned in City @ " .. shop.label,
        ("Customer: %s\nPlate: %s\nModel: %s\nAmount: $%s\nPayment Method: %s"):format(
            fullName, data.plate, vehicleData.model, vehicleData.price, data.payment), 16753920)

            TriggerClientEvent('ox_lib:notify', src, {
                type = 'error',
                title = 'Sold Out',
                description = ('Only %s of this model are allowed in the city.'):format(maxLimit)
            })
            return
        end
    end

    -- License Check
    if not checkLicense(src, shopId) then
        sendWebhookLog(shop.webhook, "? Purchase Failed - Invalid License @ " .. shop.label,
            ("**Customer:** %s\n**Plate:** `%s`\n**Model:** `%s`\n**Amount:** $%s\n**License Check:** NO"):format(
                fullName, data.plate, vehicleData.model, vehicleData.price), 16733440)

        sendWebhookLog(Config.GlobalWebhook, "? Purchase Failed - Invalid License @ " .. shop.label,
            ("Customer: %s\nPlate: %s\nModel: %s\nAmount: $%s\n**License Check:** NO"):format(fullName, data.plate,
                vehicleData.model, vehicleData.price), 16711680)
        return
    end

debugPrint("Checking for duplicate plate:", data.plate)

    -- Duplicate Plate Check
    local result = MySQL.single.await('SELECT plate FROM player_vehicles WHERE plate = ?', {data.plate})
    if result then
        TriggerClientEvent('ox_lib:notify', src, {
            type = 'error',
            title = 'Duplicate Plate',
            description = 'That plate is already in use.'
        })
    sendWebhookLog(Config.GlobalWebhook, "? Purchase Failed - Plate IN USE @ " .. shop.label,
        ("Customer: %s\nPlate: %s\nModel: %s\nAmount: $%s\nPayment Method: %s"):format(
            fullName, data.plate, vehicleData.model, vehicleData.price, data.payment), 16753920)

        return
    end
local plate = string.upper(data.plate:gsub("%s+", "")) -- removes all spaces and makes uppercase
debugPrint("Checking for special characters:", plate)

-- Check for special characters (only allow letters and numbers)
if not plate:match("^[A-Z0-9]+$") then
    TriggerClientEvent('ox_lib:notify', src, {
        type = 'error',
        title = 'Invalid Plate',
        description = 'Plates may only contain letters and numbers.'
    })
    sendWebhookLog(Config.GlobalWebhook, "? Purchase Failed - Special Characters Found @ " .. shop.label,
        ("Customer: %s\nPlate: %s\nModel: %s\nAmount: $%s\nPayment Method: %s"):format(
            fullName, data.plate, vehicleData.model, vehicleData.price, data.payment), 16753920)

    return
end
debugPrint("Checking for blacklist:", plate)

    -- Blacklist Check
for _, entry in ipairs(Config.BlacklistPlates or {}) do
    local word = string.upper(entry.word or "")
    if (entry.match == "exact" and plate == word) or (entry.match ~= "exact" and string.find(plate, word, 1, true)) then
        TriggerClientEvent('ox_lib:notify', src, {
            type = 'error',
            title = 'Blacklisted Plate',
            description = 'That plate is not allowed.'
        })
    sendWebhookLog(Config.GlobalWebhook, "? Purchase Failed - Plate has failed blacklist check @ " .. shop.label,
        ("Customer: %s\nPlate: %s\nModel: %s\nAmount: $%s\nPayment Method: %s"):format(
            fullName, data.plate, vehicleData.model, vehicleData.price, data.payment), 16753920)

        return
    end
end
debugPrint("plate check's complete:", plate)

    -- Payment Logic
if data.payment ~= 'cash' and data.payment ~= 'bank' then
    debugPrint(("[ERROR] Invalid payment method: %s"):format(tostring(data.payment)))

    TriggerClientEvent('ox_lib:notify', src, {
        type = 'error',
        title = 'Invalid Payment',
        description = 'Invalid payment method selected. Please choose Cash or Bank.'
    })

    sendWebhookLog(Config.GlobalWebhook, "? Vehicle Purchase Failed - Invalid Payment Method",
        ("Customer: %s\nModel: %s\nPlate: %s\nAmount: $%s\nInvalid Payment Method: `%s`"):format(
            fullName, vehicleData.model, data.plate, vehicleData.price, tostring(data.payment)
        ), 16711680)

    return
end

-- Check if player has enough money
local hasMoney = xPlayer.Functions.GetMoney(data.payment) >= vehicleData.price
if not hasMoney then
    debugPrint(("[ERROR] Player %s (%s) does not have enough %s to buy %s ($%s)")
        :format(fullName, xPlayer.PlayerData.citizenid, data.payment, vehicleData.model, vehicleData.price))

    TriggerClientEvent('ox_lib:notify', src, {
        type = 'error',
        title = 'Not Enough Money',
        description = 'You do not have enough money.'
    })

    sendWebhookLog(Config.GlobalWebhook, "? Purchase Failed - Insufficient Funds @ " .. shop.label,
        ("Customer: %s\nPlate: %s\nModel: %s\nAmount: $%s\nPayment Method: %s"):format(
            fullName, data.plate, vehicleData.model, vehicleData.price, data.payment), 16753920)
    return
end

-- Attempt to remove money
local removed = xPlayer.Functions.RemoveMoney(data.payment, vehicleData.price, "vehicle purchase")
if not removed then
    debugPrint(("[ERROR] Failed to remove funds from %s (%s) for vehicle %s")
        :format(fullName, xPlayer.PlayerData.citizenid, vehicleData.model))

    TriggerClientEvent('ox_lib:notify', src, {
        type = 'error',
        title = 'Transaction Failed',
        description = 'There was a problem processing your payment. Try again.'
    })

    sendWebhookLog(Config.GlobalWebhook, "? Purchase Failed - Payment Processing Error @ " .. shop.label,
        ("Customer: %s\nModel: %s\nPlate: %s\nAttempted to charge $%s via %s, but failed."):format(
            fullName, vehicleData.model, data.plate, vehicleData.price, data.payment), 16711680)
    return
end

-- Credit dealership bank account
exports['wow_banking']:AddMoney(shop.bankAccount or Config.DefaultAccount, vehicleData.price)
debugPrint("Inserting vehicle into DB with plate:", data.plate)

-- Insert vehicle into DB
local inserted = MySQL.insert.await(
    'INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, garage, fuel, engine, body, state, in_garage, garage_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
    {
        xPlayer.PlayerData.license,
        xPlayer.PlayerData.citizenid,
        vehicleData.model,
        GetHashKey(vehicleData.model),
        json.encode({
            color1 = data.color1,
            color2 = data.color2
        }),
        data.plate,
        "pillboxgarage", 100, 1000.0, 1000.0, 1, 1, "pillboxgarage"
    }
)

if not inserted then
    debugPrint(("[ERROR] Failed to insert vehicle for %s (%s) into database.")
        :format(fullName, xPlayer.PlayerData.citizenid))

    TriggerClientEvent('ox_lib:notify', src, {
        type = 'error',
        title = 'Database Error',
        description = 'Your purchase could not be completed. Please contact staff.'
    })

    sendWebhookLog(Config.GlobalWebhook, "? Vehicle Insert Failed @ " .. shop.label,
        ("Customer: %s\nModel: %s\nPlate: %s\nAmount: $%s\nDB Insert Failed"):format(
            fullName, vehicleData.model, data.plate, vehicleData.price), 16711680)

    -- Refund if DB insert fails
    xPlayer.Functions.AddMoney(data.payment, vehicleData.price, "vehicle refund (insert fail)")
    return
else
    sendWebhookLog(Config.GlobalWebhook, "? Purchase Success @ " .. shop.label,
        ("Customer: %s\nModel: %s\nPlate: %s\nPaid $%s via %s."):format(
            fullName, vehicleData.model, data.plate, vehicleData.price, data.payment), 65280)

    TriggerClientEvent('ox_lib:notify', src, {
        type = 'success',
        title = 'Transaction Success',
        description = 'The vehicle has been sent to your garage for collection.'
    })

    -- ? SPOT MISSING THIS
    TriggerClientEvent('vehicleShop:spawnPurchasedVehicle', src, vehicleData.model, data.plate, shopId, data.color1, data.color2)
end
end)
lib.callback.register('vehicleShop:getOwnedVehiclesForSale', function(src)
    local xPlayer = exports.qbx_core:GetPlayer(src)
    if not xPlayer then return {} end

    local vehicles = MySQL.query.await('SELECT plate, vehicle FROM player_vehicles WHERE citizenid = ?', {
        xPlayer.PlayerData.citizenid
    })

    local list = {}
    for _, v in pairs(vehicles) do
        local model = v.vehicle
        local vehicleLabel, originalPrice

        -- Search all dealership configs
        for _, shop in pairs(Config.Dealerships) do
            for _, veh in pairs(shop.vehicles) do
                if veh.model == model then
                    vehicleLabel = veh.label
                    originalPrice = tonumber(veh.price)
                    break
                end
            end
            if originalPrice then break end
        end

if originalPrice then
    local resalePercent = (Config.Dealerships[shopId] and Config.Dealerships[shopId].resalePercentage) or Config.DefaultResalePercentage
    local calculatedPrice = math.floor(originalPrice * (resalePercent / 100))
    local sellPrice = math.max(calculatedPrice, 100) -- Ensure minimum of 100

    table.insert(list, {
        label = vehicleLabel,
        model = model,
        plate = v.plate,
        price = originalPrice,
        sellPrice = sellPrice
    })
end
    end

    return list
end)
RegisterNetEvent('vehicleShop:sellBackVehicle', function(model, plate, price, shopId)
    local src = source
    local xPlayer = exports.qbx_core:GetPlayer(src)
    if not xPlayer then return end
    local xPlayer = exports.qbx_core:GetPlayer(src)
    local customerName = GetPlayerName(src) or "Unknown"
    local fullName = xPlayer and xPlayer.PlayerData and xPlayer.PlayerData.charinfo
                         and ("%s %s"):format(xPlayer.PlayerData.charinfo.firstname, xPlayer.PlayerData.charinfo.lastname) or customerName
    local shop = Config.Dealerships[shopId]

    -- Confirm player owns the vehicle
    local owner = GetVehicleOwner(plate)
    if owner ~= xPlayer.PlayerData.citizenid then
        TriggerClientEvent('ox_lib:notify', src, {
            type = 'error',
            title = 'Ownership Error',
            description = 'You don t own this vehicle.'
        })
        return
    end

    -- Attempt to find and delete the vehicle entity if it's out
    local vehicle = GetVehicleByPlate(plate)
    if vehicle and DoesEntityExist(vehicle) then
        NetworkRequestControlOfEntity(vehicle)
        Wait(100)
        DeleteEntity(vehicle)
    end

    -- Delete vehicle from DB
    local deleted = MySQL.update.await('DELETE FROM player_vehicles WHERE citizenid = ? AND plate = ? AND vehicle = ?', {
        xPlayer.PlayerData.citizenid, plate, model
    })

    if deleted and deleted > 0 then
        -- Pay the player
        xPlayer.Functions.AddMoney('bank', price, 'vehicle-sellback')

        -- Notify success
        TriggerClientEvent('ox_lib:notify', src, {
            type = 'success',
            title = 'Vehicle Sold',
            description = ('You sold your %s for $%s'):format(model, price)
        })
    sendWebhookLog(Config.GlobalWebhook, "? Vehicle Sold to Dealership @ " .. shop.label,
        ("Customer: %s\nModel: %s\n We Paid $%s"):format(
            fullName, model,  price), 65280)

    else
        -- Notify failure
        TriggerClientEvent('ox_lib:notify', src, {
            type = 'error',
            title = 'Sale Failed',
            description = 'We couldn t find that vehicle.'
        })
    end
end)

RegisterNetEvent('vehicleShop:testDrive')
AddEventHandler('vehicleShop:testDrive', function(model, shopId)
    local src = source
    local xPlayer = exports.qbx_core:GetPlayer(src)
    local shop = Config.Dealerships[shopId]

    if not xPlayer or not shop then
        debugPrint("Test Drive: Player or Shop not found.")
        return
    end
    local customerName = GetPlayerName(src) or "Unknown"
    local fullName = xPlayer and xPlayer.PlayerData and xPlayer.PlayerData.charinfo
                         and ("%s %s"):format(xPlayer.PlayerData.charinfo.firstname,
            xPlayer.PlayerData.charinfo.lastname) or customerName

    if not xPlayer or not shop then
        return
    end

    if checkLicense(src, shopId) then


        sendWebhookLog(shop.webhook, "?? Test Drive Started @ " .. shop.label,
            ("**Customer:** %s\n**Model:** `%s`\n**License Check:** YES"):format(fullName, model), 5814783)

        sendWebhookLog(Config.GlobalWebhook, "Test Drive Started @ " .. shop.label,
        ("**Customer:** %s\n**Model:** `%s`\n**License Check:** YES"):format(fullName, model), 3447003)
      
            TriggerClientEvent('vehicleShop:startTestDrive', src, model, shopId)

    else
        sendWebhookLog(shop.webhook, "Test Drive Blocked - License @ " .. shop.label,
            ("**Customer:** %s\n**Model:** `%s`\n**License Check:** NO"):format(fullName, model), 16733440)

        sendWebhookLog(Config.GlobalWebhook, "Test Drive Failed - Invalid License @ " .. shop.label,
        ("**Customer:** %s\n**Model:** `%s`\n**License Check:** NO"):format(fullName, model), 16711680)
    end
end)

RegisterServerEvent('vehicleShop:giveTestDriveItem', function(plate, fivemName, shopId, shopLabel, modelName)
    local src = source
    local duration = (Config.Dealerships[shopId] and Config.Dealerships[shopId].testDriveLength) or 300

    local startTime = os.date('%Y-%m-%d %H:%M:%S')
    local endTime = os.date('%Y-%m-%d %H:%M:%S', os.time() + duration)

    local Player = exports.qbx_core:GetPlayer(src)
    local charName = fivemName

    if Player and Player.PlayerData and Player.PlayerData.charinfo then
        charName = ("%s %s"):format(Player.PlayerData.charinfo.firstname, Player.PlayerData.charinfo.lastname)
    end

    local metadata = {
        plate = plate,
        issued_to = charName,
        shopname = shopLabel,
        model = modelName,
        start_time = startTime,
        end_time = endTime,
        description = table.concat({
            "**Test Drive Paperwork & Insurance**",
            "Issued to: " .. charName,
            "From Dealership: " .. shopLabel,
            "For Vehicle: " .. modelName,
            "With Plate: " .. plate,
            "Start Time: " .. startTime,
            "End Time: " .. endTime,
        }, "\n")
    }

    debugPrint("Issuing Test Drive paperwork to " .. charName)
    exports.ox_inventory:AddItem(src, 'test_drive_paperwork', 1, metadata)
end)

RegisterServerEvent('vehicleShop:removeTestDriveItem', function()
    debugPrint("Removing Test Drive paperwork")
    local src = source

    -- Use GetInventoryItems instead
    local inventory = exports.ox_inventory:GetInventoryItems(src)
    if not inventory then
        debugPrint("No inventory found for player")
        return
    end

    for _, item in pairs(inventory) do
        if item.name == 'test_drive_paperwork' then
            debugPrint("Found item, Removed!")
            exports.ox_inventory:RemoveItem(src, 'test_drive_paperwork', 1, item.metadata)
            break
        end
    end
end)
