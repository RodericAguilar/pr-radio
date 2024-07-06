local keybind = lib.addKeybind({
    name = Config.KeyMapping.command,
    description = Config.KeyMapping.description,
    defaultKey = Config.KeyMapping.key,
    onPressed = function(self)
       -- print(('pressed %s (%s)'):format(self.currentKey, self.name))
        openUI()
    end
})

RegisterNUICallback('exit', function(data, cb)
    SetNuiFocus(false, false)
end)

RegisterNUICallback('error', function(data, cb)
    local error = data.error
    showNoty('PR Radio', error, 'error')
    cb(0)
end)

RegisterNUICallback('connect', function(data, cb)
    local channel = tonumber(data.channel)
    if not channel then 
        return 
    end
    ChangeRadioChannel(channel)
    cb(1)
end)

RegisterNUICallback('volume', function(data, cb)
    local volume = tonumber(data.volume)
    exports[Config.VoiceScript]:setRadioVolume(volume)
    cb(1)
end)

RegisterNUICallback('getAnimations', function(data, cb)
    for k,v in pairs(Config.RadioAnimations) do
        SendNUIMessage({
            action = 'addAnimation',
            label = k,
        })
    end
    cb(1)
end)

RegisterNUICallback('saveAnimation', function(data, cb)
    local animation = data.animation
    if not Config.RadioAnimations[animation] then
        showNoty('PR Radio', 'Invalid animation', 'error')
        return
    end
    SetResourceKvp('pr-radio:animation', animation)
    cb(1)
end)

RegisterNUICallback('saveSound', function(data, cb)
    local tipo = data.tipo
    if tipo == 'inicial' then 
        SetResourceKvp('pr-radio:sound:inicial', data.sound)
    elseif tipo == 'final' then
        SetResourceKvp('pr-radio:sound:final', data.sound)
    end
end)