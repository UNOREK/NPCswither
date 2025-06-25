local currentState = {
    peds = true,
    traffic = true
}

RegisterCommand('npcmenu', function()
    lib.registerContext({
        id = 'npctoggle_menu',
        title = 'Sterowanie światem AI',
        options = {
            {
                title = currentState.peds and '🚶‍♂️ NPC: WŁĄCZENI' or '🚫 NPC: WYŁĄCZENI',
                icon = 'users',
                onSelect = function()
                    TriggerServerEvent('npctoggle:updateWorldState', 'peds', not currentState.peds)
                end
            },
            {
                title = currentState.traffic and '🚗 Ruch uliczny: WŁĄCZONY' or '🚫 Ruch uliczny: WYŁĄCZONY',
                icon = 'car',
                onSelect = function()
                    TriggerServerEvent('npctoggle:updateWorldState', 'traffic', not currentState.traffic)
                end
            },
            {
                title = '❌ Zamknij menu',
                event = 'lib:closeContext'
            }
        }
    })

    lib.showContext('npctoggle_menu')
end)

RegisterNetEvent('npctoggle:applyState', function(state)
    currentState = state or currentState

    -- Powiadomienia na czacie
    TriggerEvent("chat:addMessage", {
        color = {255, 0, 0},
        args = {"SYSTEM", "Stan NPC: " .. (currentState.peds and "WŁĄCZENI" or "WYŁĄCZENI")}
    })

    TriggerEvent("chat:addMessage", {
        color = {255, 0, 0},
        args = {"SYSTEM", "Stan ruchu ulicznego: " .. (currentState.traffic and "WŁĄCZONY" or "WYŁĄCZONY")}
    })
end)

CreateThread(function()
    while true do
        Wait(0)

        -- NPC
        if not currentState.peds then
            SetPedDensityMultiplierThisFrame(0.0)
            SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0)
            SetCreateRandomCops(false)
            SetCreateRandomCopsNotOnScenarios(false)
            SetCreateRandomCopsOnScenarios(false)
        end

        -- Ruch uliczny
        if not currentState.traffic then
            SetVehicleDensityMultiplierThisFrame(0.0)
            SetRandomVehicleDensityMultiplierThisFrame(0.0)
            SetParkedVehicleDensityMultiplierThisFrame(0.0)
        end
    end
end)

-- Pobiera aktualny stan po dołączeniu gracza
TriggerServerEvent('npctoggle:syncRequest')