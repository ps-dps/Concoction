
advancement ~/brewing_stand {
    "criteria": {
        "requirement": {
            "trigger": "minecraft:item_used_on_block",
            "conditions": {
                "player": [],
                "location": [
                    {
                        "condition": "minecraft:match_tool",
                        "predicate": {
                            "items": [
                                "minecraft:brewing_stand"
                            ]
                        }
                    }
                ]
            }
        }
    },
    "rewards": {
        "function": "psconco:place/brewing_stand"
    }
}


function ~/brewing_stand:
    advancement revoke @s only ~/
    scoreboard players set .raydist psconco 70
    anchored eyes positioned ^ ^ ^.1 function ~/../raycast:
        scoreboard players remove .raydist psconco 1

        if block ~ ~ ~ brewing_stand
            align xyz positioned ~.5 ~ ~.5
            unless entity @e[type=marker,tag=psconco.brewing_stand,limit=1,distance=..0.4]
            summon marker
            run function ~/../setup_marker
        if block ~ ~ ~ brewing_stand return 1

        unless score .raydist psconco matches ..0 positioned ^ ^ ^.1 function ~/


function ~/setup_marker:
    say summon
    tag @s add psconco.brewing_stand
