local yc_top =
"blank.png^[png:iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAAXNSR0IArs4c6QAAAf1JREFUOE9Fk01uFTEQhL/u9psg7hCx4O9xUCSIIv7EikMgQYTYELFjx3mivLG7UdkPmNHIMx67uqq6bL8/XdapQ6+ECvY+MAIygJo3OOaDYnBwh0isnAjDfn28rL1D2zZGL+57Bxqu7QI1Ew4ZjfLiIJAw+t7ZorDbd48qLBgqhDOyMGxVn3OJ+0aaTwBnxyppGKPGAmjtAWMMLSXFwIwsI6zITAZtCiGTiIZ7sTVn3++wn++fzkL7ABOD6lSJds1nKTCRIwe0Jnmd8JjS7PbDszqdBuWBpVPV50b91wKBmRklfhpNPJkMD1vDfrx9UlnBaS/MpT7/eZ+jGJmUGc0NlzUaxclEKbHvb46lPqbJLsnQGoEVWc4Ya76ykDJtwoqLFquN366OFV7cD/V/tWwN4u9gQWafAD71C3jwcGsT3L68elYhNhaT4tjFZgVFkmYGZNZygYvN6BW0s9l2c3WsktsFpzFo4asbYvSXiRmhBFLsvdgi8IPPgvb55eOKQ0OGKSByus+SMs2R8EKtPYdSYxgRwenuhH19/VwE/sVW8fVYPZ663UnZeHZYrISWVaiw3Vy/WH5pUm0561bw5iWaam7lXKNMTLPVNcX+5vq4UroOw/n0KTznzfPlHCpNrWMygSb+16tjqaqq6+/5GK12TgybrKZOfc80/b/+AFdGO65kqTQRAAAADmVYSWZNTQAqAAAACAAAAAAAAADSU5MAAAAASUVORK5CYII="
local yc_side =
"blank.png^[png:iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAA4WlDQ1BzUkdCAAAYlWNgYDzNAARMDgwMuXklRUHuTgoRkVEKDEggMbm4gAE3YGRg+HYNRDIwXNYNLGHlx6MWG+AsAloIpD8AsUg6mM3IAmInQdgSIHZ5SUEJkK0DYicXFIHYQBcz8BSFBDkD2T5AtkI6EjsJiZ2SWpwMZOcA2fEIv+XPZ2Cw+MLAwDwRIZY0jYFhezsDg8QdhJjKQgYG/lYGhm2XEWKf/cH+ZRQ7VJJaUQIS8dN3ZChILEoESzODAjQtjYHh03IGBt5IBgbhCwwMXNEQd4ABazEwoEkMJ0IAAHLYNoSjH0ezAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAB1UlEQVQ4jUWTwdFTWwyDP9m+CRQBhdPMq4ASKIKBnyT3HlssTt6w8M6WNJak79+++FywPODkWo1ImASMMRAoGtMcEZCDHGSKep1wLajbJ7pND0ARgG1QgGG44zDQHIhrLWRTjxWkkue5mcyBEIMxCR4ibrAhacysoVQ8uwkA5YEUWAHesttCAoBrhp5mzgvPgTjI445tKnSje7hab2ZhC2F6jCSwgWFGxJhWc12Q8YkYidc1NMIEIpDnzS5mAiEwVIK5wOZczYQo91BZXMu0BgyS6GbPNJaoECkggsFUJn0uquNgXhdjGEBABkgmM4DCCLdZEu5G2s+LFMWCyORcjSyQ6Nnu40IRTJ9MQ92LcNCIiMIjYo0Zg/LOcb9xtTiXmQE0mAWIKFjd1BFE3ukxa0xEBo4iZ/j560WlOO6fmYFp02s/NLM4Ej4eFzmDo4gM4uP3k/ZwznDEzsDr8QdkMm9U3ukZnq9zK33vtoeP30/qvx9fYYHKTDd1JBpQitm5JjJwGwesq4lMvAQF9XyckEO+gm6z1pAJfZp+JzFPyPjfWpM52/JHUAOoRdtYYi3vK4TXeiPUGxwI0b13DdTMbl1qW5hprnPLM/XuArBEHrsj9r+Y/wU9Cl0gXWl2UAAAAA5lWElmTU0AKgAAAAgAAAAAAAAA0lOTAAAAAElFTkSuQmCC"

minetest.register_node(":scp:scp_yellow_concrete",
    {
        description = "SCP Yellow Concrete",
        tiles = {
            yc_top,
            yc_top,
            yc_side,
            yc_side,
            yc_side,
            yc_side,
        },
        groups = { dig_immediate = 3, opaque = 1, solid = 1, },
        is_ground_content = false,
        sounds = mcl_sounds.node_sound_stone_defaults(),
    })

local sc =
"blank.png^[png:iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAA4WlDQ1BzUkdCAAAYlWNgYDzNAARMDgwMuXklRUHuTgoRkVEKDEggMbm4gAE3YGRg+HYNRDIwXNYNLGHlx6MWG+AsAloIpD8AsUg6mM3IAmInQdgSIHZ5SUEJkK0DYicXFIHYQBcz8BSFBDkD2T5AtkI6EjsJiZ2SWpwMZOcA2fEIv+XPZ2Cw+MLAwDwRIZY0jYFhezsDg8QdhJjKQgYG/lYGhm2XEWKf/cH+ZRQ7VJJaUQIS8dN3ZChILEoESzODAjQtjYHh03IGBt5IBgbhCwwMXNEQd4ABazEwoEkMJ0IAAHLYNoSjH0ezAAAACXBIWXMAAA7EAAAOxAGVKw4bAAABnklEQVQ4jUWTQQ7dOAxDnygnaK/U7QBz/+O0iSV2If9fbxwEikQ+MfH/f78MYBoIuoq1FntvMpM5pruJEAARUNXc943ahd1gwM1aCZi1kgiwm+4mM+luwFT1eYaVCoKAgG6wDUBVkZlkiu5RIAUQSGAHe28kiT4KpDjTphDM++4jf5pX1dcGgGyTK7GbmCr2nml7b661iAhs6Coyh0PmWBSAy0jJ8zwo/zW7r5t9JoJZ183nhERVs7qbY5u1LvauASqoA2oka2AzVt7nJSLQAPK8fJ9T/Q9mVwFBVZO5TrMgNBB0XQt30V3fvc8d2EbHa6ao2t8mOhT1PC+5Fvd9020yxd7F8+eh2wfg3LPefZSZzESZedbTSGLvFylY1yJTpD5pBEnfRkphfNaYyfu+R9p84C4kUZ+7iud9sf2FHgTrk7oPHDR+twfkpO3EO/ObFaXoqlEgJT9+/BxvPTkPwe/ff5BEppAEJ1C2cTdus3DQXd+oZiYEXOsCNIX2bKWaUBASNuS6UCiQkjq/qyJxw/vuyQMczxP5iOEx4Dd/AUogM9qoptgSAAAADmVYSWZNTQAqAAAACAAAAAAAAADSU5MAAAAASUVORK5CYII="

minetest.register_node(":scp:scp_silver_concrete",
    {
        description = "SCP Silver Concrete",
        tiles = {
            sc,
        },
        groups = { dig_immediate = 3, opaque = 1, solid = 1, },
        is_ground_content = false,
        sounds = mcl_sounds.node_sound_stone_defaults(),
    })
