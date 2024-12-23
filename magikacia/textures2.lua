local textures = {
    gauntlet_iron_inv = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAACXBIWXMAAAsTAAALEwEAmpwYAAABt0lEQVQ4jaWSMaviQBSFz8gKqWwEsQgGhBkRJOUgpLKxtLBzfoJtaktLC/+BlWBrqSA2Igg2VpIQRbAICQbEQslC7ha7yvP5hLe80w0z37mXM4cREX6i1I/o/zFQSpFS6mXdX9+FTdNEkiQQQpDjOOx+x95l8HGaEAIA4Ps+CoUCBoMB7iYvBnfQNE0AwO12Q6VSwWq1QhAEYIzBMAwMh0M4jsNSn2EpJaSUD/ByuSAMQ0gpkcvlwBhDkiQPJvUZzmQy0HUd5/MZu90OtVoN+/0eh8MBUkqkUikEQfAcolKKer0eNE1Dp9NBuVyGZVlYLBZIp9MwTRPr9Rqz2ewlq8cGx+MR1+sV3W4XYRhis9nAsizEcYzT6YQ4jmEYBlzXheu6mEwm7MnA930EQYAkSWDbNqIownw+h+M4mE6nEEKgVCr9BgBN01ij0Xj+RqUUtdtt6LqOfD4PxhiazSYAoF6vo1gswrZtZLNZBgDL5fLvZCLC3aTVatF2u6UoisjzPBqNRsQ5p/F4TP1+nzjndH//4J4O/0zCMCTP84hzTtVqFZzzL2Ei+rqJQggCgI+Vfae3Vf6u/gDjhPxsbrEDYgAAAABJRU5ErkJggg==",
    gauntlet_gold_inv = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAAXNSR0IB2cksfwAAAAlwSFlzAAALEwAACxMBAJqcGAAAAFFQTFRFAAAAs2YS7L0n9MwtdScA4JgQ+99P67YR++NY5KsR+t1h/fWA6bIeyoAPxnoP7L0u+tta3JYT67ci/fV9wnMP+tZJ/fVl+fGe+tpD6bEU/OlW6YaauQAAABt0Uk5TAP//////////////////////////////////xGlyNQAAAH9JREFUeJx9z8EKwjAQRdF3m1Rwo10U8f8/T8Xu1NJp48RERRGHbN5JmMmgr+IPoPQBeNkLyCfMjRXArxVY5EJ5rDZZCFbAs8csScmBNVwfshKXDBumm9pJUbNyUzqWMGrcDqpj6SLMOu9OVj/G3hsc+0PzBNFrsCh771LDz23v+rEwEdX7iCEAAAAASUVORK5CYII=",
    gauntlet_diamond_inv = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAACXBIWXMAAAsTAAALEwEAmpwYAAAB6UlEQVQ4jaWSX0hTYRjGf2e5ImjBSY3GkBTZLhKiiM5FFFEEpt0I3bhDEV6uKAiRmmc0iYIiDkWglyX9WSZCXUXLqyh2scGCZaRnbkdY4yRjW+igP0pfV5s7mRT5wHv1fs+P53t4JSEE65FjXW6g4V8fNvZrAqDTMqVIJLKyEEL8dfx+vzj4aUZ0zH0UTWdOCq/XW9tJa3WgqqqIutsAOO9yMtHXSyWfoWWnl2ltEDmWkgzDWA2oRh1odvHI3wPAUGKKeDzOeM9hALZ42pkPhyiMTki2DlRVFbtuDVFe/sm3+2PceD9L+fh+vnoOoQA8f12DVOWoNyuKQl/0La2uBtpDAbLZLPLLBACjR/egKArH7j2jks/YAY39muh6cJtAIEAymaTrSRSAV6e6yeVySGOTTE3PoDmWsCyLTZ8XVid4urDI+IYv6LpOoVAgfXUYgOHuIxSLRU48fsH3HVuJN29GXA4jx1KSDTC3uFyDBINBSqUSrVfuUMlnGGnZjs/n42JidkmOpQAkW4JOy5Ssuw9tEF3XMU2TjusjOPftZdu5Xq69e+OsN9sS/AnyQTtLOp3mkkfmZr5sa98wDICVO1BVFYCou024L5wGYD4cQo6lpPKB3QKo/btqtgHqIZMbf9gMv2tNwP/oFz/3/70LR+bgAAAAAElFTkSuQmCC",
    gauntlet_netherite_inv = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAACXBIWXMAAAsTAAALEwEAmpwYAAABZklEQVQ4jaWSUUsCQRRGz25BEBJBg/siRtBLg4Q2D1EUCUI/wh9aEgRBvgRtWISCBbKisKa7mlmRgdvTDq5aVN6n4Q7n8N2ZawRBwDxlzkX/RZCRMshIGeTz+Ujf+M0IGSmDpJUgZsU5PTtBCGFUq9WfBRkp9UUINx4qrK6scXl7rSVTghBMWgnd20hJbNvG/HgD0BLf9w1zEk5aCQ1vpCT+xzvtdgelFKOl5amk5iQ8C6zXHX0G6PU9LVgM4YNsDoDixTkASils246cy3c33yfw/S6fwyFHuWN6fY/afRmlFK1mk9p9GYDY6hqO6+K4LkIIQycAGDz3GY1GmAsLbO/u6ySe18KbeNQQ1gm20mmj7jzy9jKg2+3xORyyd5il3moQ/kjMiuvvmznCuORl8AqA3N7BcV1iVpxB6yky+9QihStaKZWC5PomAJdXRYQQRqfTCcajh3BEMC4pFAoRYLK+FfynvgD5dLvAJsSRxgAAAABJRU5ErkJggg==",
    spellbook_transporting_bag_inv = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAAXNSR0IArs4c6QAAAUdJREFUOE+lk91LwzAQwK9pUtuGCT6riLiBKHv3wRfxn1dB8GUKFh2CPjiUwcZsbdpU7kpCOpf64L0kd7373UcvAfxTAl/8+fF+g9+qWpPLVfa20XejEYMHUsJytYKyLAnAQk6nriu4eX63cb2AJIlh9vFpIVIOQKlv0g2ktwWsAiF5XlB2rAjlT8DFeNgsNIOkzkGIGJRqATgPFUm4nTz6W8BgdI4jDrNCQ61JhZAFdL97yDpVd5TL8bCJIk5lv8y/4GAntSe2MV8s/UPEzLHgkKQxZTQAc8d21vtH3VbgAtxgsydoQwjOoakquJ62v9IC6N+nkirwAbaZhrzI/QAhtmh4o5NTeJ0+2SXdOzyC7H4CRVn59+BstNsIxoBHLWRdTHDvHiAEHXjIAKsxgttnxF2izgzcjAbk2vANoLjvwAv4VX+P4QdlB8MREr7n9QAAAA5lWElmTU0AKgAAAAgAAAAAAAAA0lOTAAAAAElFTkSuQmCC",
    effect_poison_particles = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAAXNSR0IArs4c6QAAAUZJREFUOI2tUiFMw0AUfTdKKCMYFGKGLEOudgGCmykGARK1ORoMFWRopopZppZW4Qh6ZnZLZrcEtSw1TQazkNKkkI9o7+h6HVkCz/x3l//evft3wB/BkotGySbOm5M6k9tlKJzUChZdX1QRuj5mcwJg0yomSnpj53QLt5ePcDyTpVNlJRMGjmcydECCx2Kean0vj9D1pWRLI3LxtsbwNiJRQ9dHqz8QSVhSwCM2SjbdnB1DragIhgHCzY349B9wkxwQDfB8/yAzif/yhfuHHlr9QTxciAoAuWVXAIBgGAjenNRZe9SVeqRX4M14Wu1PLBhcHR3i9cMixzNZWlQrWGRoerZB/GxkaDruqidAD5RuNDQdxbKC6fjz9yvM5hSZxMjvrgmuVlRg/I72qCv+ihSTnwYAxbISiWI8dxbFkkHaKAtJ8b/gG1W5lZxgMFTjAAAAAElFTkSuQmCC",
}
for k, v in pairs(textures) do
    textures[k] = "blank.png^[png:" .. textures[k]
    minetest.register_craftitem(":magikacia:zzz_textures_" .. k, {
        description = k,
        inventory_image = textures[k],
    })
end
table.update(magikacia.textures, textures)
