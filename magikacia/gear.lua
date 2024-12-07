local blank = "blank.png^[png:"
local textures_helmet = {
    earth_helmet_inv = "iVBORw0KGgoAAAANSUhEUgAAAEAAAAAgCAYAAACinX6EAAAAAXNSR0IArs4c6QAABE9JREFUaEPtl01vG1UUht/7MZ4Z2/mqS0Ut0qQJlNA4pQVVLFBbqVRIsO0vKQgQlegeEOUn8AdA0E0lpHbRDUWCIpWkolVbSEIwVCIByXY8c78O3AuxuqggySxcWb4bezznte/7nDPnXDM85mvh1CSJiCEqSUgpYDTBGQelDADC4rWfWRELhcRFfni72oUTk1QqSySVCLIkYTIHqwk6N9Ba4/trq4U8FBJv10SRuBdfPUjJSIR0pAQhBIgAp4GsrZDnOb65/GMhD4XERYxtV3v89dkAoFyNIWUUZD7z3ZaG0RrXv7hbyEMh8XZNFInzAKp7UpQrSe9r8lxDdTSM0fjq80EH8JoHkKBcTQMAb9ooi6yTw1qHry/dL5TEQuIimd2u9vlXDpAv/7giAcbhN6y0AilAKY1vLy8X8lBIvF0TReIWTj5FTHDEqYCQHgLgnIU1DnCEG1+uFPJQSFzE2Jb26OkD5MdbKZFgwn9KcI5AlpBvGhjtEJUE0moSAHjz/jFw1oVR6CxBSgmjXHj114wD1lpYZcN7r2NCQPLwA+AcULmBcSpUVF/XC2emKUolqhMx4jgB+RLPM3RbKpjSSiMuR0gqMRhjIBC0tiBNUJkGHIOIeAAYl1IQEZTKYYyHZwMQzjniJEKc+kbKYLS/p6GV6T+Ao6dmKBnnqE4kYc77Uecz3O0Y5J08mIY0KCUR0jRFY+w0rq9dAiOBvG3AmQhnhKQa9bQ++x6A7rrQMIXgKI/FEPKfCti67yus7xVw5OQUJaMC9kEXE/M1tH9qYXR2HO0/uiFDp+fP4v0PPgz7vHDhPcqzrHf9zttv0dWlz0KDrI4kyFsKsiLRWmvB9w2WcjgLcAnE/iTpe0iYJAbOeTjUfwCHjtcpqXK41S6IGCaOjYPHHFlHI+9YnDlyFh9d/LgHoNNu967ffOMcXVn8FGlVopRGyH7LkD/oBtPVxgiyTQN9r4toIkI6lUBwAcZZANC+2YLYK/sPYObYE1QqRxBrOeSEANsnoe8ryLkENiMsXf2lV6Xnz78bKmALiM/m3IknyT8CxCzMDzlYDJQOVWA2NAwn0HKOuFEFkYO+k6F0OAH700E1FeSzSf8BzL28n/gDFRqVnIwQjUbYvNkOm1abGktXmv/5mM6dqJNYzQEOsKdjcMbDAcln297tAAeTMDplJGBudyCfq8De6yJ+JoWytv8AGrM1Iv/P9hGLxVCLd35fW1r5FQvT9dmHQxaXm/cbU/vRmN47U2SM9b0J/rt5vw82PY7Rylht9dbKes33qnAo2MGan67dYYSxpZX1+t890z1KOj+55yIXWFxc3vjE339cAPT2Oj9V+y7Zu/7SjRvQO/COw1O12wy079bKhof3f+C87xDz2AHYiemHY+v1ernZbG7uVD8wAHZqfCt+CGC35AZFN6yAQcnkbn0MK2C35AZFN6yAQcnkbn0MK2C35AZFN6yAQcnkbn38BXl90bpsctFQAAAADmVYSWZNTQAqAAAACAAAAAAAAADSU5MAAAAASUVORK5CYII=",
    earth_helmet = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAAXNSR0IArs4c6QAAATFJREFUOE/Fkr1KA0EUhc8dEQPBQkhhtRMLhXSKMdqI2JkVxCcRwecQxEdR3NhKGo0R7QQVzGxlEbDSECEzMnedZH8SLbZw4BZzf757ODOEnIdyzuNXwNpu2dgFtxediX1jC24wrW4cKAOo+pK3AoTZYgEDrfHZ+wIQpduBSswkLm6YiGCjMDONKSHw0evDGMORhmQAdnBd1tEKL7Fd2YceaFw9naHm7eBGNRgSV5ECRKZtLPhoqQa2lvagtUHz5Rw1Wcf1a/CjYGTqEGCNswqJRq4fHR4w8PjklPuq9lVSPRlAO5j8ZAzxyya+ZAiwhcigvwHxvoQHFa9kHsMuKaVM2H3H5uoy15t3D8YrzUFKSa7H/ZEEYGVxnlUIIaC1xv3zG9dt3uXs3eWj35Lz/D/gG4eWhRG3Kt1eAAAADmVYSWZNTQAqAAAACAAAAAAAAADSU5MAAAAASUVORK5CYII=",
    hydro_helmet_inv = nil,
    hydro_helmet = "iVBORw0KGgoAAAANSUhEUgAAAEAAAAAgCAYAAACinX6EAAAAAXNSR0IArs4c6QAAAv1JREFUaEPtVktIFWEUPjNzp9QQyaAX100RWjQqFRFFITeinUnmRk0UrSwDF0WrUG6bIGohJKVplq9Fj0UtghCkiNuiCLQLovTYeCkq6Ek2Na/4/st/Gex2uTAwM+iczT/MP9/5z/nO958zAvncWvrfWggxJMskSRKL1jAM0jWNPfc1rxOcpOAI7OTgbLEggCcvy3IKpmka/VbVhU9A6+Cshcoj+cqyfEbAgymVKUBVVbraUOSoiI7A2VbRyXdtI+/YFajeVkhjrwzmat8Gie5P/iCooLturaMcHIGdJJYtFgSg+lVbCujhdPLeL0oCcvPyaH+JTKZhpqqPZrjgrwCa4NKcHNYDuEH6sEXRBBf8GLSPOV5hSBuGTt+2S+4qLw5H0vWMiZnEeHdMa8eYhPH/BDw37iwgy2T9k67HvrC9dGPU8yZoH3O457Bfc3Osw4OIK4fD8cmZxIXykqJhOwkT07P1ZcXhM8eHEgpPjuNrSiXqf/KZ4WEte1bQ8LOfxPfhG+Ri9ZwAPuaadxeSIIh0azIZGA/wcu2auCAIpUjk7JA1XDFGzwdv9tCg0NplWdbLk6PvFVQWKsAKbO3WHEYADCRwArhSuG/seU4AFIAAB2JfWQINO/Jp9IXKVMAVwAmYfw1AAFcAqst/j+u3L2P+uAJA7o2n31JXgKsL/jwnoLH3tXVi72rqffSR5XcssopVD8nohkkDR9anFJCOgKZrb5SQJDIF8L6B9WjFSjKtZA/oe/yJrfgGZPSMf0h+a5jeE7CxssOSl8h0vr2KREGgUxdvUygUIl3XSRRFit/tyEjApgOdCvD4nuPseEM3iO9fOl3D/PMV/j1XwOaDUcs0zX+CRxLaH42m7kUzNkGl+pySCS+FJLLv8+S5f88JgAIQJCo1fxVyl8dHoofGM43Bus47EVH7rqTD/8+v/b3nBKSb726+Cwhwk20/nhUowI9VcTOmQAFusu3HswIF+LEqbsYUKMBNtv14VqAAP1bFzZgCBbjJth/PWvQK+Avmsaqgw7wDgwAAAA5lWElmTU0AKgAAAAgAAAAAAAAA0lOTAAAAAElFTkSuQmCC",
    glacier_helmet_inv = nil,
    glacier_helmet = "iVBORw0KGgoAAAANSUhEUgAAAEAAAAAgCAYAAACinX6EAAAAAXNSR0IArs4c6QAAAjxJREFUaEPtVsFOwkAQnUIrCEE9iMFEjImQmKiJB/3/owc9mOhBRQ1GE1E8iAQotnXNWxiyVmxJNk2rdC9LdvuGmTdvZ8aghK+LhwcBF03LpGw2K731PI9cx5W/96pVQycELbDOH8+KBQEcvGVZE5jjODS0h/+fgMvWk0DmEbypEOA6Dtm2TTuVda0kaoFnzaLOd432i3wCi4UCWdaCNOU4HwQCoIJ6eU0rBi2wTmCzYkEAsr9YKCryn2MC1OyjGP77J4AimMvnZA3gBeljzUURBAG7GxvU6XapPbSptlqmq+cWVQpFeux0/n4XUNscZxjSxkKvR/C8QMJyqSTJ4B13rX5PfsJzgn9WCGqjsRdBtc1xoRv0e7LCl3N5GWjYunltyyfixzOR3Eb5Xq0jsRPAbY77PFqd6iAkzxlXicAZFp7Fb1hWgn+O4BYKgmIngBUAZ7nQYeAZ9Pty5EWVF0IIwzCMt/d3OROsLC1NzhiPOQGBjeaE0c4K4OfB9nHPd7ETcNZsCnM848NRvFd+/67n0cHWVqCPjFdxrBTgpc2xff83uI+dgOOraznouK5Lpml+27OZDB3VtgN9DMMjyCD7sRNwcnMrvM/PH8GDDEjVyhh0WK9P9fO00RDCyFAQHtkPuo+dAGQQTiJT/l3WhRACNmu18/vbu/1p+N/squexExDW4qK+TwmImuGk208VkPQMRe1fqoCoGU66/VQBSc9Q1P6lCoia4aTbTxWQ9AxF7V+qgKgZTrr9uVfAF6/oitK5KpAeAAAADmVYSWZNTQAqAAAACAAAAAAAAADSU5MAAAAASUVORK5CYII=",
}
for k, v in pairs(textures_helmet) do
    textures_helmet[k] = blank .. v
end
for k, v in pairs(textures_helmet) do
    if k:find("helmet_inv") then
        goto continue
    end
    local ksub = k:gsub("_helmet", "")
    minetest.register_tool(":magikacia:" .. ksub .. "_helmet", {
        description = minetest.colorize(mcl_colors.DARK_GREEN, "Helmet: " .. ksub),
        inventory_image = textures_helmet[k .. "_inv"] or v,

        
        
        
        
        
        groups = { armor = 1, non_combat_armor = 1, armor_head = 1, mcl_armor_uses = -1 },
        sounds = {
            _mcl_armor_equip = "mcl_armor_equip_leather",
            _mcl_armor_unequip = "mcl_armor_unequip_leather",
        },
        on_place = mcl_armor.equip_on_use,
        on_secondary_use = mcl_armor.equip_on_use,
        _mcl_armor_element = "head",


        
        
        
        _mcl_armor_texture = v,
        _on_equip = function(obj, itemstack)
        end,
        _on_unequip = function(obj, itemstack)
        end,
        _on_break = function(obj)
        end,
    })
    ::continue::
end

minetest.register_alias("magikacia:helmet_test", "magikacia:earth_helmet")
