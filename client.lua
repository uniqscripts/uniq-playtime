-- https://github.com/esx-framework/esx_ambulancejob/blob/main/client/main.lua#L200

local function secondsToClock(seconds)
    local seconds, hours, mins, secs = tonumber(seconds), 0, 0, 0
  
    if seconds <= 0 then
      return 0, 0
    else
      local hours = string.format('%02.f', math.floor(seconds / 3600))
      local mins = string.format('%02.f', math.floor(seconds / 60 - (hours * 60)))
      local secs = string.format('%02.f', math.floor(seconds - hours * 3600 - mins * 60))
  
      return mins, secs
    end
end
  

RegisterNetEvent('uniq-playtime:mytime', function(time)
    local alert = lib.alertDialog({
        header = 'Your Play Time',
        content = ('You played on this server for %s minutes and %s seconds'):format(secondsToClock(time)),
        centered = true,
        cancel = true
    })
end)

local menu = {
    id = 'uniq_playtime',
    options = {}
}

RegisterNetEvent('uniq-playtime:list', function(list)
    menu.title = ('Registered Players: %s'):format(#list)

    table.sort(list, function(a, b)
        return a.playtime > b.playtime
    end)

    for i = 1, #list do
        local data = list[i]
        menu.options[i] = {
            title = data.name,
            description = ('Played on server for %s minutes and %s seconds'):format(secondsToClock(data.playtime)),
        }
    end

    lib.registerContext(menu)
    lib.showContext(menu.id)
end)