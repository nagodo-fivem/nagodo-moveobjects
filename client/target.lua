Citizen.CreateThread(function()
    if Config.UsingTarget then

        if Config.TargetType == 'qb-target' then
            -- IS USING QB-TARGET --
            exports['qb-target']:AddTargetModel(Config.Models, {
                options = {
                    {
                        event = "nagodo-moveobjects:TryToMoveObject",
                        icon = "fas fa-hands",
                        label = Config.Translations['target_label'],
                    },
                },
                distance = 2.5,
            })

        elseif Config.TargetType == 'ox_target' then
            -- IS USING OX_TARGET --
            exports.ox_target:addModel(Config.Models, {
                {
                    event = "nagodo-moveobjects:TryToMoveObject",
                    icon = "fas fa-hands",
                    label = Config.Translations['target_label'],
    
                    distance = 2.5,
                }


            })
        end
    end
end)

