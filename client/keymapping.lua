Citizen.CreateThread(function()

    if not Config.UsingTarget then
        -- IS NOT USING TARGET --
        RegisterCommand('+interactobject', function()
            InteractKeyPressed()
        end, false)

        RegisterKeyMapping('+interactobject', Config.Translations['keymapping01'], 'keyboard', 'E')

    
    else
        -- IS USING TARGET --
        RegisterCommand('-releaseobject', function()
            ReleaseObject()
        end, false)
        
        RegisterKeyMapping('-releaseobject', Config.Translations['keymapping02'], 'keyboard', 'E')

    end


end)

