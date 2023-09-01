local Props = {}

CreateThread(function()
    for k,v in pairs(Config.Objects) do

        local Hash = Config.Objects[k].Model

        RequestModel(Hash)
        while not HasModelLoaded(Hash) do 
            Wait(10) 
        end

        local object = CreateObject(Hash, Config.Objects[k].Coords.xy, Config.Objects[k].Coords.z - 1, true, false, false)
        SetEntityHeading(object, Config.Objects[k].Coords.w)
        FreezeEntityPosition(object, Config.Objects[k].FreezeObj)
        Props[k] = {
            Obj = object
        }
    end
end)

AddEventHandler('onResourceStop', function()
    for k,v in pairs(Props) do
        NetworkRequestControlOfEntity(Props[k].Obj)
        DeleteObject(Props[k].Obj)
        Props[k] = nil
    end
end)