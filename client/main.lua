local isHoldingObject = false
local currentObject = nil


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if isHoldingObject then
			DisableControlAction(0, 24, true) 
			DisableControlAction(0, 257, true) 
			DisableControlAction(0, 25, true) 
			DisableControlAction(0, 263, true) 
			DisableControlAction(0, 237, true)
		
			DisableControlAction(0, 20, true) 
			DisableControlAction(0, 48, true) 

			DisableControlAction(0, 22, true) 
			DisableControlAction(0, 44, true) 

		else
			Citizen.Wait(1000)
		end
	end


end)

-- Check if the animation is playing
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        if isHoldingObject then

            if not IsEntityPlayingAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 3) then
                TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 8.0, 8.0, -1, 50, 0, false, false, false)
            end

        else
            Citizen.Wait(1000)
        end
    end
end)



RegisterNetEvent('nagodo-moveobjects:TryToMoveObject', function(data)
    local playerPed = PlayerPedId()
    local pCoords = GetEntityCoords(playerPed)
    for k, v in pairs(Config.Models) do
        
        local obj_hash = GetHashKey(v)

        local object = GetClosestObjectOfType(pCoords, 2.0, obj_hash, false, true, true)

        local obj_coords = GetEntityCoords(object)
        local dist = #(pCoords - obj_coords)

        if dist <= Config.Reach and object == data.entity then
            if not IsPedInAnyVehicle(PlayerPedId(), false) then
                
                GrabObject(object, obj_hash)
            end
            break
        end
    end 
end)

function InteractKeyPressed()

    if isHoldingObject then 
        ReleaseObject()
        return 
    end

    local playerPed = PlayerPedId()
    local pCoords = GetEntityCoords(playerPed)

    for k, v in pairs(Config.Models) do
        
        local obj_hash = GetHashKey(v)

        local object = GetClosestObjectOfType(pCoords, 2.0, obj_hash, false, true, true)

        local obj_coords = GetEntityCoords(object)
        local dist = #(pCoords - obj_coords)

        if dist <= Config.Reach then
            if not IsPedInAnyVehicle(PlayerPedId(), false) then            
                GrabObject(object, obj_hash)
            end
            break
        end
    end 
end

function GrabObject(object, model_hash)
    LoadAnim("anim@heists@box_carry@")
    TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 8.0, 8.0, -1, 50, 0, false, false, false)
    isHoldingObject = true


    local obj_coords = GetEntityCoords(object)
    TriggerServerEvent('nagodo-moveobjects:deleteentity', obj_coords, model_hash)

    local obj = CreateObject(model_hash, obj_coords, true, true, true)

    currentObject = obj
    AttachEntityToEntity(obj, PlayerPedId(), GetEntityBoneIndexByName(PlayerPedId(), "SKEL_L_Forearm"), -0.05, 0.5, -0.3, 0.0, 0.0, 180.0, false, false, false, false, 2, true)
    
end

RegisterNetEvent('nagodo-moveobjects:deleteentity' , function(coords, model)

    local obj = GetClosestObjectOfType(coords, 2.0, model, false, true, true)
    SetEntityAsMissionEntity(obj, true, true)
    DeleteEntity(obj)
    SetObjectAsNoLongerNeeded(obj)
end)

function ReleaseObject()
    isHoldingObject = false
    DetachEntity(currentObject, false, false)
    PlaceObjectOnGroundProperly(currentObject)
    ClearPedTasks(PlayerPedId())
end

function LoadAnim(animDict)
	RequestAnimDict(animDict)

	while not HasAnimDictLoaded(animDict) do
		Citizen.Wait(10)
	end
end