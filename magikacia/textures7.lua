local textures = {
    wings_butterfly_inv = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAA4WlDQ1BzUkdCAAAYlWNgYDzNAARMDgwMuXklRUHuTgoRkVEKDEggMbm4gAE3YGRg+HYNRDIwXNYNLGHlx6MWG+AsAloIpD8AsUg6mM3IAmInQdgSIHZ5SUEJkK0DYicXFIHYQBcz8BSFBDkD2T5AtkI6EjsJiZ2SWpwMZOcA2fEIv+XPZ2Cw+MLAwDwRIZY0jYFhezsDg8QdhJjKQgYG/lYGhm2XEWKf/cH+ZRQ7VJJaUQIS8dN3ZChILEoESzODAjQtjYHh03IGBt5IBgbhCwwMXNEQd4ABazEwoEkMJ0IAAHLYNoSjH0ezAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAA2ElEQVQ4jc1RsQ2DMBA8EJULNoCCMRggS3kjd2yBYALKSClcuwIU6VKAjZ8YRUqTuHnLd39/fwb+4mQAF9uzBlgDzACmOB5fbC85bjLMAFIrtmVBaiUIKcxN5hCIJ7NrBFE0dw1jJwCQe5F712yXweLhnsC4Hv7HdXsbrOTGDqhVmEqtgiM/McY8LgJqy4K8FRtpryKDCGtLicPvXu/16hdSnBwAZtuH/TBYVImvrnbMc2bbywzcZLb9TvbPa1ArusnIDEKQF81nkbfmWOSTwGVzTPoG+915AS4vt8cm86KwAAAADmVYSWZNTQAqAAAACAAAAAAAAADSU5MAAAAASUVORK5CYII=",
    wings_butterfly = "iVBORw0KGgoAAAANSUhEUgAAAEAAAAAgCAYAAACinX6EAAAA4WlDQ1BzUkdCAAAYlWNgYDzNAARMDgwMuXklRUHuTgoRkVEKDEggMbm4gAE3YGRg+HYNRDIwXNYNLGHlx6MWG+AsAloIpD8AsUg6mM3IAmInQdgSIHZ5SUEJkK0DYicXFIHYQBcz8BSFBDkD2T5AtkI6EjsJiZ2SWpwMZOcA2fEIv+XPZ2Cw+MLAwDwRIZY0jYFhezsDg8QdhJjKQgYG/lYGhm2XEWKf/cH+ZRQ7VJJaUQIS8dN3ZChILEoESzODAjQtjYHh03IGBt5IBgbhCwwMXNEQd4ABazEwoEkMJ0IAAHLYNoSjH0ezAAAACXBIWXMAAA7EAAAOxAGVKw4bAAABx0lEQVRoge2Xv0rDQBzHP/WOZJCiW4dSspQOjgk4uEmxbyD4AoIvIPgOvoDg6iD4BorUudDilKEUxKFoJ5HSIaHlHM6LidKqIMS094Ej9zf8vr/73e+SEguQoOaNTaG0aG1RmCtCgqoKCJsuAHsdaB85AEx7MRvXka4viSMySFCeQE1aropOympnUz8lJGXSctWk5SozN2+b/wwjzoiOruqJaE9kHZNue0LPydv+35IJXwlqclKmcTqmf1lnfX8AwGvLRfoO014MwNatDv+wqfsN5mgU6VgkhhrxBJWMcNCC+8flzMJpL2avAzfbOj8ADMcRYdMtlBNkphVUaBwMvggPgd2zmPZ5LbVwxA0fTpC+A0ENuiOqOkLU4+z/O2HNVKoCGgcD+sdl5GEN6TuETZfdsxjpOwzHEXRHugAEFaTv0D5y9JEIKnlp+Bs8gXq+v0gSW3RVTxJduu4JdHJ8T5Dp28GMm/fkrelXGOM9gXp5uEvq6avvs1Az/voUKoleZ+bkreenJGd03o4NZ1/7qmLxOBTnA0l+7vhJ4nqcI7qQmFDO2468WPt+ypKzyrsPNgIW//OvAjYCLBaLxWKxWCwWi8WygrwBSzfcYaMflwYAAAAOZVhJZk1NACoAAAAIAAAAAAAAANJTkwAAAABJRU5ErkJggg==",
    mobs_adminite = "iVBORw0KGgoAAAANSUhEUgAAAEAAAAAgCAYAAACinX6EAAAAAXNSR0IArs4c6QAAAXBJREFUaEPtmDGOwjAQRSdFUCKqnIAjJGU6chPOsJfgEHuLvcmmjSg4QSIkpERKwepbDBq8Xha589g0YBwX8+bPzHcyun/atr3N82xWZVnSOI6U57lZr+tKwzBk/Kym70dQLgAyULUAuq67IdBlWZ4SWxSFWU/T9PR/3/eqlJAh8wgWgX5+b+m4n+h82VBVVfEBuO4OdPr6oKZpDACogvsCy0CdAlwNTfYD3ufG6Ho+5P7grOcEQIzEaBWAwKUvwBreIJoScAWqEgCPQfYCGIm2J2AY9p49ISS0UKbFwwfYANgISRgMgH3DK0scFABZ7zz//wPAwP5SQfAAXNl1lUfwABBoXdfmPiCVgN8hG5xX5Sn3MlyG2PLC7dn1HYqU3w3Yfi4BYAXIUSevwOoVwD0AzSyGmneWADKO+gcE7Rn/BQBOUE6A6AD4dk8t51S93/NJSgLgQ03TmaQATdn0iSUpwIeapjNJAZqy6RNL9Ar4AXd7/CF37WnEAAAADmVYSWZNTQAqAAAACAAAAAAAAADSU5MAAAAASUVORK5CYII=",
}
for k, v in pairs(textures) do
    textures[k] = "blank.png^[png:" .. textures[k]
    minetest.register_craftitem(":magikacia:zzz_textures_" .. k, {
        description = k,
        inventory_image = textures[k],
        groups = { dig_immediate = 3, not_in_creative_inventory = 1, },
    })
end
table.update(magikacia.textures, textures)

magikacia.textures.rune_absolute_solver = magikacia.textures.effect_absolute_solver_primary
minetest.register_alias("magikacia:zzz_textures_rune_absolute_solver", "magikacia:zzz_textures_effect_absolute_solver_primary")
