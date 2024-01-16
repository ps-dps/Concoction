
for kind in ["minecraft:potion","minecraft:splash_potion"]:
    function f'psconco:is_only/{kind.split(":")[1]}':
        if data storage psconco:temp Items[{Slot:0b}] unless data storage psconco:temp Items[{Slot:0b,id:kind}] return 0
        if data storage psconco:temp Items[{Slot:1b}] unless data storage psconco:temp Items[{Slot:1b,id:kind}] return 0
        if data storage psconco:temp Items[{Slot:2b}] unless data storage psconco:temp Items[{Slot:2b,id:kind}] return 0
        return 1
