
RegisterServerEvent('nagodo-moveobjects:deleteentity' , function(coords, model_name)
    TriggerClientEvent('nagodo-moveobjects:deleteentity', -1, coords, model_name)
end)