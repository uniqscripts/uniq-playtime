local cfg = Shared
local Locales = cfg.Locales

-- https://github.com/esx-framework/esx_ambulancejob/blob/main/client/main.lua#L200
local function secondsToClock(seconds)
    local seconds, days, hours, mins, secs = tonumber(seconds), 0, 0, 0, 0
  
    if seconds <= 0 then
      return 0, 0, 0, 0
    else
        local days = math.floor(seconds / 86400)
        local hours = math.floor(seconds / 3600) % 24
        local mins = math.floor(seconds / 60) % 60
        local secs = seconds % 60

        return days, hours, mins, secs
    end
end
  

RegisterNetEvent('uniq-playtime:mytime', function(time)
    local alert = lib.alertDialog({
        header = Locales[3],
        content = Locales[1]:format(secondsToClock(time)),
        centered = true,
        cancel = true
    })
end)

local menu = {
    id = 'uniq_playtime',
    options = {}
}

RegisterNetEvent('uniq-playtime:list', function(list)
    menu.options = {}
    menu.title = Locales[5]:format(cfg.topList)
    local count = 0

    for i = 1, #list do
        local data = list[i]

        menu.options[i] = {
            title = data.name,
            description = Locales[2]:format(secondsToClock(data.playtime)),
            time = data.playtime
        }
        count += 1

        if count == cfg.topList then
            break
        end
    end

    table.sort(menu.options, function(a, b)
        return a.time > b.time
    end)

    lib.registerContext(menu)
    lib.showContext(menu.id)
end)


RegisterNetEvent('uniq-playtime:mySessionTime', function(time)
    local alert = lib.alertDialog({
        header = Locales[3],
        content = Locales[6]:format(secondsToClock(time)),
        centered = true,
        cancel = true
    })
end)

RegisterNetEvent('uniq-playtime:sessionlist', function(list)
    local options = {}
    local count = 0

    for k,v in pairs(list) do
        options[#options + 1] = {
            title = v.name,
            time = v.time,
            description = Locales[2]:format(secondsToClock(v.time)),
        }

        if count == cfg.topList then
            break
        end
    end

    table.sort(options, function(a, b)
        return a.time > b.time
    end)

    lib.registerContext({
        id = 'uniq_playtime_session_all',
        title = Locales[5]:format(cfg.topList),
        options = options
    })

    lib.showContext('uniq_playtime_session_all')
end)
