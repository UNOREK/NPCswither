local currentState = {
    peds = true,
    traffic = true
}

function openNpcMenu()
    lib.registerContext({
        id = 'npctoggle_menu',
        title = 'Sterowanie NPC',
        options = {
            {
                title = 'Piesi: ' .. (currentState.peds and '🟢 Włączone' or '🔴 Wyłączone'),
                icon = 'users',
                onSelect = function()
                    TriggerServerEvent('npctoggle:updateWorldState', 'peds', not currentState.peds)
                    Wait(100)
                    openNpcMenu()
                end
            },
            {
                title = 'Ruch uliczny: ' .. (currentState.traffic and '🟢 Włączony' or '🔴 Wyłączony'),
                icon = 'car',
                onSelect = function()
                    TriggerServerEvent('npctoggle:updateWorldState', 'traffic', not currentState.traffic)
                    Wait(100)
                    openNpcMenu()
                end
            },
            {
                title = 'Zamknij panel',
                icon = 'xmark',
                event = 'lib:closeContext'
            }
        }
    })

    lib.showContext('npctoggle_menu')
end

RegisterCommand('npcmenu', function()
    openNpcMenu()
end)

RegisterNetEvent('npctoggle:applyState', function(state)
    currentState = state or currentState

    TriggerEvent("chat:addMessage", {
        color = {255, 0, 0},
        args = {"SYSTEM", "Stan pieszych: " .. (currentState.peds and "WŁĄCZENI" or "WYŁĄCZENI")}
    })

    TriggerEvent("chat:addMessage", {
        color = {255, 0, 0},
        args = {"SYSTEM", "Stan ruchu ulicznego: " .. (currentState.traffic and "WŁĄCZONY" or "WYŁĄCZONY")}
    })
end)

CreateThread(function()
    while true do
        Wait(0)

        if not currentState.peds then
            SetPedDensityMultiplierThisFrame(0.0)
            SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0)
            SetCreateRandomCops(false)
            SetCreateRandomCopsNotOnScenarios(false)
            SetCreateRandomCopsOnScenarios(false)
        end

        if not currentState.traffic then
            SetVehicleDensityMultiplierThisFrame(0.0)
            SetRandomVehicleDensityMultiplierThisFrame(0.0)
            SetParkedVehicleDensityMultiplierThisFrame(0.0)
        end
    end
end)

TriggerServerEvent('npctoggle:syncRequest')
