Citizen.CreateThread(function()
	for k,v in pairs(Config.Npc) do
		if Config.Npc ~= nil then 
			local x,y,z = table.unpack(v.coords)

			lib.requestModel(v.NPC.Model)

			local playerPed = CreatePed(4, v.NPC.Model, x, y, z - 1.0, v.NPC.heading, false, true)

			FreezeEntityPosition(playerPed, true)
			SetEntityInvincible(playerPed, true)
			SetBlockingOfNonTemporaryEvents(playerPed, true)
			

			if v.NPC.UseSecnario then
				TaskStartScenarioInPlace(playerPed, v.NPC.Secnario, 0, false)
			else
				lib.requestAnimDict(v.NPC.AnimationDirect)
				TaskPlayAnim(playerPed, v.NPC.AnimationDirect, v.NPC.AnimationScene, 8.0, -8.0, -1, 0, 0, false, false, false)	
			end

	
			SetPedHeadBlendData			(playerPed, v.NPC.Cloth.face1, v.NPC.Cloth.face1, v.NPC.Cloth.face1, v.NPC.Cloth.skin, v.NPC.Cloth.skin, v.NPC.Cloth.skin, 1.0, 1.0, 1.0, true)
			SetPedEyeColor				(playerPed,			v.NPC.Cloth.eye_color, 0, 1)												-- Eyes color
			SetPedComponentVariation	(playerPed, 2,		v.NPC.Cloth.hair_1,			v.NPC.Cloth.hair_2, 2)						-- Hair
			SetPedHairColor				(playerPed,			v.NPC.Cloth.hair_color_1,		v.NPC.Cloth.hair_color_2)				-- Hair Color
			SetPedComponentVariation    (playerPed, 11,        v.NPC.Cloth.torso_1,            v.NPC.Cloth.torso_2, 2)                    -- torso parts
			SetPedComponentVariation    (playerPed, 8,        v.NPC.Cloth.tshirt_1,            v.NPC.Cloth.tshirt_2, 2)					-- Tshirt
			SetPedComponentVariation	(playerPed, 3,		v.NPC.Cloth.arms,				v.NPC.Cloth.arms_2, 2)						-- Amrs
			SetPedComponentVariation	(playerPed, 4,		v.NPC.Cloth.pants_1,			v.NPC.Cloth.pants_2, 2)					-- pants
			SetPedComponentVariation	(playerPed, 6,		v.NPC.Cloth.shoes_1,			v.NPC.Cloth.shoes_2, 2)					-- shoes
			SetPedComponentVariation	(playerPed, 10,		v.NPC.Cloth.decals_1,			v.NPC.Cloth.decals_2, 2)					-- decals
			SetPedComponentVariation	(playerPed, 1,		v.NPC.Cloth.mask_1,			v.NPC.Cloth.mask_2, 2)				
			SetPedComponentVariation	(playerPed, 9,		v.NPC.Cloth.bproof_1,			v.NPC.Cloth.bproof_2, 2)			
			SetPedComponentVariation	(playerPed, 7,		v.NPC.Cloth.chain_1,			v.NPC.Cloth.chain_2, 2)				
			SetPedComponentVariation	(playerPed, 5,		v.NPC.Cloth.bags_1,			v.NPC.Cloth.bags_2, 2)
			SetPedPropIndex			(playerPed, 2,		v.NPC.Cloth.ears_1,			v.NPC.Cloth.ears_2, 2)						-- Ears Accessories					
			SetPedPropIndex			(playerPed, 0,		v.NPC.Cloth.helmet_1,			v.NPC.Cloth.helmet_2, 2)			
			SetPedPropIndex			(playerPed, 1,		v.NPC.Cloth.glasses_1,			v.NPC.Cloth.glasses_2, 2)			
			SetPedPropIndex			(playerPed, 6,		v.NPC.Cloth.watches_1,			v.NPC.Cloth.watches_2, 2)				
			SetPedPropIndex			(playerPed, 7,		v.NPC.Cloth.bracelets_1,		v.NPC.Cloth.bracelets_2)			
			SetPedHeadOverlay			(playerPed, 1,		v.NPC.Cloth.beard_1,			(v.NPC.Cloth.beard_2 / 10) + 0.0)	
			SetPedHeadOverlayColor		(playerPed, 1, 1,	v.NPC.Cloth.beard_3,			v.NPC.Cloth.beard_4)						-- Beard Color
			SetPedHeadOverlay			(playerPed, 2,		v.NPC.Cloth.eyebrow_type,		(v.NPC.Cloth.eyebrow_size / 10) + 0.0)		-- Eyebrows + opacity
			SetPedHeadOverlayColor		(playerPed, 2, 1,	v.NPC.Cloth.eyebrow_color_1,		v.NPC.Cloth.eyebrow_color_2)					-- Eyebrows Color
			SetPedHeadOverlay			(playerPed, 4,		v.NPC.Cloth.makeup_type,			(v.NPC.Cloth.makeup_thickness / 10) + 0.0)			-- Makeup + opacity
			SetPedHeadOverlay			(playerPed, 8,		v.NPC.Cloth.lipstick_type,		(v.NPC.Cloth.lipstick_thickness / 10) + 0.0)		-- Lipstick + opacity
			SetPedHeadOverlay			(playerPed, 5,		v.NPC.Cloth.blush,			(v.NPC.Cloth.blush_1 / 10) + 0.0)			-- Blush + opacity
			SetPedHeadOverlay			(playerPed, 6,		v.NPC.Cloth.complexion,		(v.NPC.Cloth.complexion_1 / 10) + 0.0)		-- Complexion + opacity
			SetPedHeadOverlay			(playerPed, 7,		v.NPC.Cloth.sun,				(v.NPC.Cloth.sun_1 / 10) + 0.0)			-- Sun Damage + opacity
			SetPedHeadOverlay			(playerPed, 9,		v.NPC.Cloth.freckles,			(v.NPC.Cloth.freckles_1 / 10) + 0.0)			-- Moles/Freckles + opacity
			SetPedHeadOverlay			(playerPed, 10,		v.NPC.Cloth.chest_hair,			(v.NPC.Cloth.chest_hair_1 / 10) + 0.0)			-- Chest Hair + opacity
			SetPedHeadOverlay			(playerPed, 11,		v.NPC.Cloth.bodyb,			(v.NPC.Cloth.bodyb_size / 10) + 0.0)			-- Body Blemishes + opacity
			SetPedHeadOverlayColor		(playerPed, 10, 1,	v.NPC.Cloth.chest_color)														-- Torso Color
			SetPedHeadOverlayColor		(playerPed, 4, 1,	v.NPC.Cloth.makeup_color_1,			v.NPC.Cloth.makeup_color_2)						-- Makeup Color
			SetPedHeadOverlayColor		(playerPed, 5, 2,	v.NPC.Cloth.blush_color)														-- Blush Color
			SetPedHeadOverlayColor		(playerPed, 8, 1,	v.NPC.Cloth.lipstick_color_1,		v.NPC.Cloth.lipstick_color_2)					-- Lipstick Color
			ApplyPedOverlay             (playerPed, GetHashKey(v.NPC.collection), GetHashKey(v.NPC.nameHash))
		end
	end
end)


Citizen.CreateThread(function()
	while true do
		Wait(0)
		for _, v in pairs(Config.Npc) do
			local ped = PlayerPedId()
			local pedcoords = GetEntityCoords(ped)
			local distance = #(vector3(v.coords.x, v.coords.y, v.coords.z) - vector3(pedcoords.x, pedcoords.y, pedcoords.z))
			if distance <= Config.Distance then
				Draw3DText(v.coords.x, v.coords.y, v.coords.z + 1, v.NPC.Text, v.NPC.Font, v.NPC.ScaleX, v.NPC.ScaleY, v.NPC.Bar)		
			end
		end
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
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(textInput)) / bar
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end