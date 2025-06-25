local worldState = {
    peds = true,
    traffic = true
}

RegisterNetEvent('npctoggle:updateWorldState', function(type, value)
    if worldState[type] == nil then return end
    worldState[type] = value
    TriggerClientEvent('npctoggle:applyState', -1, worldState)
    print('[NPCtoggle] Ustawiono ' .. type .. ' = ' .. tostring(value))
end)

RegisterCommand("npctoggle", function(source)
    TriggerClientEvent('npctoggle:applyState', source, worldState)
end, false)