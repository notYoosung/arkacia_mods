local texture = "blank.png^[png:iVBORw0KGgoAAAANSUhEUgAAAEAAAAAgCAYAAACinX6EAAAAAXNSR0IArs4c6QAABE9JREFUaEPtl01vG1UUht/7MZ4Z2/mqS0Ut0qQJlNA4pQVVLFBbqVRIsO0vKQgQlegeEOUn8AdA0E0lpHbRDUWCIpWkolVbSEIwVCIByXY8c78O3AuxuqggySxcWb4bezznte/7nDPnXDM85mvh1CSJiCEqSUgpYDTBGQelDADC4rWfWRELhcRFfni72oUTk1QqSySVCLIkYTIHqwk6N9Ba4/trq4U8FBJv10SRuBdfPUjJSIR0pAQhBIgAp4GsrZDnOb65/GMhD4XERYxtV3v89dkAoFyNIWUUZD7z3ZaG0RrXv7hbyEMh8XZNFInzAKp7UpQrSe9r8lxDdTSM0fjq80EH8JoHkKBcTQMAb9ooi6yTw1qHry/dL5TEQuIimd2u9vlXDpAv/7giAcbhN6y0AilAKY1vLy8X8lBIvF0TReIWTj5FTHDEqYCQHgLgnIU1DnCEG1+uFPJQSFzE2Jb26OkD5MdbKZFgwn9KcI5AlpBvGhjtEJUE0moSAHjz/jFw1oVR6CxBSgmjXHj114wD1lpYZcN7r2NCQPLwA+AcULmBcSpUVF/XC2emKUolqhMx4jgB+RLPM3RbKpjSSiMuR0gqMRhjIBC0tiBNUJkGHIOIeAAYl1IQEZTKYYyHZwMQzjniJEKc+kbKYLS/p6GV6T+Ao6dmKBnnqE4kYc77Uecz3O0Y5J08mIY0KCUR0jRFY+w0rq9dAiOBvG3AmQhnhKQa9bQ++x6A7rrQMIXgKI/FEPKfCti67yus7xVw5OQUJaMC9kEXE/M1tH9qYXR2HO0/uiFDp+fP4v0PPgz7vHDhPcqzrHf9zttv0dWlz0KDrI4kyFsKsiLRWmvB9w2WcjgLcAnE/iTpe0iYJAbOeTjUfwCHjtcpqXK41S6IGCaOjYPHHFlHI+9YnDlyFh9d/LgHoNNu967ffOMcXVn8FGlVopRGyH7LkD/oBtPVxgiyTQN9r4toIkI6lUBwAcZZANC+2YLYK/sPYObYE1QqRxBrOeSEANsnoe8ryLkENiMsXf2lV6Xnz78bKmALiM/m3IknyT8CxCzMDzlYDJQOVWA2NAwn0HKOuFEFkYO+k6F0OAH700E1FeSzSf8BzL28n/gDFRqVnIwQjUbYvNkOm1abGktXmv/5mM6dqJNYzQEOsKdjcMbDAcln297tAAeTMDplJGBudyCfq8De6yJ+JoWytv8AGrM1Iv/P9hGLxVCLd35fW1r5FQvT9dmHQxaXm/cbU/vRmN47U2SM9b0J/rt5vw82PY7Rylht9dbKes33qnAo2MGan67dYYSxpZX1+t890z1KOj+55yIXWFxc3vjE339cAPT2Oj9V+y7Zu/7SjRvQO/COw1O12wy079bKhof3f+C87xDz2AHYiemHY+v1ernZbG7uVD8wAHZqfCt+CGC35AZFN6yAQcnkbn0MK2C35AZFN6yAQcnkbn0MK2C35AZFN6yAQcnkbn38BXl90bpsctFQAAAADmVYSWZNTQAqAAAACAAAAAAAAADSU5MAAAAASUVORK5CYII="
minetest.register_tool(":magikacia:helmet_test", {
    description = ("Test helmet"),
    inventory_image = texture,

     
     
     
     
     
    groups = { armor = 1, non_combat_armor = 1, armor_head = 1, mcl_armor_uses = 10 },
    sounds = {
        _mcl_armor_equip = "mcl_armor_equip_leather",
        _mcl_armor_unequip = "mcl_armor_unequip_leather",
    },
    on_place = mcl_armor.equip_on_use,
    on_secondary_use = mcl_armor.equip_on_use,
    _mcl_armor_element = "head",


     
     
     
    _mcl_armor_texture = texture,
    _on_equip = function(obj, itemstack)
    end,
    _on_unequip = function(obj, itemstack)
    end,
    _on_break = function(obj)
    end,
})
