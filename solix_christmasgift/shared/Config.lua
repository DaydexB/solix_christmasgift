Config = {}

Config.main = {
    
    item = 'giftbox',

    count = 1, -- Amount of Gifts Received When Purchaased

    price = 100000, 

    items = {
        {name = 'weapon_pistol', amount = 1},
        {name = 'money', amount = 50000},
        {name = 'bread', amount = 10},
        {name = 'water', amount = 10},
        {name = 'giftbox', amount = 1},
        {name = 'ammo-9', amount = 50},
    }
}

Config.cooldownTime = 24  -- cooldown (In hours) This Would Be 24 Hour Cooldown


Config.objects = {
    objectModel = 'xm_prop_x17_xmas_tree_int', -- You can add custom objecs or change it https://gta-objects.xyz/objects

    objectLocations = {
        ["grove-right"] = vec3(-51.8343, -1823.0934, 25.6524),

        ["grove-left"] = vec3(-42.4526, -1830.9727, 25.3),

        ["legion1"] = vec3(254.7853, -875.4111, 29.2922),

        ["legion2"] = vec3(186.2357, -850.3871, 30.1666),

        ["legion3"] = vec3(152.0403, -986.2818, 29.0919),

        ["legion4"] = vec3(170.5842, -993.3876, 29.0919),

        ["vehicleshop"] = vec3(-39.6763, -1118.4938, 25.4342)
    }
}

Config.notifications = {
    titleText = 'XMAS TREE', -- Success/other notifications

    backgroundColor = '#4abb4a',
    titleColor = '#ffffff',
    descriptionColor = '#ffffff',

    position = 'top-right',




    error = { -- Error notifications
        titleText = 'XMAS TREE',

        backgroundColor = '#e11313',
        titleColor = '#ffffff',
        descriptionColor = '#ffffff',

        position = 'top-right'
    }
}


Config.targetInfo = {
    label = 'Grab a Gift',
    icon = 'fa-solid fa-gift',
    iconColor = 'red'
}