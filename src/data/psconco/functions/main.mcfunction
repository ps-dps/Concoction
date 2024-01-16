
append function_tag load:load {"values":["psconco:load"]}

function ./load:
    scoreboard objectives add psconco dummy
    scoreboard objectives add psconco.time dummy

    unless score .can_concoctionate_concoctions psconco = .can_concoctionate_concoctions psconco scoreboard players set .can_concoctionate_concoctions psconco 0
    unless score .concoction_brew_time psconco = .concoction_brew_time psconco scoreboard players set .concoction_brew_time psconco 400
    unless score .requires_fuel psconco = .requires_fuel psconco scoreboard players set .requires_fuel psconco 1

    data modify storage psconco:main lookup set value {
        "minecraft:regeneration": {id:"minecraft:regeneration",amplifier:0b,duration:900},
        "minecraft:long_regeneration": {id:"minecraft:regeneration",amplifier:0b,duration:1800},
        "minecraft:strong_regeneration": {id:"minecraft:regeneration",amplifier:1b,duration:450},

        "minecraft:swiftness": {id:"minecraft:speed",amplifier:0b,duration:3600},
        "minecraft:long_swiftness": {id:"minecraft:speed",amplifier:0b,duration:9600},
        "minecraft:strong_swiftness": {id:"minecraft:speed",amplifier:1b,duration:1800},

        "minecraft:fire_resistance": {id:"minecraft:fire_resistance",amplifier:0b,duration:3600},
        "minecraft:long_fire_resistance": {id:"minecraft:fire_resistance",amplifier:0b,duration:9600},

        "minecraft:healing": {id:"minecraft:instant_health",amplifier:0b,duration:1},
        "minecraft:strong_healing": {id:"minecraft:instant_health",amplifier:1b,duration:1},

        "minecraft:night_vision": {id:"minecraft:night_vision",amplifier:0b,duration:3600},
        "minecraft:long_night_vision": {id:"minecraft:night_vision",amplifier:0b,duration:9600},

        "minecraft:strength": {id:"minecraft:strength",amplifier:0b,duration:3600},
        "minecraft:long_strength": {id:"minecraft:strength",amplifier:0b,duration:9600},
        "minecraft:strong_strength": {id:"minecraft:strength",amplifier:1b,duration:1800},

        "minecraft:leaping": {id:"minecraft:jump_boost",amplifier:0b,duration:3600},
        "minecraft:long_leaping": {id:"minecraft:jump_boost",amplifier:0b,duration:9600},
        "minecraft:strong_leaping": {id:"minecraft:jump_boost",amplifier:1b,duration:1800},

        "minecraft:water_breathing": {id:"minecraft:water_breathing",amplifier:0b,duration:3600},
        "minecraft:long_water_breathing": {id:"minecraft:water_breathing",amplifier:0b,duration:9600},

        "minecraft:invisibility": {id:"minecraft:invisibility",amplifier:0b,duration:3600},
        "minecraft:long_invisibility": {id:"minecraft:invisibility",amplifier:0b,duration:9600},

        "minecraft:slow_falling": {id:"minecraft:slow_falling",amplifier:0b,duration:1800},
        "minecraft:long_slow_falling": {id:"minecraft:slow_falling",amplifier:0b,duration:4800},

        "minecraft:luck": {id:"minecraft:luck",amplifier:0b,duration:6000},

        "minecraft:poison": {id:"minecraft:poison",amplifier:0b,duration:900},
        "minecraft:long_poison": {id:"minecraft:poison",amplifier:0b,duration:1800},
        "minecraft:strong_poison": {id:"minecraft:poison",amplifier:1b,duration:450},

        "minecraft:weakness": {id:"minecraft:weakness",amplifier:0b,duration:1800},
        "minecraft:long_weakness": {id:"minecraft:weakness",amplifier:0b,duration:4800},

        "minecraft:slowness": {id:"minecraft:slowness",amplifier:0b,duration:1800},
        "minecraft:long_slowness": {id:"minecraft:slowness",amplifier:0b,duration:4800},
        "minecraft:strong_slowness": {id:"minecraft:slowness",amplifier:3b,duration:400},

        "minecraft:harming": {id:"minecraft:instant_damage",amplifier:0b,duration:1},
        "minecraft:strong_harming": {id:"minecraft:instant_damage",amplifier:1b,duration:1},

        # "minecraft:turtle_master": {...} # can't be added like this since it's 2 effects
    }

    function ./main_10t
    function ./main_1t


function ./main_10t:
    schedule function ~/ 10t replace

    as @e[type=marker,tag=psconco.brewing_stand] at @s function ./tick/10t


function ./main_1t:
    schedule function ~/ 1t replace
    
    as @e[type=marker,tag=psconco.brewing_stand,tag=psconco.tick] at @s function ./tick/1t
