local strs = {
    thanksgiving = {
        item_corn = "iVBORw0KGgoAAAANSUhEUgAAAA0AAAAVCAYAAACdbmSKAAAAAXNSR0IArs4c6QAAAj5JREFUOE+d1E9Ik3Ecx/H3s2d7nmdzk2luZf4rtX9it6xDnUJZnuwQhELkSSToUtAhgi4FlQVGl6hDp1IsoiDoj2Ag1KWDnawEMUvGtmRma3vcsz3PN6Yk2DYPfc+f1/fH7/vl91P4j1LKmZnnPaLnZmg68akoUxLNP9knjW0q2Xkf8XSqCJZEicc7JbhNcPl1UnY3VQeGN+SK0OzYIamvjaFVq0hGJUcFesfHzdHCWLvU7TdxFl24goIZy+Pr+ro5ij9tF384gS9QiWTziGKgdnwujxZGG6SmTtD9BpaZQfNVYOeyWMsGvs6Zdbihw/fRRqlv8+H8MnEFdSRjo3hszLiO79iX0ujbSKs0NIPoeZScG3SBvEI6qeHvnC6NoqPNEt4BiuYgDigKuHCRWvRQGfnnpDuPzorhSxNxJqnfZSCpn6s7cixQ1BzJmMaLH01E3S1c7LtX6LVWN0Y65bRngS0hCzUkzCW8TM2lOb5XZSIZYCof5kLP+Gp+HZ0ZPiK1xLjUrWPFV1gOVTE+bdK32+RldDsfkhVc7n29ERU63HrWJQPhOHatxs33XlqUJXpb4V02yERU4+rJiWJ07v5h2VOZJ9Lo5u6sRnXAoMVK4A16eRtzMXRqshj1Dx2UUMggFA6wtGTi9XvIZrLk0bje+6b0yAevHRV/SEXXbQIBDdWtYlk2pglX+l6VRoV7DQ53SXWNYPgNHMdhZcXC/r2VoYGH5VEBnn8QkZxioyguEOF2/9qo/1bZ577Z1/EH2vrVFo/8TwYAAAAOZVhJZk1NACoAAAAIAAAAAAAAANJTkwAAAABJRU5ErkJggg==",
        item_hat = "iVBORw0KGgoAAAANSUhEUgAAABUAAAATCAYAAAB/TkaLAAAAAXNSR0IArs4c6QAAAfBJREFUOE+1lDFrFEEUx39vZndvyV3UQAqxEMTKAy1E0M9iI6TQSgx2fgTFQq1EKwvB2tpvIGiXaCEE0mkhJ3c59nZnnrzxNnDeXXIkOjAsy8783nv/998n/IclqzC99xpjpCgKqqo69s6RBwwWQsB7jz3b1e12GY1GS+8eCRURVdUEtadtEUk7hHA6qHNuBmpw4PRQ0zSRRFKAfw61zC2Iqi7MdmkJeZ6nJk2zSrraajO297quTwZtS7bsbLUuOBFUxKuIopiWAklGwAkSFXFuqQOWd1AyFTFgTMwYwCGoU0SzFEw1rl5+R1BTK0ZHIZFc//jHQhw4hzil6zPqSU2l89ZaGOnOrVJ392q+HwhrseHDm4t8e7/GtRuOq9u7lOc8m+twaSPw9vO8AxZCt67namUWeY6LYx4+Os+Txz95evsy26+/UvYiQYVfFbz7NC/BDLQoCrVG+Kri5pWzbJZj8smEl/f6PHi1w/O7fbZefKHY6LD/Y8LHvQBZRlU3Mz9DC029bW1jXvT2RaHrYf9Z/3CYXLi/Q/CC845xE0iSTjW3+zYTDjPt9Xo6HA6TyZPBZdoBOyIdop8gMUPStHKYko6amPoknOmtMxgMEm+hpmVZal3X6T93Cdoem6ZvRUynVtM0c4xjB+4qQ/zvM78BYLfpFLLwrskAAAAOZVhJZk1NACoAAAAIAAAAAAAAANJTkwAAAABJRU5ErkJggg==",
        item_pumpkin = "iVBORw0KGgoAAAANSUhEUgAAABYAAAAWCAYAAADEtGw7AAAAAXNSR0IArs4c6QAAAqJJREFUSEu1lU1oE0EUx/8JVtOkrUJQoVQaBDXdNE2axkTBSKuUIl560lujgqh48eJRPYo3jwFPpWDx5sFLD9aikjbrNs13iyDWgwe1aj7cTYKakdlxt5PNR1vBOc3y3vvN/33MrAn/aZl2yr0TmSR26wBuTd1vG7sj8N3IJCmWvuHh7Zdbxm3pQDO6+sBPrF0WVDcqiNyTthXT1ulV2Enm3Xb8tO1GbRcB+U3QLQOh1Ce1gqHptZbxTQ0UWKoqeOc9gCmbgpRUgySYccUKzGcqKDv24nxXFbHFPDo7epoe0ABeuOQgwyNWvM1WcdS1R1UmxfMYC/WjJBewmpQx4LHpPc9Iv1CDuQFeB6ZKh/xmNUhcVBA4aVX3cbGA0dMOFCvfkc1U4Bq06GCaDY1ZSckYffRB5+kbHkqjtAC6T0hFeP09Kmw1XcWAm2XC+1Eh44/XG8HSzX5yxMlS5NUa55weSJeWGW+PijLOzTDV+gmx673E6drXAE6LP+AOdNXx+Wx4EZJUxtnp95tgYxl456RUhOdvGTQ6bzdmp5VEpb+4fIj4fN26Kt45sZyHd4RlYqxrs7LVgZ+H+4jfoKoOJH7BUGA/a1bsK4aC9rqD1tIlON1MmBhVMD67blIVL4T7yHAbcHJJhucEa2w2LsPl25xjfjLoful1ARNPPjLw04t2MnbqoHEA9O+VmIzhIIPlkmUIns6WpZmb28CFZ58ZWE3hWi85NlhfS80miQr8AXZZcgkFgpfttbWWK8MpdGJZLOPMDDcV1CF24zBxCuxGGTsdjynwBRksnZDh9m6WgvpaOizqXC9FZUzMGua41XVWVb4pQTjOmpNNKHBxinkRdL61F6/pW9Hs5mk3rmUjDM9ow+tGlbcLbmUzvs3b+hv8y0F/APJNLCYCuHxpAAAADmVYSWZNTQAqAAAACAAAAAAAAADSU5MAAAAASUVORK5CYII=",
        item_squash = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAXCAYAAAAC9s/ZAAAAAXNSR0IArs4c6QAAAbFJREFUOE+llLtKA1EQhv9NlmQTZJPGRhsRvKCgjQYiJopgayFWNtrZKPgAggi+gRBsbUTQNxALERQklUIiYpFCBLVQF81e3SNzkg3J7slFneYsOzPfzPw7eyT806RO8i9WhhnFZQ7uAvFtAVszg2z3/L5pXEvA9lIP2zl5ahnT0nm22su+DAcLR8+/7+B4bZwtTtr41IGbvCucn3QRkkm0sYlQg763RQvTuYfORBQBCsUy0rnS3wDXV2UkVAep/cf2gNPlPpZKx3n7SkTjZyQcgaYrQi0CxAZA9J0DDDPJT5GYAcDH3giTZQ2Oo0KpAlyEYJlqewBVT2cchGTANtSmW57YKNQK1x7qlY9EK7MHTAKsKtgbpwag6tlZEy7CTSvTGErsFYbeXRuHA/KbA+ztxUZ2zoTr0gL5pXE51DKToO4IREaj8EiqPpWyIXdJcCuxPvNeSoD0jbAlQ3fVRoD37UXpSkyDxADdUBFTNH7Scs0fliodXK73s9EhBXFFQ1mgfj3AK9AA8MZo1YW/swCAAkQ/kT+RPp9hG7x98gU20bv/KEhkXqLna3snNl2KquMHlePEGG89E9IAAAAOZVhJZk1NACoAAAAIAAAAAAAAANJTkwAAAABJRU5ErkJggg==",
        item_thankgiving_boat = "iVBORw0KGgoAAAANSUhEUgAAABsAAAAbCAYAAACN1PRVAAAAAXNSR0IArs4c6QAABFJJREFUSEu9lk1sVFUUx3/3vvfme6ZftAWKBQytlaEGo4kLMW6MHwjGhEQICyV+JSbudWHihoSYuFATY4JxoRsTYiRGI1EioogiYQEKSmmEDrQ0ZTqFmaHTNx/vHvNeB9tKPyYQvZnF5N3zzu+c/z3n3Kf4H5e6HdYbD/fK7h/ONeyjYcP5gvpPYD8PXxeFRgDX1nQnFa/3t9Du1PhgoNJwwEsa/jpyTZYnE4AGBQZQYqjmMny86wluW8Zjo5PiGY1lQ2c8giBYKNxKjbCtqVmCyQ7xyXOb58BeuLtNPvozt2ACi2Z2bLTqK4enDc2OJt3qqJOjrlQVNLk+7Kk5sJfSLfLhmau3BluqUv9dIC9vaJW9pyduD3aqJPL5qSzagTfv7/jH2U2wdFL2nineOuztE5ek23LYuGYZ2oL9Zy9SUwnCVo2+9iQTkwWG8sKBHetpDSmMCuNUSzjVqUCY7BQcznpBAIue2e4TOdm5vpm1YQ3GI1uuYitFWYQxHeZAxmXLchspCz/lfeeKGpq+jhiPtlg3+V4U9tbxMXkm3c6a2IyZX/qewIArDIy7bO6Koqo1ypYgYlM1cCbncjzr8drG5Bz/S8K2p9tZPQvml2fNh5WFofFJtqyIQz0JPxB/78hIiUfuiDee2bs/Dkk+FceuuGxPr8SqacrVCt1tIULA6YqQyV5ny8okarZbI3x9KceTa9obg312oSA9nUmacOmIRnjnt2vYnmZzb4ooIBryDvx1ucbjqywSesavEvhquMjW7lSjsKLc1ZFgQ4xgHnqALbB/cJQJz8FYUSbcMj0ph662JFJ3qzWIB39cMTy/rsEC2ZcpSF9bkv74rLYWA0rjUcNg8/7JIbb1rOL3KYtwMGdg0ijGpjy0tnhx9Rxxg/15C2Rfpih9yxL0x2bBjD+2SlhEqQG/FCA05fJAewSpy1gFjuYgFIZNyQVgD7Y4cvSqP/Gm16fn85LuTJKOqWAIz8QkKBSZvEshGubClRJPd8Vnb3P4KtgOPJRaJLPHEkg5AofHUYeG85LuSpEwVdSsd/yz0V4ZsaIMlTSnsmXubbPojdm+woh4XDMW356/zo7euT02r4yv3LdWIqpAuFpC6Ypfe9N32Q3Ftcd4Afae8/jmSoXuuGZdzA4U8RCmjOJgpsjBZ9OkClkMQqJ1dXA7zHtm/oB1SiM0Rf06BKU0Ui8CLTYoj8tuhCODxQUvhk39zXSqAiO5KqGOHvYcOjs/zPfw6sYmadZFtJ+R//ObCxM0cE1rPPEwxgLPoIwJZPRvP8cDf+xGHB3cg25ZEersYc93AwvDdt2zUlZYYzQ3N2GLF/SZ0grjSf18povFfyamnnYQl/+1Ul+ecLGQx23t4b3vBxeG+ebbOpE7l1toTBCtL+WNN27IOi1z/Uhl2iZ4Ftgqzl42fJmdPvAlP3h2dmlBm3oWYHwv9aVn/s7QArHrTV6ELyZmGEvCFqyAW9j4G3hKzStDED5rAAAADmVYSWZNTQAqAAAACAAAAAAAAADSU5MAAAAASUVORK5CYII=",
    },
}

for kStr, kVal in pairs(strs) do
    local fbox = {type = "fixed", fixed = {-8/16, -1/2, -8/16, 8/16, -7.5/16, 8/16}}
    for i,v in pairs(kVal) do
        local def = {
            use_texture_alpha = "clip",
            groups = {oddly_breakable_by_hand=1, z_item=1, dig_immediate=3},
            node_placement_prediction = "",
        }
        local itemname = i
        local register_func = minetest.register_node
        local image_def = {
            description = "Image Poster: " .. kStr .. "_" .. itemname,
            drawtype = "nodebox",
            selection_box = fbox,
            paramtype = "light",
            paramtype2 = "wallmounted",
            sunlight_propagates = true,
            node_box = fbox,
            collision_box = fbox,
            tiles = {
                {name = "blank.png^[png:" .. v},
                {name = "blank.png^[png:" .. v},
                {name = "blank.png"},
                {name = "blank.png"},
                {name = "blank.png"},
                {name = "blank.png"},
            },
        }
        if i:gmatch("^item_") then
            itemname = i:gsub("^item_", "")
            register_func = minetest.register_craftitem
            table.update(def, {
                description = "Image Item: " .. kStr .. "_" .. itemname,
                inventory_image = "blank.png^[png:" .. v,
            })
        elseif i:gmatch("^node_") then
            itemname = i:gsub("^node_", "")
            register_func = minetest.register_node
            table.update(def, {
                description = "Image Block: " .. kStr .. "_" .. itemname,
                tiles = {
                    {name = "blank.png^[png:" .. v},
                }
            })
        elseif i:gmatch("^image_") then
            itemname = i:gsub("^image_", "")
            register_func = minetest.register_node
            table.update(def, image_def)
        else
            register_func = minetest.register_node
            table.update(def, image_def)
        end
        register_func(":arkacia:images_" .. kStr .. "_" .. itemname, def)

    end
end
