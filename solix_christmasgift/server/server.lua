RegisterNetEvent('solix_christmasgift:transaction', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerMoney = xPlayer.getMoney()
    local playerId = source
    local identifier = GetPlayerIdentifierByType(playerId, 'license')

    local date = os.date("%Y-%m-%d %H:%M:%S", os.time())
    local canCarry = exports.ox_inventory:CanCarryItem(source, Config.main.item, Config.main.count)


    local query = "SELECT TIMESTAMPDIFF(SECOND, cooldown, NOW()) AS seconds_diff FROM christmasgift_cooldown WHERE identifier = ?"
    MySQL.scalar(query, {identifier}, function(result)
        if result == nil then
            if canCarry and playerMoney >= Config.main.price then

                MySQL.insert('INSERT INTO christmasgift_cooldown (identifier, cooldown) VALUES (?, ?)', {
                    identifier,
                    date
                })

                exports.ox_inventory:RemoveItem(playerId, 'money', Config.main.price)
                exports.ox_inventory:AddItem(playerId, Config.main.item, Config.main.count)

                lib.notify(playerId, {
                    title = Config.notifications.titleText,
                    position = Config.notifications.position,
                    description = 'You Collected Your Gift',
                    type = 'info',
                    style = {
                        color = Config.notifications.titleColor,
                        backgroundColor = Config.notifications.backgroundColor,
                        ['.description'] = {
                            color = Config.notifications.descriptionColor
                        },
                    }
                })
                TriggerClientEvent('solix_christmasgift:pickupanim', playerId)
            elseif playerMoney < Config.main.price then 
                lib.notify(playerId, {
                    title = Config.notifications.error.titleText,
                    position = Config.notifications.error.position,
                    description = 'You are missing $'..Config.main.price - playerMoney,
                    type = 'error',
                    style = {
                        color = Config.notifications.error.titleColor,
                        backgroundColor = Config.notifications.error.backgroundColor,
                        ['.description'] = {
                            color = Config.notifications.error.descriptionColor
                        },
                    }
                })
            elseif canCarry == false then
                lib.notify(playerId, {
                    title = Config.notifications.error.titleText,
                    position = Config.notifications.error.position,
                    description = 'You Cannot Carry This Item',
                    type = 'error',
                    style = {
                        color = Config.notifications.error.titleColor,
                        backgroundColor = Config.notifications.error.backgroundColor,
                        ['.description'] = {
                            color = Config.notifications.error.descriptionColor
                        },
                    }
                })
            end
        else
            local remaining_seconds = (Config.cooldownTime * 3600) - result 
            if remaining_seconds > 0 then
                local hours = math.floor(remaining_seconds / 3600)
                local minutes = math.floor((remaining_seconds % 3600) / 60)
                local seconds = remaining_seconds % 60

                lib.notify(playerId, {
                    title = Config.notifications.error.titleText,
                    position = Config.notifications.error.position,
                    description = string.format('You are on cooldown. Please wait %02d hours, %02d minutes, %02d seconds more.', hours, minutes, seconds),
                    type = 'error',
                    style = {
                        color = Config.notifications.error.titleColor,
                        backgroundColor = Config.notifications.error.backgroundColor,
                        ['.description'] = {
                            color = Config.notifications.error.descriptionColor
                        },
                    }
                })
            else
                if canCarry and playerMoney >= Config.main.price then
                    MySQL.insert('INSERT INTO christmasgift_cooldown (identifier, cooldown) VALUES (?, ?) ON DUPLICATE KEY UPDATE cooldown = ?', {
                        identifier,
                        date,
                        date
                    })

                    exports.ox_inventory:RemoveItem(playerId, 'money', Config.main.price)
                    exports.ox_inventory:AddItem(playerId, Config.main.item, Config.main.count)

                    lib.notify(playerId, {
                        title = Config.notifications.titleText,
                        position = Config.notifications.position,
                        description = 'You Collected Your Gift',
                        type = 'info',
                        style = {
                            color = Config.notifications.titleColor,
                            backgroundColor = Config.notifications.backgroundColor,
                            ['.description'] = {
                                color = Config.notifications.descriptionColor
                            },
                        }
                    })
                    TriggerClientEvent('solix_christmasgift:pickupanim', playerId)
                elseif playerMoney < Config.main.price then 
                    lib.notify(playerId, {
                        title = Config.notifications.error.titleText,
                        position = Config.notifications.error.position,
                        description = 'You are missing $'..Config.main.price - playerMoney,
                        type = 'error',
                        style = {
                            color = Config.notifications.error.titleColor,
                            backgroundColor = Config.notifications.error.backgroundColor,
                            ['.description'] = {
                                color = Config.notifications.error.descriptionColor
                            },
                        }
                    })
                else
                    lib.notify(playerId, {
                        title = Config.notifications.error.titleText,
                        position = Config.notifications.error.position,
                        description = 'You Cannot Carry This Item',
                        type = 'error',
                        style = {
                            color = Config.notifications.error.titleColor,
                            backgroundColor = Config.notifications.error.backgroundColor,
                            ['.description'] = {
                                color = Config.notifications.error.descriptionColor
                            },
                        }
                    })
                end
            end
        end
    end)
end)


ESX.RegisterUsableItem('giftbox', function(source)
    local randomIndex = math.random(1, #Config.main.items)
    local item = Config.main.items[randomIndex].name
    local amount = Config.main.items[randomIndex].amount
    
    if exports.ox_inventory:CanCarryItem(source, item, amount) then
        TriggerClientEvent('solix_christmasgift:unwrapanim', source)

        exports.ox_inventory:RemoveItem(source, Config.main.item, 1)
        Wait(2800)

        exports.ox_inventory:AddItem(source, item, amount)
    else
        lib.notify(source, {
            title = Config.notifications.error.titleText,
            position = Config.notifications.error.position,
            description = 'You Cannot Carry This Item',
            type = 'error',
            style = {
                color = Config.notifications.error.titleColor,
                backgroundColor = Config.notifications.error.backgroundColor,
                ['.description'] = {
                    color = Config.notifications.error.descriptionColor
                },
            }
        })
    end
end)