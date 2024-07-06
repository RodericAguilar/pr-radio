AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
      return
    end
    deleteRadio()
    exports[Config.VoiceScript]:setRadioChannel(0)
end)

AddEventHandler("pma-voice:radioActive", function(radioTalking) 
  --  print(radioTalking)
    if radioTalking then
        local currentAnimSaved = GetResourceKvpString("pr-radio:animation") 
        if not currentAnimSaved then
            currentAnimSaved = 'Radio'
        end
        local animInfo = Config.RadioAnimations[currentAnimSaved]
        playAnim(animInfo)
        SendNUIMessage({tipo = 'on', action = 'play_sound', sound = "audio_on", volume = 0.3})
    else
        deleteRadio()
        ClearPedTasks(PlayerPedId())
        SendNUIMessage({tipo = 'off', action = 'play_sound', sound = "audio_off", volume = 0.5})
    end
end)