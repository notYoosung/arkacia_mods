local strs = {
    images = {
        balloon_pink = "iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAAAXNSR0IArs4c6QAAAERlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAMKADAAQAAAABAAAAMAAAAADbN2wMAAAFDklEQVRoBe1ZO6/cRBgd7717dzf7oKKIIiGkCKWhTIOEiCLSRrSkoKbOD6CihD/AT0hJEykSeUlI0NBQcQUdICW5Ddmbzd27D5tz5mGPvWN7ZtZwFSkjeWc8j2/O+b7jmbFXiLfpYj2QxE7/+1ffcewYVyKSRIxGQ5QazGWZODtbCoG8klix+ODrL3caKv2ct4fOWr9Kgj/GNcMVNTnGkfEc1zVcr3AFp30IcPIprgnxk0GD/zUwJ0+/odpCNWuf0xphyYa1M0gGEcgm0JAYzcBDSyjbbMtSYT2ks3x9VlAtpETPMwKMBFOQnEIjUMgGoIajIe9Fr38o3v38lugd9UW22oiX3/8oxHqTE2KfzAA2+RokWS+y8XK9phSZguUUSqAkG84oQwgyJJEcKXMJ7jN63Uqsk8nkuk2uAFKGsiJYTq0EKrKZQiZAkgG4Ak3ZJACf0aMoZ/S8fCI0QiuTxEwEyGf3kWDtFHOallY5tRKAwWbZaPCn939W4ElPy8PCLouDIZZaJMrpXGBJVTdCbDhIYjZzscVLTj4EpFdgEE8pJYNb1sDbSjb93PPS+wxQS8rlJPuV+vNGzoPcS04+BCpwHHbpPQL3AF8xpnEWtTIODm0VPcqlCAJlA13eEfyrcyy1Uk6lyNRO0w2BKM+7MGFRBfiQKOxFwGflccFsrqPnFYXmfqo1mgB3W25Y6oGE12pWHh8Q+/SJJsBlT635evpoGflpvY5kPAEA5gYWE4H8WCFR+cvFRSKaQHJ4IN757GN5fGAk5pBTm4zOl0u9wgAKd2yDXa46LnjtdREEipDz7GPOP9gEWmcred6Abx3V3CGCAGbOFNh0tRY92OcJtHCne8L/AjxnCiPAUJtjMFahk3sPJVrSOTrEkcKRamXj6BtTFUbAnoGrED0P9FINNQR8PE8HKEWpyNrTtJV9CND2KS5pHbDHWH92ZiLQ8iENoOyHUyHcwcM+bJK/qrjQnThnzajCjA8BGuQrH9NMvz1NCFYdjlELOvnxWHazfuzVxqpebtY5wdPi/LMAh9LrpTXEWdzxpLOXrsSLBl/i/8bFXIz6R8xU0m9j5jbP5QOe3+WFs/VKlun00yXflWWi169c/+Yuc6/kEwHbEOdxy4ktVXfUCMBIq5BNgijLzl6ysQGFEmiXk229Uu5KNrbZqs/stsZyo5xqRnYlG9t8aATssfVysnvpcpeysc3vQ8ApJ9u4KTPMku0eq42xVc2jJWQbqsrJbjMTkMB8+Tp6tbFt2uV9ImDbKclplW75eSRhpZIOSyjisyELSMGrjRq2+9sVASmnSwd98eDkj9lP//zJT4WTFJBfPD8B8hS3yeKTy1ev3X7vw/liI/cAQ2YXVUCNiXDAkOauX9y5oze7ZJqlqXj2/IVgjj2CXr/y8OkT5p2lriKQAxr0lEl6Jk16YniAz449KaFkm6bTT2/c1Idxsfjh6WPZkA+OKHRO4O77H+UwuNPOL6vvPKt0M/7210fH6y3l5PfZMDfUUOicwKB3kE9H9w4QAS49iAiDEvTZMDfUUOicALASN3WOVUiflVGlOOj/1BoAhTZ1TgAAzAaXLxDj/iB78Ndvs/Pt5hiVJgqhWJ39Oyeg/23c+cPu1o2bJMTodJo6J9CAzkiL3wFIcAJShlD0ivR/EjDSIkfuFb/g4l+0L3FdyN+smNc/6TVfSkvLic8Cjxxym/a3VO7JcL7R6S2Biw7fGx+BfwGsgBK7o/kMAAAAAABJRU5ErkJggg==",
        balloon_purple = "iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAAAXNSR0IArs4c6QAAAERlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAMKADAAQAAAABAAAAMAAAAADbN2wMAAAFB0lEQVRoBe1Zu4oUQRStnp1ZR3d2BAMRRDATAxPNRBDxBwwMxA/wA0w1U0P9DDE0MVZBzATxBRtoZqAmvuaxOz3dnlOvqerpV3W3imBBdd+ux7333HuqunpGiP/l70Ygamr+5qn7nLuFGqGI4YEhhUJ1aZqK+XQueM8UNkxuv7661pEZl/vYz22t10jnd1DHqI2MYx4Rf0c9gfoTNbi0AUDj26ij1PhvYBQkwo7z3eSsghn+wLynoIkObahrDMrswKkRqTM+NCKZkItUxLsJIBk0yjsyZzaZ6XY1TjvEyDMDzARLEJ1CM2Bpo3nPZ7G5vy+u3DsrBgf6YjFbioc3XojFPEZYV/ExgMwa4DhV0q04WZCKLMF0CgVAj3zaaCfp/D5UDmAipPMr/0WUykbVvkqOHi2QPlmC6VQJIEObbUQ+YjSZAUaeZTBUkae/q8jKLu9CUClms2i2ef1sRt2GTQOxkk6VAKCwFm0e3Xop4jloARcW+u55h/bh/n2yydCJy4RyPEWn2l6NLY6rRac6AGRUoFCm2fIaIRwgA8wCB9BpVsrqQiFTZCe6NZ3YS5nNOuQUg+hUBwDt2CLpY0zSKqOIqniPZ+2knVAh2GzYcRqKfS4XggGUq2vbi7f1cmqyUUtZCwAINaPNW2DUyzxT8a+fheYAwBvJeThftvOUOdtFXzMAcJpvW76wTPRzd54uPKzQ0QwAlHLxLWax5Y8BUmFvrdvuams99RoaA6BhbqPGcZmBKpua2nLnoYxKuT7j1w00AwCL/WFPXLpzBu+BDXX+uYnzD883RQsac+azXeUuZGZPvbsIpDmEYAA25Qj9AM5v4vxTt3iRb+6zZ66+dQZKVl4RZu5CU6wBlNJdSDvqOS9ndXMJAiCd1sdgnnseXH9uF3G/B1VZ+sD5Qtp0478IA+AY5bl+D2Ckz7j0SaUsAIz3Iq+z4ahpLdYBQLM/ULV7KU6MZu9Z2aej8pC2avKdd9p90aCyUCe6nzZNpz/FeaoDgAr5yccy1l9P/H7EN6JqtHCyGYB5b7dRw+UVenBX/s2XE+MpbKXe56UzJVfMmswdZBrxocGvsY+ovIt+b5M3WeTHTVYb/Nvjyy6nxMmebk3FDAc4DYZRP3r33TXea5U6GXAVMWS5dGKH9F8FVT4Y0VWgZNPTjDauvlAA5XTKyYBrrCvauDqzJt2+UrmMTkUTu6KNqz80A+5c8iCXTu6gldwdbVY6sQ7dh0C5gE7FWtrsNkVaG1PIVZilk9vnyjNsl013G1ePK7fJgKvHo1PSi/nziNqU7EmTQkoELKSe4ZRsaHrpCoCk08ZyU3w5/Hb89dAH/lQ44nHj85dPOEJJXydH5idPHJue/h5Hu/TXgGnqu5zXCYVcD65cvmpfdgkBfP4kkjRhOhj1o0+fPeG9s9JVBqxDvWRg5QgANtKB6AEAGBUl0XL7/LkLhjqTp88eG9nOCRU6B3D8/UXHh1QcidU5J4kWW28OPtpZRgRT72dDR1Gh2DmAXuKrZAYYZlCIdA362bDQa6fDt+Z0tBDpr37BmX8DeObhD6I8iqvdqYV+b+rvACB3JNfRfjJMP269Gi+jWO5OngctHzoHoP9tXPvDDouXFGq9aLN4OweQNeA8G2r10EaAoy52pD8JwFCLmPiueIHKv2i/ofIrbC1raKssfwyA3vOlk5pO3JG4qOVLotLTggFM5z9d/gP42+n75zPwC/EEEBRzNl3/AAAAAElFTkSuQmCC",
        balloon_red = "iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAAAXNSR0IArs4c6QAAAERlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAMKADAAQAAAABAAAAMAAAAADbN2wMAAAFAUlEQVRoBe1ZO48URxDu3Vvg7vYh62RBgJ04MCIitWSEzG8gI3OIhEicIJEQOnHixKF/BxEEICEhQmStA8sOHPBIeOzjYHfW31fTNVMzOzs7Pdv2GYk6zXV1T3dVfV1fd8/MOvdJTnYGOm3d/3rxK47t4+pA3P7hIZWN5larlZtPp45lSdgw+f63P9ZulPpVVnuVrc0aGfwY1whXK+cYR8RvcF3A9Q5XsOwCgM6HuAZZ9Dq7GzKR9SuGyebNqSv2XasFDTS0oaERKDOG9wGpMzg6SimEhuXxfD0lADebTKSdTg2VOPPMADNBCaJTaAYy2njes+56Bwfuu59/QXnoFrOZe3z7B7eYzwrTqrOvgS/Rj4L2/ockIRUpwXQKBbBOG3jt4I/B9/rAQ/rgktQaKnVIL21XqslY6Tpg9BDilKFSa/BvK4ASbYaY+Y54QTCceYa6d7AvM84AF7Opj2PdOyNbKSiWBojvzS5D+KQLylY6bQUAI9tpA7o8uXvHLedz8SqlBiot+If6GQCmaHQEIJORb6/qi90a0akJAJkVGJQ0s0LhGtgjbbD/Uxg0+S/3y8FLD/zz7UonNouu91GFGkSnJgBy89BkxrSFFBAapK21weuYUsmRVsp1e69KDwZQZSRWG4OfJUmQud0AkBJCC5n7IMd1nUOy0B4AvHAv51rgnm+WZl1s0e+1A4CgedrywEozsEp3IMlG9BhrDbYDAJM8UWXP90EzE22k3ajcU2sADJinbyEDud1qTXYsTza/g4XwvcpoOwBwvrd/4L758Sc5B5gJ0kmebzZlAmOOsWYkYOg8M/Qk1uejqgC3tQUDyFIOhY8SepClZ1C9Ow1eAmcGIkgwALoliGwNQJfZzB8QimH5QAvBF3vsVAsCwKD1MZiPDg9u3ZBtlBH0ul2/Hkw86L+JNqbXTmoQAOvJguFCFipV8L8w85FoY+NoAoAxvMUl9EelD0V0a4idSg9m2YLVxWr7qy4AUfEli4m/R5962zetF00A0CBf+Sgj//Y0EATcSSg681qmrbLL2N1Gm1nCThbdNH/+mSDiwuulHVOlr81kVSdtw4sGX+L/xsXSnSbvvXBHyoBoIyiTLnBtyMv3PmhOMR/g/FRz1s/fHP/JspE0yYA1RD/1dFKel7NhrPhgNWhWg2hjTLlQAPV0KgetYLzHWLSxAIIoZAfW0cn2s3os2liboRmwY7fTyfSOSRtjNphCdmwlnWyHsr7LblO2pfXWFFIDLMt0svesTgA+E8G7jbVj9V0oZO0U6LTsdvsr2VPx2SRfyNRa7zbWmdVjARA6nV4u3PjcF6O/Pj+LT4WdQbJK3ItXrxTE5Ovp2wuX3r1+c5yeHwrGxhOsR6GQ9Xr92jU57GB4mGDOn7984VhChDYPHj5qfEhZu5v0WBnI7PeSpej85MgMnELwHkAHH0yGVy9/65eBm9x/+Ej1bHyoEh3Ald+fZTHww+Fkye88eKTodPv3js6N/VefRp8NM0M1SnQAez4D6vMUspBKQroGfTZUG3VldABwRlrI8xIUoYjnCQHw423UdfdvAJAdyQZ6JklWz4afjRb4RQftmgWou0t0AP7XxrUf7K5e/pIz75Oxe+BqIToANVxRMnhSiy8RBDiIsSP9lwCUWohdXoieouRPtK9xncjPrPDbXPyeL9TCzOuOxEXNbar1ws7fCZvH8r/q+QnASafjo8/AP6htEG3QnDDQAAAAAElFTkSuQmCC",
        balloon_silver = "iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAAAXNSR0IArs4c6QAAAERlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAMKADAAQAAAABAAAAMAAAAADbN2wMAAAElklEQVRoBe1Zy2rbQBQd13IIxPYPlBJoIVkU8g1ZBLrIptvmM7LqIpvuusq3dBNoIYF4k0WhH5BFoBACeaya1nGoJKv3jHTksayxZySlIZCB8Z3nnXvmHt0ZyUo9p8fdgVbV5ff3P2PuiuSWJLW8vIyCVV2SJOr+/l5BFhIahru7H2c6CuNKq0Fpq1sjjD+V3JdcaXGZB8S3ktcl/5HsneoAwOI9yd2SXS01xDIO4O2uK9U0afSaaNAGGvpCmVMxqgvq9Ho9TSEwJI6jKaqgH8aPRiMtWc/MwM7DA/AEkhedfD2Q0wZGCO9RV51OR21vv9cyikJ1ePhNQWIME3efMorirCtZCcMQVETyppMvAAttWtp4AIHNaZ4YD8sIhhJtadIou1nFm04LARRo0xMDWthFGAKDQd9OJ8h2XKkwjDJbZgXm0AMwezYg6WehJ2syKCyk00IAYoYTbQaDIwGRGk9ZhIBQiwQQCKksR1EOjGuhy4lOLgBy2kArdpESHki9oLTxwuW8Xw+y/FAH9RjDoNyLTi4ADP3p7tEA0oED2M66iyzqwJwSallVeQOwamqoYzRKT+vM0Qu11gJQZcfnWYSdp0dcvVAZABZIY33K/3mG+fRZopNVRWUAOG1xYNHVtshjXbmhjsoA4Gp4gKkqnarO47qVAWDhIEhPXijz8QB5jnlmGXXfVBlAux2ora13+hzA6Xt09HUhCPN9AID5oNYB4Q2ALgf34QFk12QaSuNd59rGeQOgEZA4eZHMZ8G2EOehvynjocsLAIzgNTiOx+rg4Et+dQiCclU22mDxJlL5qg6a6QFSygbAZ+cZkh2Wz4e4AMDV9rfk9BanErkxcqmsSTphKMFQu4vx02M0uYbZfKzJazVVzkgXAFCIVz6kfvb2pF8j06YUDq/HbKM0ow3bIPHc0Hjj/jMUCFOvl+acsvJkC8t6C23yooGX+AvJkBJClyB0wktNWbK94ITh33z43d2IZez6y729T5BOqXxV+1QrneB8EovTNSFYMSR3Hk1STmQedh7JiTZ6ZPbjC2AhnUzlxXJTtDH1elHInDiPTuY4s9wUbUydvh4w51rpZA5iuUnaUCdkHQCldDKVF8t1ok1RF+uVKUQFkEU6mX1muU60MfWY5ToeMPVM0UmuGfg8ojcnScYchzFehxQnzpNNAdB0wnXi/Pyif3l5g0+F3fF4rK6vb3hgDVdXX62vrb25zS6BBDPPvoV9jVDIXGVn50N+2AHA1dW1gpSkD6nBYOB8SJl6beWmPJDrb7dfZOWWvhsFQVsA6DZ8kuxtbm6mR5bQ6fj4mOV8vm+hcQAbG28NGxJ1d/da1+UavnJy8r3yV2hD6VSxcQATD6TrpNdsvdG4rHp9Npyy1FJpHICsA2vBc6EMyvKDX7ltS86jk8Ue7+aHAMADLg8QS0ud5OzsZz+OYx2dvK2cMyFfZM6YRrrk4c2jkyjUEUke4toR6SE8YANMaiEk4X+xbhMR6X8CILUAEN74IRl/0f6S/Ch/s8q67imL+fq/YNl5UBcRCQ81TrnKVOapIzqeZnoG8Nh+e/Ie+AfRXDBCL71YTAAAAABJRU5ErkJggg==",
        balloon_white = "iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAAAXNSR0IArs4c6QAAAERlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAMKADAAQAAAABAAAAMAAAAADbN2wMAAAEI0lEQVRoBe2ZS04jMRCGAxoeIiESKxZzALgBKzaw5QpcgaNwIBCs2cyeHGCEWJFJ0hIPQaY+p8txOna33d2BGQlLjl/lqv93VbvdTqfznb52Bdbqmr+/v2duV/KapM729jaVoLrpdNp5fn7uUBYSHdnh4eHSQEHO2/zh7Y3rBPxAcl9yLeMyD8YjyQeSJ5KTUxMCGN+V3POsqhdIQA7yYdd5Nc07kwg4YYOGXWIHUITO+vq61eoDigxZ5R0ZsxCiW72YFE5JBAShDRvASNzTNuD39/dNCbCnp6elWFfAWipbaXfl2SAUScnhlEpgKWwgQsIDWjcdhR8d01KJSBsFvVw8OZwqCcSEDeAVkJYF/KYJ1rJxEUoOp0oCojQqbIbDoQUXArm5uWmIMP76+mrrDjG1xVhUOMUQsGGD1pnHqS2GDaBCwGfS819Xx7zX1JLDKYbAgg1AlgBYkK3TiF0E1Z1MQCeuogT8ZDKJ9iQY/ikCAIJEihcaEVBDWgLgs1NtAoDmhaXpq0jUJgDwj4+PlT7QujhlZSMCVeefkOE2vVWbAFvp3t6e8YCGUxUwXl4qoyUk3XqIdKi/NgEUQiLlndAEaIjA/Awckijp5xkAVAywGJkSU8GhJA8oCAX9+PhoFOOFjY0Nr5FQ2HiFa3QmESjqdwkVx7StMtr2lSxAjJxvbgwBzuhjyRy0MNQVg6ZOWxMAit0xoJDRLLqwleU6salfaXnXchFDAIV8dJP6+ddTD7DcRGjS47G2tQyRcG8oxuOxeiATeWxxlCYpmVnL81tJIL/uMDcG+ceNWZUQMI8Nb5fOp9QsgsbbR0dH0TcUlQQK1o0B6SsNp8KcpaYLXgbRqSsdFTauwlQCUeHkGnDrbYWNqzOJQNNwcle+SdjUJuBOlHpSOLng87m1w8bFkeQBd6LUveFUkDFNdiwINNltfHrpW9rPQ4Jl/bI7ccX4WzLlQtJ3AwRGo5FulzysP2W3oWyUmnjANbwQTvJO4HrELA7npTwJh2krYaMKKdsiYMJpZ2enc3193b+7uxsIWHPpy3mJ1ZeUHR8fH5ydnY2yzPBQMozVTq2EkGv9/PzchhPAHx4elIAJm9vb28Zh49prywNW59bWlq1DgONG7oG19/f33ZOTk2n+XGQ3NzfGNXZCjUrrBC4uLiwMgPPgkl5eXrqXl5eDt7c3mlHXhghWpdYJ6P2nbp2ORwjX2rfQISKtExBDZkeS1efPDxsitGXM7k4hQKn9qyBgdiQBYjcI2Z2mV1dXfQmjgXhGvZCK1SvfOgH3vORaPD09hZD1iDvWpN46gRIwJrRknIsEzvs9IaWEau9In0lAQwuOvCt+SeYv2j+Sv+RvVrEbn/I933xp5eHEs8BDzVnDPi/xGmeSje6FUo2tQv6bwCpWNUXnf++Bv+0xPYjtvegWAAAAAElFTkSuQmCC",
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
