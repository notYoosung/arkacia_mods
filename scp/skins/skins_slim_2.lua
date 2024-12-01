local n_skins = 28 local texture_list_default = {}
local texture_list_slim = {
    ["flower_crown_pant_tears_c88a8be708bcaa05"] = "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",
    ["fluffy_th_mariiposa"] = "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",
    ["happy_new_year_2021"] = "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",
    ["holly_jolly_christmas_d"] = "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",
    ["honey_bear_bee_b80558ff4b834410"] = "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",
    ["hu_tao_wqtermelcn_4febbfc99fc9fdf4"] = "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",
    ["kinda_christmas_4"] = "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",
    ["kujou_alisa_alya_mikhailovna_28t235251_702_17574218"] = "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",
    ["lo_fi_18328111"] = "iVBORw0KGgoAAAANSUhEUgAAAEAAAAAgCAYAAACinX6EAAAAAXNSR0IArs4c6QAAAERlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAQKADAAQAAAABAAAAIAAAAADfYzX9AAAHc0lEQVRoBdVYf2jVVRQ/3+29uR9vm6ayjdKsNAxBsUgpwQiUapUVppIKWiImQlOjOcuK/FFqik60kgi0P4TC9UfgCrI/lNRM+mMroWChmOFE19z29vPNfbufe7/nvvO+727PBct14L577vl17zn33HPv93mUASqmTfMh0thOFBuhUYp3e1RaYBQvxHOthbG5nRq/1pVnaV//cdazgyFE5t0305fz3+q8WYNZ07WuTkILAyZGi0U83Xgclhuq8YopU7Xzn52v99AwP2i3Ml/GAGDn0Tr9DmsPONOZCOcZJM60oeqx87ANx3kOxpnHdFdvlVxM0DiSSHsOQp6Xb48DZODw22tWAbWw5cBBivf6KQuzzGGEZMwArBVpz85jDFweBTifW5qf0sIBgd5whEimRWHnseMADgKP492gmSJYkBOlvmyirJvGYpfqZDE01OH3m/EI8C2ApePcA/gGAL5tyzp0hABIaO9J6GFs3vKMc0i9/xrPmAFyQdJxSf8/4x7vMHbXdc/fqnOZ9PvjV9fV3dYM0UWwMGYSge9xOM004KjmePBwgzOgMbBsf/qZ+GzndvQROFKoZsbuF8ai1BbvTWZC4OSOileda9tQ/Ymmsz6RpwMX7zXnn4PEfJd9XLN8bzsnUURkKQcR62PIlD18hZeNjNLWUz+nZNqmWQ/5V24kyF6D8vEicZ4sUy91JM56kiZx8LEYluMjiTEcQIPzcBwLhtN60xSN+ayLnm1xH+ZJ++BFcM25ABMy79HKt7TI6Z3bdM/j6WPG67HcFWmL9SVN4uB/0VDn8WLRS1usD5rcbWQMHGG+tClxzizYlY4zDn4E93hbvEufaaQqYO+OSsI1tnjdx3q8auEr9N3Jb/RDB4R7S8to7uyn6MT3P2j+ti2r9TW4dsNOPdaprxbNb4SwfcnHc3XrKfcHE+tX16XzEZDwU5cdwyIQNOZjfhlA8CELvq5+WBCiydGH812Nybf/+oO7qOWF05Y2Y3Ixrd3/Pp14YDZsGbp6CQJgw+yMzWodXGk/zNeKga5caKYvOhcfZ33RRJUdokgDB42vcVnEU6KIrygAXnBH9qzWOP/099BhPrJF6jNd9i4+O4HdYFzq/BvcZQs0OT/PlVYAnp7znu8X55h51ZnYt/V1jbc2tej+wWlj03TkIsvnf6C33mvpsWRrz1IUgvNWpFqram3BWPW1NRsHtr/c2IfOsZWmBsWbO6jwpZUD6qkZnDCol6DTgoN4vf64g0o0ZuocJ/12Ep0BuJj1u15T9tVkHRjsImvfmJ+iUv5hjR4jMy5FzxM1pbCJ1FTjE1NCxKEf2nfA0E81PGfwcObDS7sw6oImZceTGTCuZHpSDGdWAXbTdb5xBFwZkOkIOOsGaoULgjWksQL52kO2lviPVPxGo2aWUO3iUWl1InJpwhVtoy/PXGMYeHQHZXV2UPBpr/ne5WRRA6FEtXNKd1zz3Zovf0ZH82jtgW+pKdGnWifdnx/8gyqFJB4s2qecZFBB689JFM+BeCisA4P/4rkeOvpwjheRjksd0E/OmCpJFn/slwa6qEcqaM2WbJF78nupNWFukuZEKxVFo4SgDAhwSgGCYG8IdhJ9f5mgtTL/tFyKU/mRZp9q1PfL/OS3TeTsXLeTfnuCutvMR03YvNRZeNhkkJSB87z7E/NLqMDrVAHIob+lUBhHAsqd44RUgUH2+XcGVzP0lJw8LtKUX6jkgmAGdO9M9WS/vOoDaqGlVKyICAbVmw+5SPiBo5UwufqHp7vN3P2BIdtpHcioEuFaCDuPXR8dzaJ23/xb5JKFUb3rpQphZ5EFagx5zYPQX/hJAo6gCxqRLZw5IYHdz+RRbKn5B6tyv2FGiCMthZVjeA6PKEz9m4tFwCsgxVO6roUgJ3Dui6KmbnBGlLGBUN+IMeptYE+P1RC29y1za8mnuhKzgD9nAbEaS/J//PU6xUbGqHL/HqrdvpHUY41okuFH9MRWNolgl+PqGLjAZk3ykkgRQ+Ejwpk3R4GoL4WPwVVJwfkOb0Rgu0B9y6eB4nWlEQ3BZmeIH1P/dUj4qKqSJqhgZGE3+2uoAa4m5eFIuKHwIQh8FIA3dFxNkcP1yU0vLBxMdc51kEAPt3CwpGfghWxt3vUpxeMJWv/cAkI2SHC+BLmwff4ESsbA4HoHnHnzZX18vIKo/lLko7ToaOrk1jKKVlAAbWYomsu21lEOsk1rg5GQ8yCvWPwsVW5S6a/eBnj3vLN3jQ4IeJGFX6VXcTAAy768ZpDQr3+XqMghHoaP/1RP4esV74pxlHwzyIJoKzffAuLKQ7YNBvqTX79qAQJAx46/S+valliTzgw4dLhKC1Q9v9kKSkRXWhDEQiX/Zos6oaplF+dqMsbyUSVlNa6qNq46FL1GfImKjLD1RijFr6htNqYF1aB+U4JiZQOdESMXb7uhEa/hck/aUxgc/vw14um/RaPN8XitYncKEzurP3ZQByXkpX7spKQ3AsmPHXY+uMr4k1eawi7jneICHDsEzXtyiXz2+rO2/0nF42OUP8m8SvEKhP4/c+p7aNNuodkAAAAASUVORK5CYII=",
    ["mother_nature_tinypaykitten"] = "iVBORw0KGgoAAAANSUhEUgAAAEAAAAAgCAYAAACinX6EAAAAAXNSR0IArs4c6QAAAERlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAQKADAAQAAAABAAAAIAAAAADfYzX9AAAG60lEQVRoBd1YbWjVVRh/7ry6V6fbvHcvzoRttqGTRmiCps7EyAIDs5IFoRgk5ScFoQ/2IT8EQUGRYBBIQWYmRkJaiToTtTdipdhCt/B1euc23Yu6lt7O7/z93Z17du69/7vdD9UD/3vOec7zPOc8r+ecG5AUsG3LS1GQNNRNl5bW89J84mdpnD9nxNglBrSfH2oJuOYyidt/8HW9R1vmk8veSLl20Gayx1AcAOVdAGMkAswpAySazhjej6KJFktpADBC+fa2c3Lh2g0tB/3/C2T5UQRRUFVdIw+UTtbk6AMYHXrwH/3xZQBbN0QAo4BtTm+7mB94OGfzpzNuvbrbmd+Q8d0v2xPO+V0jZQq4cp8RgDn0a3JVauQWW2sqnI6UZguf3rD91GlBkSsoqZBwRbHUlT0XYNHr77qSnjAHdUoDMMz3fnUorgbQCJRZmJ/Nrm57BwbjxqMdQHEoyo/KA7/o4fUpq3yqdVOmACMACrPiU3kYB2FuK49FgctECphKotpDcbQmPpWSyeYDxz/ZGpdHVBibh6I4y5MB7wSIEBqG9IwejCmXc5T/6tYP47yInEfYp+thpkm6hglyY9wQNk0cN0vPc8zWNM7Kp5aKbQRbDvmStWaOm3SbmhrjHPX2zuY4w4EWaQIDQobJm6yfMAVsbyYTAkXxkccV+sDxgyzS2nLpSRQ8ApQHvfnZBuFlKHKlm2y+2lgR5IZcXoOnn6gf3hAkf306vYUoP9mucKzBi6z2ppJMFTNlNzWJjgo7GtKJgqDpLYQxDWDiI7cnyMc/9cuLcwv0/tEXmSDh3L9ihc5UEH2T31baNU/lq2bX66PO5lk8/5Ho0RM/Bha8sCXAvmkgm96vEXQE4IqLWx5y2ATgoXxjRa9c7ohIZeljenpGoEWmloel+UqhyH1el8K8OkM214AARBRx2ChwDF1X/toehiHAYwPSACmEKEIRhVEZTaDlWlgDcyiYsRSgMHOjxDWuelma93wQO+6gvMa99ylJdOvijSNwDFDxCdi0CTSgiTP7rnnWAt4XYAwoSz6sx2gDTcAOI1MJ9lfNm0r+uHbPD5fjPEt6k8iF4zzm/DyXn13aELXpXDjKZQsFGRXEmS3mRoTS0dZTMWuBuCwwweSR2traETwmwZoNyzR/drH3cuTcYLf3kFq74R2inO3iutlJ5b+1c4WW39baIWtKHhTcOC9d65Z17x6mvKT8JGI7IgU48W9t60MNemswQCYg4T1gtMIHfu8UfN3Hh2RlznT9jVaWi+90Z0scGt4fC2TcAGPZjF9e0wiVpfH3E78ySBewc54Tftsd72/UpF3fHtRtzjQvRDHYuGKWztG9d84La4Amcvwkqhkz5+cKwx6K93WO09yRrksjpIRLKmVi6K7Gb27ax/mkNSGYW5TYgrd73OHl4il5fJnQCDjj+2sGZL/cEskXCedXSkS8DbsMAeWxeRNAD9pQeZ4UTKqQtpvNuh8qV3+0/Jb8qQ0ev5DRIggjaOge0jWgep3nDQ9ZKRfP4gY5EkzPDc96Rque9Ix+5FSXNGojcN5lyIvd/TIzlEsSX602QGH0uCbuDSzwxWQS2aELZVr3/Rn7/xDe6Oy4pUMzu+uGyWr0vSs2PUf6SJfI+GPHpGDhQm2EujNe+NdJnvRWeH1DiO4Wdqo/ZjptbOJx8O6uzSLPP+0x0xBH/pC7kVY51+4+amZWlcu4cJ2mYeiaOYkUMAGKpQpbmx5GoGwYoUrtsedMmybj2W/ysI+i6PqDhvM7jqyOrl2yK1YXgkPKugDexdEPL6lVv+p7czuGGha8tp5d6fnsS7lTG1Ik6jv2jcZjsy3bvpCCOSrpFeTNK1I5q7xxH7zipMLaUbxIk6gtUsrjCquNoNYeLUB5mzfId/fsvxdJ/rR8+b7jgDYG8KbSYISRgKfR0DcVqlg9V6qiNXqNgVDEXkuP6VVzEsZh+AMP76Paa9nqtqeVV69EGH6sYHofsrKqovOk9EK9jM/JloGLAzH55iMFiuM7+9HumBFouBiD0bk6RSWvA0xjOaYTovBIyoTyWMCOgqzr0fEymH9Shu4Myu3KyVJTtkIXHBBTcfShPICKF957VPDZAOXLrpfY6LjzG4YwP3gbXncBog0vOkadiyYdnB0BwayeA5JXMEWd2CeVnOVaVsMsL9/7+vpisktfWaL7Ufk1TnH7OMJRJDMUqb6wDCs1UZULVPVE4F1whulBB9k8BdCOFWzlIS94r2i53FJGQOsHAjcfEpmYnBLeRa7z1oYcx+PFNhal8JIkMnwZ8tLFO00yoTzXstug9nJQhbLhbZvIHpuRYc9hDEURCbwjwPOJlCc92mFDJKfHMYfjzn4IpToCsYYN/wAmP12qdZMY8wAAAABJRU5ErkJggg==",
}
for i, v in pairs(texture_list_default) do
	mcl_skins.register_simple_skin({
        index = n_skins,
		texture = "blank.png^[png:" .. v,
	})
    n_skins = n_skins + 1
end
for i, v in pairs(texture_list_slim) do
    mcl_skins.register_simple_skin({
        index = n_skins,
        texture = "blank.png^[png:" .. v,
        slim_arms = true
    })
    n_skins = n_skins + 1
end
