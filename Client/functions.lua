createdProp = nil
function ChangeRadioChannel(channel)
    if channel == 0 then
        exports[Config.VoiceScript]:setRadioChannel(0)
    else
        exports[Config.VoiceScript]:setRadioChannel(channel)
    end
end

function openUI()
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "open"
    })
end

function showNoty(title, text, type)
    if not text then return end
    if not title then title = 'Notification' end
    if not type then type = 'inform' end
    lib.notify({
        title = title,
        description = text,
        type = type,
        duration = 3500,
        position = 'center-right'
    })
end


function newRadioProp(prop)
    deleteRadio()
    local ped = PlayerPedId()

    createdProp = CreateObject(Config.Prop, 1.0, 1.0, 1.0, 1, 1, 0)
    local bone = GetPedBoneIndex(ped, prop.bone)
    AttachEntityToEntity(createdProp, ped, bone, prop.offset, prop.rot, 1, 1, 0, 0, 2, 1)
end

function deleteRadio()
    if createdProp then
        DeleteEntity(createdProp)
        createdProp = nil
    end
end

function playAnim(animData)
    local ped = PlayerPedId()
    RequestAnimDict(animData.dict)
    while not HasAnimDictLoaded(animData.dict) do
        Wait(10)
    end
    newRadioProp(animData.prop)
    TaskPlayAnim(ped, animData.dict, animData.anim, 8.0, 2.0, -1, 50, 2.0, 0, 0, 0)
end