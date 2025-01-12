local xmasTreeObj = GetHashKey(Config.objects.objectModel)

function loadXmasTree(xmasTreeObj)
if not HasModelLoaded(xmasTreeObj) then 
    RequestModel(xmasTreeObj)
    while not HasModelLoaded(xmasTreeObj) do
        Wait(1)
        end
    end
end

function addTarget(networkId, options)
    exports.ox_target:addEntity(networkId, options)
end

RegisterNetEvent('solix_christmasgift:pickupanim', function(source)
    local playerPed = PlayerPedId()
    local playerDict = "anim@heists@load_box" 
    local playerAnim = "lift_box"
    RequestAnimDict(playerDict)

  while not HasAnimDictLoaded(playerDict) do
      Wait(100)
  end
  lib.progressCircle({
    label = 'Grabbing Gift',
    duration = 2500,
    position = 'bottom',
    useWhileDead = false,
    canCancel = false,
    disable = {
        car = true,
        move = true,
        combat = true,
    },
    anim = {
        dict = 'anim@heists@load_box',
        clip = 'lift_box'
    },
})
end
)

RegisterNetEvent('solix_christmasgift:unwrapanim', function(source)
    local playerPed = PlayerPedId()
    local playerDict = "missmic4" 
    local playerAnim = "michael_tux_fidget"
    RequestAnimDict(playerDict)

  while not HasAnimDictLoaded(playerDict) do
      Wait(100)
  end
  lib.progressCircle({
    label = 'Unwrapping Gift',
    duration = 2500,
    position = 'bottom',
    useWhileDead = false,
    canCancel = true,
    disable = {
        car = true,
    },
    anim = {
        dict = 'missmic4',
        clip = 'michael_tux_fidget'
    },
    prop = {
        model = `bzzz_xmas23_convert_tree_gift`,
        pos = vec3(0.01, 0.01, 0.01),
        rot = vec3(0.0, -100.0, -100.5)
    },
})
end
)


for k,v in pairs(Config.objects.objectLocations) do
loadXmasTree(xmasTreeObj)
if IsModelValid(xmasTreeObj) then

        local objectCreate = CreateObject(xmasTreeObj, v.x, v.y, v.z, true, false, false)

        FreezeEntityPosition(objectCreate, true)

        local options = {
            label = Config.targetInfo.label,
            icon = Config.targetInfo.icon,
            iconColor = Config.targetInfo.iconColor,
            onSelect = function()
                TriggerServerEvent("solix_christmasgift:transaction")
            end
        }

        local netIds = NetworkGetNetworkIdFromEntity(objectCreate)

        addTarget(netIds, options)
    else
        print("^1 Model Is Not Valid")
    end
end