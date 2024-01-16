
function ~/10t:
    unless block ~ ~ ~ brewing_stand return run kill

    if function ~/../can_concoctionate return run function ./tick/start_brewing

    tag @s remove psconco.tick


function ~/1t:
    scoreboard players remove @s psconco.time 1
    if entity @a[distance=..8,limit=1] store result block ~ ~ ~ BrewTime short 1 scoreboard players get @s psconco.time
    if score @s psconco.time matches ..0 function ~/../finish_brewing


function ~/can_concoctionate:
    if score .requires_fuel psconco matches 1 if data block ~ ~ ~ {Fuel:0b} return 0

    data modify storage psconco:temp Items set from block ~ ~ ~ Items

    unless data storage psconco:temp Items[{Slot:3b,id:"minecraft:phantom_membrane"}] return 0
    if data storage psconco:temp Items[{id:"minecraft:potion",tag:{Potion:"minecraft:awkward"}}] return 0
    if score .can_concoctionate_concoctions psconco matches 0 if data storage psconco:temp Items[{id:"minecraft:potion",tag:{psconco_concoction:1b}}] return 0

    scoreboard players set .bool psconco 0
    if data storage psconco:temp {Items:[{Slot:0b},{Slot:1b}]} scoreboard players set .bool psconco 1
    if data storage psconco:temp {Items:[{Slot:0b},{Slot:2b}]} scoreboard players set .bool psconco 1
    if data storage psconco:temp {Items:[{Slot:1b},{Slot:2b}]} scoreboard players set .bool psconco 1
    if score .bool psconco matches 0 return 0

    if data storage psconco:temp Items[{id:"minecraft:potion"}] if function ./is_only/potion return 1
    if data storage psconco:temp Items[{id:"minecraft:splash_potion"}] if function ./is_only/splash_potion return 1

    return 0


function ~/start_brewing:
    if entity @s[tag=psconco.tick] return 1
    tag @s add psconco.tick

    scoreboard players operation @s psconco.time = .concoction_brew_time psconco
    if score .requires_fuel psconco matches 1 store result block ~ ~ ~ Fuel byte 1 data get block ~ ~ ~ Fuel 0.99999999999


function ~/finish_brewing:
    tag @s remove psconco.tick

    unless function ~/../can_concoctionate return 0

    data remove storage psconco:temp potion

    for kind in ["potion","splash_potion"]:
        if data storage psconco:temp Items[{id:f"minecraft:{kind}"}] if function f"psconco:is_only/{kind}" function f"psconco:tick/finish_brewing/{kind}":
            if kind == "potion":
                name = "Concoction"
            else:
                name = "Splash Concoction"

            data modify storage psconco:temp potion set value {
                id: f"minecraft:{kind}",
                Count: 1b,
                Slot:1b,
                tag: {
                    display: {Name: f'{{"text":"{name}","color":"yellow","italic":false}}', Lore: ['{"text":"Concoction","color":"blue","italic":false}']},
                    CustomPotionColor: 16772608,
                    custom_potion_effects: [],
                    psconco_concoction:1b,
                }
            }
            if data storage psconco:temp Items[{Slot:0b,id:f"minecraft:{kind}"}].tag.custom_potion_effects[0] function ~/../slot_0
            if data storage psconco:temp Items[{Slot:1b,id:f"minecraft:{kind}"}].tag.custom_potion_effects[0] function ~/../slot_1
            if data storage psconco:temp Items[{Slot:2b,id:f"minecraft:{kind}"}].tag.custom_potion_effects[0] function ~/../slot_2

            if data storage psconco:temp Items[{Slot:0b,id:f"minecraft:{kind}"}].tag.Potion function ~/../lookup with storage psconco:temp Items[{Slot:0b}].tag
            if data storage psconco:temp Items[{Slot:1b,id:f"minecraft:{kind}"}].tag.Potion function ~/../lookup with storage psconco:temp Items[{Slot:1b}].tag
            if data storage psconco:temp Items[{Slot:2b,id:f"minecraft:{kind}"}].tag.Potion function ~/../lookup with storage psconco:temp Items[{Slot:2b}].tag
    
            if data storage psconco:temp {Items:[{Slot:0b,id:f"minecraft:{kind}",tag:{Potion:"minecraft:turtle_master"}}]} function ~/../turtle_master
            if data storage psconco:temp {Items:[{Slot:1b,id:f"minecraft:{kind}",tag:{Potion:"minecraft:turtle_master"}}]} function ~/../turtle_master
            if data storage psconco:temp {Items:[{Slot:2b,id:f"minecraft:{kind}",tag:{Potion:"minecraft:turtle_master"}}]} function ~/../turtle_master
            if data storage psconco:temp {Items:[{Slot:0b,id:f"minecraft:{kind}",tag:{Potion:"minecraft:long_turtle_master"}}]} function ~/../long_turtle_master
            if data storage psconco:temp {Items:[{Slot:1b,id:f"minecraft:{kind}",tag:{Potion:"minecraft:long_turtle_master"}}]} function ~/../long_turtle_master
            if data storage psconco:temp {Items:[{Slot:2b,id:f"minecraft:{kind}",tag:{Potion:"minecraft:long_turtle_master"}}]} function ~/../long_turtle_master
            if data storage psconco:temp {Items:[{Slot:0b,id:f"minecraft:{kind}",tag:{Potion:"minecraft:strong_turtle_master"}}]} function ~/../strong_turtle_master
            if data storage psconco:temp {Items:[{Slot:1b,id:f"minecraft:{kind}",tag:{Potion:"minecraft:strong_turtle_master"}}]} function ~/../strong_turtle_master
            if data storage psconco:temp {Items:[{Slot:2b,id:f"minecraft:{kind}",tag:{Potion:"minecraft:strong_turtle_master"}}]} function ~/../strong_turtle_master

    unless data storage psconco:temp potion return 0

    data remove block ~ ~ ~ Items[{Slot:0b}]
    data remove block ~ ~ ~ Items[{Slot:1b}]
    data remove block ~ ~ ~ Items[{Slot:2b}]
    data modify block ~ ~ ~ Items append from storage psconco:temp potion

    store result block ~ ~ ~ Items[{Slot:3b,id:"minecraft:phantom_membrane"}].Count byte 1 data get block ~ ~ ~ Items[{Slot:3b,id:"minecraft:phantom_membrane"}].Count 0.99999999999


    function ~/slot_0:
        data modify storage psconco:temp potion.tag.custom_potion_effects append from storage psconco:temp Items[{Slot:0b}].tag.custom_potion_effects[-1]
        data remove storage psconco:temp Items[{Slot:0b}].tag.custom_potion_effects[-1]
        if data storage psconco:temp Items[{Slot:0b}].tag.custom_potion_effects[0] function ~/
    function ~/slot_1:
        data modify storage psconco:temp potion.tag.custom_potion_effects append from storage psconco:temp Items[{Slot:1b}].tag.custom_potion_effects[-1]
        data remove storage psconco:temp Items[{Slot:1b}].tag.custom_potion_effects[-1]
        if data storage psconco:temp Items[{Slot:1b}].tag.custom_potion_effects[0] function ~/
    function ~/slot_2:
        data modify storage psconco:temp potion.tag.custom_potion_effects append from storage psconco:temp Items[{Slot:2b}].tag.custom_potion_effects[-1]
        data remove storage psconco:temp Items[{Slot:2b}].tag.custom_potion_effects[-1]
        if data storage psconco:temp Items[{Slot:2b}].tag.custom_potion_effects[0] function ~/


    function ~/lookup:
        $data modify storage psconco:temp potion.tag.custom_potion_effects append from storage psconco:main lookup.$(Potion)


    function ~/turtle_master:
        data modify storage psconco:temp potion.tag.custom_potion_effects append value {id:"minecraft:slowness",amplifier:3b,duration:400}
        data modify storage psconco:temp potion.tag.custom_potion_effects append value {id:"minecraft:resistance",amplifier:2b,duration:400}
    function ~/long_turtle_master:
        data modify storage psconco:temp potion.tag.custom_potion_effects append value {id:"minecraft:slowness",amplifier:3b,duration:800}
        data modify storage psconco:temp potion.tag.custom_potion_effects append value {id:"minecraft:resistance",amplifier:2b,duration:800}
    function ~/strong_turtle_master:
        data modify storage psconco:temp potion.tag.custom_potion_effects append value {id:"minecraft:slowness",amplifier:5b,duration:400}
        data modify storage psconco:temp potion.tag.custom_potion_effects append value {id:"minecraft:resistance",amplifier:3b,duration:400}
