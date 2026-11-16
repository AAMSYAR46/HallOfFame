local spawnedPeds = {}

-- Function to spawn an NPC
local function SpawnNpc(index, v)
    local model = v.NPC.Model
    local hash = type(model) == "number" and model or GetHashKey(model)

    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(10)
    end

    local x, y, z = table.unpack(v.coords)
    local playerPed = CreatePed(4, hash, x, y, z - 1.0, v.NPC.heading, false, true)

    FreezeEntityPosition(playerPed, true)
    SetEntityInvincible(playerPed, true)
    SetBlockingOfNonTemporaryEvents(playerPed, true)

    if v.NPC.UseSecnario then
        TaskStartScenarioInPlace(playerPed, v.NPC.Secnario, 0, false)
    else
        if v.NPC.AnimationDirect and v.NPC.AnimationScene then
            lib.requestAnimDict(v.NPC.AnimationDirect)
            TaskPlayAnim(playerPed, v.NPC.AnimationDirect, v.NPC.AnimationScene, 8.0, -8.0, -1, 0, 0, false, false, false)    
            RemoveAnimDict(v.NPC.AnimationDirect)
        end
    end

    -- Apply Clothes & Appearance if configured
    if v.NPC.Cloth then
        local c = v.NPC.Cloth
        SetPedHeadBlendData         (playerPed, c.face1, c.face1, c.face1, c.skin, c.skin, c.skin, 1.0, 1.0, 1.0, true)
        SetPedEyeColor              (playerPed, c.eye_color, 0, 1)                                              
        SetPedComponentVariation    (playerPed, 2,  c.hair_1,       c.hair_2, 2)                        
        SetPedHairColor             (playerPed,     c.hair_color_1, c.hair_color_2)               
        SetPedComponentVariation    (playerPed, 11, c.torso_1,      c.torso_2, 2)                    
        SetPedComponentVariation    (playerPed, 8,  c.tshirt_1,     c.tshirt_2, 2)                  
        SetPedComponentVariation    (playerPed, 3,  c.arms,         c.arms_2, 2)                        
        SetPedComponentVariation    (playerPed, 4,  c.pants_1,      c.pants_2, 2)                   
        SetPedComponentVariation    (playerPed, 6,  c.shoes_1,      c.shoes_2, 2)                   
        SetPedComponentVariation    (playerPed, 10, c.decals_1,     c.decals_2, 2)                  
        SetPedComponentVariation    (playerPed, 1,  c.mask_1,       c.mask_2, 2)                
        SetPedComponentVariation    (playerPed, 9,  c.bproof_1,     c.bproof_2, 2)          
        SetPedComponentVariation    (playerPed, 7,  c.chain_1,      c.chain_2, 2)               
        SetPedComponentVariation    (playerPed, 5,  c.bags_1,       c.bags_2, 2)
        SetPedPropIndex             (playerPed, 2,  c.ears_1,       c.ears_2, 2)                                    
        SetPedPropIndex             (playerPed, 0,  c.helmet_1,     c.helmet_2, 2)          
        SetPedPropIndex             (playerPed, 1,  c.glasses_1,    c.glasses_2, 2)         
        SetPedPropIndex             (playerPed, 6,  c.watches_1,    c.watches_2, 2)             
        SetPedPropIndex             (playerPed, 7,  c.bracelets_1,  c.bracelets_2)          
        SetPedHeadOverlay           (playerPed, 1,  c.beard_1,      (c.beard_2 / 10) + 0.0) 
        SetPedHeadOverlayColor      (playerPed, 1, 1,   c.beard_3,      c.beard_4)                      
        SetPedHeadOverlay           (playerPed, 2,  c.eyebrow_type, (c.eyebrow_size / 10) + 0.0)        
        SetPedHeadOverlayColor      (playerPed, 2, 1,   c.eyebrow_color_1, c.eyebrow_color_2)                   
        SetPedHeadOverlay           (playerPed, 4,  c.makeup_type,  (c.makeup_thickness / 10) + 0.0)            
        SetPedHeadOverlay           (playerPed, 8,  c.lipstick_type,(c.lipstick_thickness / 10) + 0.0)        
        SetPedHeadOverlay           (playerPed, 5,  c.blush,        (c.blush_1 / 10) + 0.0)         
        SetPedHeadOverlay           (playerPed, 6,  c.complexion,   (c.complexion_1 / 10) + 0.0)        
        SetPedHeadOverlay           (playerPed, 7,  c.sun,          (c.sun_1 / 10) + 0.0)           
        SetPedHeadOverlay           (playerPed, 9,  c.freckles,     (c.freckles_1 / 10) + 0.0)          
        SetPedHeadOverlay           (playerPed, 10, c.chest_hair,   (c.chest_hair_1 / 10) + 0.0)            
        SetPedHeadOverlay           (playerPed, 11, c.bodyb,        (c.bodyb_size / 10) + 0.0)          
        SetPedHeadOverlayColor      (playerPed, 10, 1,  c.chest_color)                                                  
        SetPedHeadOverlayColor      (playerPed, 4, 1,   c.makeup_color_1, c.makeup_color_2)                     
        SetPedHeadOverlayColor      (playerPed, 5, 2,   c.blush_color)                                                  
        SetPedHeadOverlayColor      (playerPed, 8, 1,   c.lipstick_color_1, c.lipstick_color_2)                 
        
        if c.collection and c.nameHash then
            ApplyPedOverlay(playerPed, GetHashKey(c.collection), GetHashKey(c.nameHash))
        end
    end

    -- Free up model memory
    SetModelAsNoLongerNeeded(hash)
    spawnedPeds[index] = playerPed
end

-- Function to delete an NPC
local function DeleteNpc(index)
    if DoesEntityExist(spawnedPeds[index]) then
        DeleteEntity(spawnedPeds[index])
    end
    spawnedPeds[index] = nil
end

-- Unified management thread (Handles spawning, despawning, and 3D text drawing efficiently)
Citizen.CreateThread(function()
    while true do
        local sleep = 1000 -- Default to 1 second sleep when player is far from all NPCs
        local playerPed = PlayerPedId()
        local pedCoords = GetEntityCoords(playerPed)

        for k, v in pairs(Config.Npc) do
            local npcCoords = vector3(v.coords.x, v.coords.y, v.coords.z)
            local distance = #(pedCoords - npcCoords)
            local spawnDistance = Config.SpawnDistance or 40.0
            local drawDistance = Config.Distance or 10.0

            if distance <= spawnDistance then
                sleep = 0 -- Run every frame when close to an NPC
                
                -- Spawn if not already spawned
                if not spawnedPeds[k] then
                    SpawnNpc(k, v)
                -- Draw text if close enough
                elseif distance <= drawDistance then
                    Draw3DText(npcCoords.x, npcCoords.y, npcCoords.z + 1.0, v.NPC.Text, v.NPC.Font, v.NPC.ScaleX, v.NPC.ScaleY, v.NPC.Bar)
                end
            else
                -- Despawn if out of range to save performance
                if spawnedPeds[k] then
                    DeleteNpc(k)
                end
            end
        end

        Wait(sleep)
    end
end)

function Draw3DText(x, y, z, textInput, fontId, scaleX, scaleY, bar)
    SetTextScale(scaleX, scaleY)
    SetTextFont(fontId)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(textInput)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(textInput)) / (bar or 50)
    DrawRect(0.0, 0.0 + 0.0125, 0.017 + factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end

    for k in pairs(spawnedPeds) do
        DeleteNpc(k)
    end
end)
