Config = {}

Config.VoiceScript = 'pma-voice' -- pma-voice or mumble-voip
Config.KeyMapping = {
    command = 'openradio',
    key = 'F11',
    description = 'Open the radio',
}

Config.Prop = 'prop_cs_hand_radio' -- Prop name

Config.RadioAnimations = {
    ['Radio'] = {
        dict = 'random@arrests',
        anim = 'generic_radio_chatter',
        prop = {
            offset = vec3(0.06, 0.05, 0.04),
            rot = vec3(90.0, 520.0, 0.0),
            bone = 60309
        }
    },
    ['Phone'] = {
        dict = 'cellphone@str',
        anim = 'cellphone_call_listen_a',
        prop = {
            offset = vec3(-0.01, -0.01, 0.02),
            rot = vec3(0.0, 0.0, 0.0),
            bone = 28422
        }
    },
    -- You can add more here
}