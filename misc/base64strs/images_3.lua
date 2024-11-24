local strs = {
    images = {
        balloon_black = "iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAAAXNSR0IArs4c6QAAAERlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAMKADAAQAAAABAAAAMAAAAADbN2wMAAAEZklEQVRoBe1Z0U7bMBRNw16gtBo8TZ1UoT3AN0yITwJtL2h/MYnHSXwOj0Paw4R4nTbEQzUxWFskRsM9Tk64DXZjOwE0CUuuHce+9xzfYztJk+QlPe8MdGLdDwZDjO1K7khKVlZWUHGay7IsmUwmCcpKQsP47OzHgxuVftbLV9ZWv0aAP5XclxzlXMaB8aXkLcl/JQenJgTgvCd5lV45u4siwb6qBHl36FRHWzWIgJINbPWMdqQCwMvLy0madkQiSXJ9fW3zZdpIjmQxXHJPbDOKQXIKIiCOStkAiOge1wb84eEXsw6g8729j8l0OsWtB4nA0a9IXWmDFJGC5RRK4IFs4LUgk3S7XVPnLLNEHwDnNesFGdikDIPlVEugTjYABfnkM96R0rrTgINJJIEL1AsS+c0IOdUSEMu1sgH4/f1PAj7XPtaABkqwIKoTwavtlb7QzUtOPgSsssGCBSDs/0gAT91XwZsO8sN2SgjtJFH0CZZTWgwMLngeAYAGRJDBBiMH+EQg0nTcsNlsFjQwOgL0ghl/6lmnb5SNIgDNp2lqtF/RsvbxqPUoAphx7DQ4sFAHeNvO86jIC+NRBDAWoLH9UT4snwK09hFNAID5CM0IaMO2upYZ6vra1t+nLYoAHOMMODj4bB4fEInd3Q9mLbgigTE8J1DnsxDqyLEpigCcSQBMBHiQuYBXgWnATYDTbjSB2ex+FieTqXMWNUgNngCalji6FyZ5mMNLyy/JKMtFi+1zbW1t7hr3dQJgm2zQp0qM49RBdiVtb8/Pf6J0pgYRmJXg9IK2edIzr4Hb+oa2+RDACsMsMFp4YmR9zp8NnAY/19l+AV/j4hZ81q5uHwIwiJdupL4AwtuTeQHR5wBuVhcywHO3wX1NUNeVbOgLj9JIJJNfWX5rCRSfO8wXg+LlZm5WAATANSD6YRtLti8oTbRF995fKGoJVJwZB9JGCRk5ESDLypi6S9jkTHvJRhsMJcAQw8ZCOdGJJqXrTWRD2yg5k7rNq+7aXhcNdhDArNduly67oRHQdqxy0h0W1BvJRtttQsApJ+1A19uSjbYZLSFtpConfU/XFYFGstE2m0RA25mT09LSUnnY3es+y+R1N3q30c50vS0CRk43N/+SjY1hfzB4Yw47gB+NRnJGmBf18cXF5dZo9PtSCAIDyWg8wfVWCOjDbmfnPWSZ4XCDZPIPvubbQba+/vrq5OS79yHlw6YVAtrR7e1teYkI4LG7iIBw6vS2t7chN6Tx0dER63lLxG/rBI6Pv83ByAnhcSPtDoeDU0RGktdnwzlDjovWCegIwCd3njSdAXn0V2gH/mbfhRxG9Y6kJGKmvtydHGODm1uPgCDgAVeeMRIVLOC+vMWVj+LBSB0DWiegdyTtc3PzndmddFsb9dYJLABFaWFPxVa62saO9JQEKC1wxAeCr5LxF+0fyc/yN6v49U/Fnm8OMZl57khY1Dimy/XibzHv2fjzeqjDtvu/EGh7RkPt/fcRuANaNRfN3ev0cwAAAABJRU5ErkJggg==",
        balloon_blue = "iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAAAXNSR0IArs4c6QAAAERlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAMKADAAQAAAABAAAAMAAAAADbN2wMAAAFEElEQVRoBe1Zy47cRBQt90xD9/RDmnWWLLJhjYSULJD4BFjwBaxZIUVIgARRWPABfAwPaUYCIcGaSOwQLCbZkNDTnky3zTm3fMtlj92usg2jSKkZu9733nPvqUd3G/Mq3a4Hkr7q37r/Decu8CRI5uRkxkKruDzPzeVlapjXEhs2P599eKOjNq6xetzYGtZI4x/jWePppRzziPgZnrt4/sETnYYAoPIVnqXar85tD0QjTja2h64DUtREjzYUuwZlEIF8Seqcni4dha6u9kKVEkgi9c1mi2nWXo9K9DwjwEgwRdEpNgKONgXvWTez2bH56ot3zXw2Ndt0Zz5/eG5S5OpYAlGDNd+me05FyhfZ/ppUZIqmUyyAG7Sh1gR/c4A4mUMcRtjFjFYvvmyzdUSDk1ySVtBQUjSdOgHUaLOCIfSnGEnP03jmKT2KLnpevexsdAWCgI34FylVJBwlDoJO7emkUycACO2gjTX+0dc/mfSKtDGGa0D8KrXyNZ/PpGIBYktlTbZXu0ZQU13sCaJTCADxCgQWYba8YCDo+fl8ii54HsYr75uMp0WaHJ2AALHUZuasRNEpBICvAGX6rVBKA8QImsE25XltSq2q261tprx6amqrj7H1HgCaBY3VutuVW22IzGEA4HTSxXo/RF3XGHpeva/54TmDAHDnIZ/J/9wpPqywu5dUDDOesnoBoNe50/DAIgDuKm07T7fBw0b0AkCVNHq73bntkkBCU3Vo+Lwm+b0B0OA5Tl4/Ak0KmtoInjuRJUo4XZpk9QJA5bPZkfn0wT0Bwf3/sy95/2k+wFTxdpuiaI3nnYlymOzBZsux7x4AypDL/QeHGVPYTlR6Xo2PNbg+vgcAuo0L1+DmeS3yxJsdO0eFNoXn68b0qUcBkIVbXINT7EIff/KtW8STydSVfUPaaOOPGVKOAuArIhh797GHGe9E1d1FR8fQpqSnzu7KQwAw4M/xFNJz3Bg9U53OklpUyhFhtFE+Sc7XhvORqFM7paHpFQKAAvmRj2ldfHrCjTHBGrCNFk7qw5IOu07K3caOtm/IQcHa591/oCuvfLz05zSVnf+aOutt+KDBD/F/4mFuJkevMZMkZ4JWipzm8bBrStn+hRtlAUiVXr/z648fMQ9KIRHwBdGmZjqxh7QpRotntOJLkLJ2SI5XQs+zJ4g2vrhYAAfpVA+nmqkKx6KNymNe1+n3HSwfolPbxLFo48uPjYA/lw5uppM/ypU1HpLj1Z82TiQKQwC00MkXXy0P2W2qkspabwqVIoyp08nv88u73aVWGbmo3UYn1vMhEfBlVeiUJPsFPMNvgIqbptIm7pDyFbSVxwIgdMqyqTld/75eLf54DADLDCfZ0ydPACKD/mSTTN64+yJ781li5AzgnMFpFAr5Vrz3/gfFYZesaPjFxUUBQBb8nfOzH0if0dJYEXAGZbkVSc9k+QTvYxxRQiHcOLLVvfvvSAUdm/Oz77Xs5scWRgfw18XbzgYavrveCoDE7Baz4+9ALdIp7GtDJ+hAYXQAWX5UUZcXOzVczaBEfW1YEdRSGR0A9JAWxQHH+yiTfAPKSyu/vB113f0XAPSAc4bm5vV8OvkNv6Xt+EOGRoHIBqfRARS/Nt74wQ6Ll4AGL9o64tEB1BV4daUWtyYCXI6xI/2fAJRaxMSz4hc8/In2bzy38jMr9IanYs8XahV04lrgopZjOlxSdSTD+VKnVwBuO3wvfQT+BWleE68eD03XAAAAAElFTkSuQmCC",
        balloon_brown = "iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAAAXNSR0IArs4c6QAAAERlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAMKADAAQAAAABAAAAMAAAAADbN2wMAAAFEklEQVRoBe1ZvY4URxDuudv7WXZvsRAQ+B6AyG9gyy9AiC0Cv4QJSCBDOCDAkiW/gTOTIDlyZtmpI0uICwgtYS5ABm53bv/G9VV39dTO9uz09I59WKKknq7p7qqun69/ZteYD3SxEchSp7978xPIDqhkRKbfvwSmVl1RFGYyGRvUFULD2aOf/ljrqIwLvvaCrXGNMP6EyohK0uQkB4/fULlB5R2V1rSNA5j8iMrQmy/R3ZCJgIVwvj51AQHd1EpQwQY6RgSZE7J5COhc/ugKQ6ggb+bTc4IKjXDaUQE64/EZ5JgUlBB5ZACZALWCU9sMeNg43OPd7B/0zVf3Hpv9w0tmlk/Mj9/eM7PzXOxnRyQ5YvjsfAJR0GC2WAKKoNZwausAgrkKG0xLrTD+gAoGwDnUxODJlGWUEmn3mLNd9BzaUdxRCrnGTVWjAxXYHJFxmYVHxpFn4w8OKeITNnqKyNYsaVhWwCn2JQvtSBhyRHOKhkY4NTpACpthQ0Y//f4BwwbpmE3zlejbCGbmsN9nVuAET8DPy+1V5sK4KDjFOMBRIYWSZkYGYALs7x9ao4D5qeBeQYct9g+ogm+cApcpCbbtoqfMgw4rwF3hx064uaHVzYkdh0OIMAq+a41XOp28aklmYzKQrDxF8Hy24JjEyqZlwGnnvQYRj4l6pEXl+ogTSM4A4MN7PRnPe3qHsIgz3Y5Kc4CMxmmLAwuLGUshvPO0MSVtbJoDNBdSjVNX4MOOxNrQuLfEKjIm2QEEfo+20JUMNM5rccY4t49GiaYBaQ7Q5D06fb/4+iGfAzh9nzy+b9cCPAtSYfLJBGjj9GHdyL1I6qBYQ2OaA6QUOxAygDsQU53dygAxHotmG6OVyjQIwRDsQtN8zLp4LVh0aN2Otx0aNswHRqY0tcoAoibX4Dndd3745g5nAhPv7tKRsgafetikGBuSaeWAVgBnprQLMXLIcHwTrzuATBHZ8HcGG21HjAOw4S0VQTlujMJ7DoPoguwstiOs3egB5qkKkG6mMXiVzzbMqbsD0nHbKBTikw80cl9PQ/YAd38ifwZUIUQW6d2GB7vHfLH01qn7j8zlPy+1TIgvIxnqrbTRhwa+xv6kgtrsAfeO7LW6qs7CTMbomgLhX/PpQnhE/fi7n5+hjqIYCGlFSGkQToCITYBkHV9cWrTkdXMKbEpNcRDS4yXFaAvAaT0DWrgr2Gid1Rl130Z+E5zqBLuCjdbfFkJaFkgIwkkPEr5L2IhO1Ns4EISTVl7lt9ltqrrkPRlCogB1FU66T/Pb7DZaj+a3yYDWswKnwuwMCtz2qFVd2jAGWQMBehpV3Jjy6MoBhtNOsTCv96+P3vaunJD5w+WyMKenp+LE2bVefuN4b/xmTt4RiTMpdnuZTiDktRFz+8tb/rBb0ib/6q9XBjVNhKgf//Lrb6g7o64y4A3aKdwJi9CQ4bv0I5b9LZIqkx19/tmnAp0zckZ4L9+W6dyBj/MXpQ1k3tWDOb8vimzwPL98wrmI/NmwVFTPde6Az4Cbc5fWKofZ/mDd6mfDerPLns4dINWwVw44ApElqgGq1au469um+jcckAPObxC9bFm8nA5GS5PhjwzJwjZ2e9nOHXD/Nq79YUeLl5e1n7kjpnMHNtgl0MJHBBwcdrEj/ZcOCLTgI86K36ngL9q/qVzI36w0bzy5PZ+h5eCEtYBFjYPDr5d4jXZk+U3YVvI9Gf/BgYtOxP8+A/8AEwMOr39/fWEAAAAASUVORK5CYII=",
        balloon_cyan = "iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAAAXNSR0IArs4c6QAAAERlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAMKADAAQAAAABAAAAMAAAAADbN2wMAAAE4klEQVRoBe1ZO28TQRBexwGR+NFAgxCiQIgqv4DGDV06ulS0UJKan5Calh9BB4UpEDT8gDRpIgpHAYmAH5LtO+Yb72zm1nfn3buDKBIj7e3sa57f7t7Zxvynq41Aq6r6O0dHWNuh0iIyu7dugSkUl6apmcxmBrVH6BifHx6uDXjzcpvbub1hnTD+mEqfSiXltA4eX1B5TOU3lWiq4wCU96h0KaysWLwozMN69LEOywqXsOCSR9RCBRuI7BNkjsn4LqBzu9djCAEis+WSzBJ3aCaNo388na76bdvahcgjA8gEKApOsRlwsLG4R9vs3rhh3u7vmw7Vk8XCvHj/3kyphuGOrEOyBzDPUiedzwFFUDScYh2ARRnYsFp6wHgUGM2bGbUMUp1Km2rBjM0RpnXtVBlSK8vZjQ54sOmRccADG4nIg3Zs5GH8ZD4v1ggnBFqWV0DDOg4Q6ZTujXDa6AAJDYLNq+HQzCwsAB8dfbFsh45aJjiBIxUN4gEnCy3RhZEgOIU4wFEhgas0U+RAvAco8pIFGD1F9BFZnrH+kH4HJ5oCXhEaUXAKcUDJJxbRs0oRNUQRhc0oMT4rRLUgz6e8Pn+Obcc7UCCoqe5EHbUhMms5ABgh8hkQhGgtmoPIS/SlLppr+ys7APjwZiUn1Jm+QV3AMOAZaDykVXIAEcdtiwsLWQDlnTw88JcflRyATcgAIi/wEUei7bUBiF5nF1R2gI/R7e1MBjYZ4c4bch48tyPgkie/kgNQvNNumzdPn/I9gNv35YcPmYz4yrBmSpcX8A2e9404UsOJeAdsyiUDHcpCMInBWGD54LUFEyO0Wwk2WtgDY/veU3YKMUyw1DO+wJ7o7igHZONCC06h5+/euT3Qwn7w1BfBBtOcY96a2GaUA1p4QhHlN0+CFAzfzXGA53uRLzW8wokU4gB0/qIiAcYbo/BsIz9gqG+AZ/zlZMXRHEdIMX2R2TZ0qkE3K8OEOACB+OQD9e3XUxcvdBPqYE9gOJ0wvlfQLqcNFmtrUrpDsC9A6v1nTH2Zz0ueUPLwdZZMNYY+NPA19o0KatOyHzQQgo8aXxjMwyu2NhzrQBSIFUPPZIJQMCHq9368fo06iEIyoAXBljU4sYGASw6E9GLH+7BptRB5DAfBxskhJtaBzXDS0onX0W8KNlqFn3U9VsoXwalsUVOw0TpiM6DX5sJJT8jwDcJGy63jQD6ctHSPr3PaeKJcszKEnARifDjpMc3XOW20HM3XyYCWk4FTO0k6dKpwcFZ3E09Nk8hLSiso4ptygOE0p9eJh6en/fujEX4q7KZJYs7PzsgXPovG3x88eDx69OiivboDsKY2NQIhbcWzgwN32SVwYDQyqIn4kvr08WPwJaXlFvFNZcDJX9CHjhAutiVlBZkgatHPir0ng4FcDeNPw6HwsiS6btyBL3t7GSOW9jVha7HoPPz8+dimPOhnw4yggkbjDixVBqAzoQxYgu1RPxvKwrLaSS+bFDl2eSLJEYRNvDqV8l/FIxXo6X/DAbng3AGxuHkzvXty0t9aLvl00gbU5Rt3wP7buPaH3d5gAIdqb1rf4cYd8BWotkBri/rgYLeJE+lfOiDQgk+4K75SwV+0P6lcyd+spDec7JnP0KLIy4mETY1Lwu2XcImrmUjntab/Dlx1+q59Bv4AZyAxlqSNdGwAAAAASUVORK5CYII=",
        balloon_gray = "iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAAAXNSR0IArs4c6QAAAERlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAMKADAAQAAAABAAAAMAAAAADbN2wMAAAEpUlEQVRoBe1ZzW7TQBBeJ23jtGlUzjxAn6ISNyTufRHEBYmeKtQL9IJ4FSSEhJDKlQfoA3Ap5QA0jfPrzrfrsceO19m1HbVIXWmz493Z+f08aztKPbb7jUBQV/2z5y+wd496QE31+30QVnFxHKvxeKwwFhomRt8+f1pZKPCVXm6VzrpNwvhL6kPqtZTTPnj8l/oh9Rvq3q2JA1C+T33AUeWxKhMlFsJ5e+pKNsgpr40CNpAxJEMvyehBh6Bz8OSAINTREJlOp7SctwvO3d7eprrZWZpA5JEBZALNC06+GUhhk+Ae1yoMe+r05I0K+6GKokidvTtXk8kES0lDnAzK2HCxvrdYLABFNG84+TqwAhujN9DG98NQY4EhxCN44jiw3eSQOTByCmlLJquGtQ4UYLNPRgWIImCDyAO+Ya+nJhR5WBJFMvKrquEU9vNY4NABIp1cFNbCaa0DpGAtbGD8+YePajKF8YGGDwyUDZcotaaxfchMrryyLrA5wcnFAR0VEshpJtLAARkAbNBgPEe/aLxmoB/2ieHE9wOvg4U668lXAcEkyY68cKf5hjQRpDDSVhNxm/F52VkG8vP+Vy4Z8JfaYMd8PkdUnCXUzICRD0joiDM2nNVWMHoYDym1MwA9EdV6ODBZU3kqzG28VMsBGI3TFgcWYx4HE9ONrfIQUMsBIz/Wpy4bzaObbnPDu/FWczVwAAcZnbwJ/sWjgVVjBu9Y138ro8dCLQdQv3t0+r5+9VKfA6j/Z+/Pcxkp2gDj8T6Ahv1wmM8BHot7XK5rOQDBCDwygO7T2FgeffaW8dZ2ABGNxpGWiSdQWwOfaRls2jIecr0cgGLGOqrQyelbnQmcwt1uJ70fEov1eWSDDfM0Hb0ckMrgDEceN/Lurv2dmCPOo5TTlHZxACD4R51rH54Ymc5F3cCFMQMWb9hg84g6GnSyMD1R9uPiAATilQ9tmLw96SdGhhOXUh4N62q14XmMJCe9FM8/rCt9vUyZLEQaSct6bppeNPAS/5M6RsJ9F4NutmrEMGM+HnMOzGY8jag//f71C0an5pIBKcgKJ+C7LANys4X2ho2U4+sApxgySuEkhRfpXNSzx2aW6QwbKdcLQnJjFZwkn6RzDjSAjZTpmwG51wonyWShG8FGymziAKce8nJwkgok3aTaSDmSrg0hKaQIJ7km6XlLsJEym2RAysnBiapRetjF8ZKPo9ZgIxW35YCG05JK6SDcGe7ubNOnwoA++i7Vr+trFS/J9kCNgk73MO5sU7WBL+mJK+3xpluBkNR6fHycHnY4G66urvi5Xx9SFxcXzoeUlGuj28pAKj97YDOfEM1jk444grV/dHSkL4gekTNMp/t9idYd+H1j3rq0IZSB5dZOYlO8F8wmtb9C2xxr3YEsA0WV+uXZ67NhUULZdesOkBLAAjgHZCREcJ1WJ6JbaZtwgA84USCCOFjM8F8aIMRZeJgOJP82rvxhRzdvMSMP04EKqxha+B4LBwdtVKRNQMjmA0ML6zgrflAHrP5Qv5e/WUmve0tqvoZWAifcC7ip6Vkje8d2l2g4G31e91W2Cf5HBzYRVR+Z/30G7gAswv54867ZfAAAAABJRU5ErkJggg==",
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
