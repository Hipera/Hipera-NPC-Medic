local npcConfig = {
    model = "s_m_m_scientist_01",
    position = vector3(491.1627, -1456.7887, 28.2108),
    heading = 246.6824,
    options = {
        {
            name = "NPCmedic",
            label = "Npc medic",
            icon = "fa-solid fa-notes-medical",
            onSelect = function()
                Startprogbar()
            end
        }
    }
}

local function loadModel(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(10)
    end
end

local function spawnNPC()
    loadModel(npcConfig.model)

    local npc = CreatePed(4, npcConfig.model, npcConfig.position.x, npcConfig.position.y, npcConfig.position.z, npcConfig.heading, false, true)
    
    SetEntityInvincible(npc, true)
    FreezeEntityPosition(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)
    
    exports.ox_target:addLocalEntity(npc, npcConfig.options)
end

CreateThread(function()
    spawnNPC()
end)

function healplayer()

    lib.notify({
        title = "Medic",
        position = "center-right",
        description = "Byl si vyléčen",
        type = "success"
    })

    local playerPed = PlayerPedId()
    if DoesEntityExist(playerPed) then
        SetEntityHealth(playerPed, GetEntityMaxHealth(playerPed))
    end
end

function Startprogbar()
    lib.progressCircle({
        duration = 5000,
        label = 'Dotoktor tě léčí...',
        position = 'bottom',
        useWhileDead = false,
        canCancel = false,
        disable = {
            car = true,
            move = true,
            mouse = true
        },
    })

    healplayer()
end

CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        local isOnBike = IsPedOnAnyBike(playerPed)

        if isOnBike then
            DisableControlAction(0, 345, true)
        end
        
        Wait(0)
    end
end)


