local textures = {
    stone_block = "iVBORw0KGgoAAAANSUhEUgAAACAAAAAQCAYAAAB3AH1ZAAAAAXNSR0IArs4c6QAAAihJREFUSEutlUmKAkEQRaNUnEVxwoUI3kxcuHEv3sAT6NJhqV7KYSWOOM/ZvIQQF40NVgdImVUV+SP+/5HlyB/R6XTM8Xi0bxljxHEciUajEg6H5fl8ymQykUKhIOfzWfb7vdzvd/F6vfa9UCgk5XLZ+QTx8SGJ3W7XsGksFnvtw+Za0Gq1kmQyKR6PRx6Ph0ynU0mn07aAw+Eg1WrVXQHtdtssFguJRCIWdLfb2c58Pp/9JRIJ2Ww24vf7LSiswA6MEKVSyV0BvV7PBINBuyEdwsZyuZRMJmOluFwu9j7PVSJlKBAI/I8EdETABCAUAQhaK2gqlbIy6FrlqNVq7hhotVpGDUURUIwptUvkoLBsNmvvKVPoH4/HpVKpuCug3+8bgE+nkwWgM/5rxxQDI3Svhaohx+Ox1Ot1dwXgATUXY6YsYMB3RpBJi+CKb5DjTxMy59Co+ums6Zpuea6a5vN5Wa/XgsHwAOEm32k0GiaXy9nNAAOIjqGYNV3o9Xa72dHTAHg2m4mbfFsAZtHDQwEBoRgCNgCbz+d2jeEI1tvt1prt23xnMBhYjTGTjhBguH00Gr0AYQgGcDnzr4H2bvKd4XBoXQ6VgBLQDCCnGyxcr9fXGa9ngBpO2fg232k2m4bOcbh+ZN7HCf1xNGc+VPPxwR8UqOeBq3zOetVYPyAcItyDXjbXuYb+34zoJt/hawftgMMCgARdI4XO/vvMF4vFl+7qhW/zfwAF8fiIMMsEWgAAAA5lWElmTU0AKgAAAAgAAAAAAAAA0lOTAAAAAElFTkSuQmCC",
    pumpkin = "iVBORw0KGgoAAAANSUhEUgAAACAAAAAQCAYAAAB3AH1ZAAAAAXNSR0IArs4c6QAAA39JREFUSEutVE1vG1UUPfPp8dgznjhuHLdxkyaOG5O4rRIpQoBUUCXEAoQEW1ZhQ1gVfkNZoG666hbEpgsWgBQhxALRFagQihpc145D4sROjJMmjj9nxh4/NG/qaZIqySJ9mzdPZ869555732Nwyro3FyDnVRY1g9A/7d0+Kx6Gfm9Wu/R8HH79zh5zUooTQZtoC7CT9ZadrLd6Ak7Czyzg/s0+p3QAi1smZiIipOg4tnPZQ5Ufh09/uftyHMjutvHWjQa++p7F28MqzsXiEMo5ZLYt2o7j8DML6Dlg2/1zvooP4wHUTNcUKKJT4HH4u3crZ3NgYV57ng1whs8kGJ1KQM9n6BAeXEfxMztgCzg4eOcmXsH2k8c0ce8mnIS/tCHs2X5eYd3kPQG0Bc/achQ/1YF7c0ES7WdgmF0oMofSXpv2Mxn1YKVkguMFBH3kED4yIIIVeSyvN6F3OBzlW11gbFCk/NNwZmG+n1yMCPh3U8fVuIZ0EQj7WhgIaygWd1GuEFwIcfj41g5u34xga6+Db34o4c7nEdSbHZS2DYxGZRTKBhKjgRf4p+FUQGLEg0yJwfhAF+l8E6qXxbWpQfz9TwlVg8Pvj+p48FjHcIRHKMBi8YmJkCbgk/f9qNQtJGN+ZMoixkMGlos6ZAEYuzKJlUepF/C/CgLCYs2Nz/z42QWSHGaxlO8iERWwlN1DUOERVHk8SNepE6v5Kr77tYaZCREBP4df/mzRwf/oHR80H4eZyQCWNjgkoxaWcnVawEE+jb/BYXrIxP0cj5haR7MNrGwaYBY+1cjVuILF1D6tJLXaoHt6vQ3VY6HSsOCXRRp4MMhhudCBIjtXO3nJA6vdRTym4mG2RQuwHUiMyEivNakT/+kSXrvM0/iToz7YDsxeslyc+WleJZOXA8jmqtCCEu3rxUHJFbD11MQXXzch8ASC4DwJAu/c/PdelxAO8XhzWqMC7Flx+WtOK23+q1c0Gr+v34tGR8ZQn0EF2Djz7ZxCZqcCSG0QhJUOvALg9fIolC3IEqGVr25aNOHDZQMfXNfwW6qBqZiM/HoLb1zzOC3Idw/x01sCHWabf2M26AqQeELjrxVbUBXBEZAc8yGdbyESErHTEOBjdfdx29lvo4cnhr3IFgwo0vPXdb/ewYRt+QG+zBnQGQUSqeFpxaT8PzINjA9JbvyaTuD3svgfEkQDHLbbz1QAAAAOZVhJZk1NACoAAAAIAAAAAAAAANJTkwAAAABJRU5ErkJggg==",
    cake = "iVBORw0KGgoAAAANSUhEUgAAACAAAAAQCAYAAAB3AH1ZAAAAAXNSR0IArs4c6QAAAVdJREFUSEtjZCAArl69+p+Liwurqm/fvjFcqvPGa0Lk2geM+BTglQRpvH///n9uOzsGhjPn4Oa8fvOKQVREjOHrty8MJ0ocGQS52Bnef/sJpkEAxgbR1HEAFw8DzFJk3yA7ANlimBqqOgBkGTcXD8M/Hy8GphcvGF7v2MEAihpYCGALZpo4gMHECGzX10OHwDQ2B1A/CtDSANgB376gOAA5DdAkCkCGgtIBKNhBUQFzBM2jgObZ8NChQ/9lZWWxZtXHjx+DxWkpzwhygIa6JlYH3Lh5HSxOS3mwA0A+BMUrzEJ68hmXByv8l85fBPbp04lxYJqefMb1Ecr/f/z+C48CDlZmBhj/w7dfYHEBLjaayIMMZdwRq/7/++8/YAs4WVnANIz/4uN3MF+Cn5Mm8iD7wA5ALjhgFQpI7P6bz2ApRRFeMI1e2FAqDw6B6Z5ScAdgzQo0FgQAUXcokBjxKnAAAAAOZVhJZk1NACoAAAAIAAAAAAAAANJTkwAAAABJRU5ErkJggg==",
    barrel = "iVBORw0KGgoAAAANSUhEUgAAACAAAAAQCAYAAAB3AH1ZAAAAAXNSR0IArs4c6QAAAcRJREFUSEu9VU1LAlEUvQOZiUNafqG20Mg+oEKCKH9Du2jdshZt20f7/kDb/kX7oCAIoVUfpAtTTC2NMTOFF+fFHZ7SjIRjd3Pn3jNv7nnn3vdGowG2tzUrXG6dOm2D4GFhfYyea3VaX4zT+cUjReIhiQf0KYm/dzo06XJRwD9Oh6eXml0JWxALD7ZXBQrCvB639D59jLK5BqWTPklgOuiR+ddqq+d5M51whgAKFStNSQDFVXsqfNCEW8gUVIkH/CbRZqtNR2c3wylwvLsmeOe8e5UAFICxCio2PxNxRoFwKkNUuqZYyGt+v2F0pRpQAL2G1epfUo3P9s+m8eyoAijIhdESELJTAO0YmgCGkCefW4HevhhdOYQYxmTIK3dfM94IsrMajpyCk/2MUHfOCsCDiEpKPSnAYAMVwDkH6/tCWbL/b68tL82JSDBoDle5WiWO8QxDzHkrnD/wV1zb2YiKVCJGD/kiqR79xM3Wn+fYKVzDkGGIWPpcpSmvWgwZ8ohHiZsK4P5GoatsnlYWonR7VyJcpYhZGY5/wwett8J7ZoB7rvbdagb638V7duutcMsZsOq903lJAJLyjwTSs8SqHxX+DRua2qWe9lhAAAAADmVYSWZNTQAqAAAACAAAAAAAAADSU5MAAAAASUVORK5CYII=",
    books = "iVBORw0KGgoAAAANSUhEUgAAACAAAAAQCAYAAAB3AH1ZAAAAAXNSR0IArs4c6QAAANNJREFUSEtjZCAAYri5/+NTskTWBr8JN3Yy4lOAVxKkkSgH/PmJ3Q4WdgaGUQeMhsDICAF8+YxQCBDKZoTKCUrlGT89PYtS0Dx/+Q5spqS4ENxsmBg2cWR1IHmQWmSxLDU7sDmLN39FcevH9wwM4TGcDIz0CoHX//5hDSxGcVdJvEUtpUFMSD84CtCDHRcfZhi2YEe3CKZGNcEHRerPjz8MLBwsDCAaBOgWAjAL0R2KNRHCXI8tJHDJYUuAIDE+73bcsfDjMwMjg0EIfdLAj89YHQIAwdB8Sj4hDeQAAAAOZVhJZk1NACoAAAAIAAAAAAAAANJTkwAAAABJRU5ErkJggg==",
    bush = "iVBORw0KGgoAAAANSUhEUgAAACAAAAAQCAYAAAB3AH1ZAAAAAXNSR0IArs4c6QAAAUpJREFUSEvFVctuwyAQXIOtRrn10K/o/39KviKH3qJExlDNwljrtIZIIQoXP5aFYXdmGKQxPr+/UmtOLf5zOg+1eDWIRAUQo6QlyXic1rXCZZZh8vk7RvEfo+Af5iy3oPMR7wIgzYsMPmP1k5dwDXmjOZZ/rgBJGsPQ+c71AeAnp6fDonoyPu8qwPKgAqgIAHapAABwUbsJTojBCllwrFAXAOQANhsPo4jL7bAt0P4fcOolg3oFB+6JZivwh6A9OfBSGT6r82fAqVoe0TlJhhZgUBFsQcsnkI8WMU8VcgsqUwXQ0jk32JNhK9/KmIcgiRVAS+eM0+XUkIrOsznVfQJxidmklKzlHU65AmjpnPKj3CBFK8NaPn2EwFfLnuOWAzWdWwPivUAALZ/4z6ho1RsO7Omclw0vmZVQxYotSe2FtEdSe1llFbxx/ALIQ12gj8jXAgAAAA5lWElmTU0AKgAAAAgAAAAAAAAA0lOTAAAAAElFTkSuQmCC",
    bush_flowers_blue = "iVBORw0KGgoAAAANSUhEUgAAACAAAAAQCAYAAAB3AH1ZAAAAAXNSR0IArs4c6QAAAc1JREFUSEvFVbtKA1EUPPsIip0YwR8QxVj7FYKdnaCCWNkoWEbcMqCNlZWCndgIfoW1guIPKEbsJCGbXZlzd9aTNY8iK94q5Ny9Z87cmbmejFjTtdl01J5h9c/Hd29YfWgRHyqAJJG0m8rp3Yccrs/pefFXR7xK4M5OEgkmQv0vnKpItx3rftRLAZB2utp8a17k4kVkf3XGNeok2j+o+BmQVOJWrL+9wBPx/XIAoAGmi66epb6xoIdzQssAqQYDYAQAS2EAAHiobYIJscAQQJ3cNuVgrargyFApAKgBNAsnQxHfScdeQeP6Va/o7L4pR5uL5WsAExaFZhnAxPXzB4l2l51Ay9TAn9pwXJ+PA07dYn0OGrmszykyXEGeARnFdAGFN+h7nM2rUYe0Y7WpAmAD5+lAvWx9ThHm9ivYcNT3tDF1BMEi0CBiBcANCBuETNHnrDPlFGjmcwYRpzu+fOpxQR5UiQspZMneStW5ZXvpBwAUzAKUTIroc9ivcfPmUjCzorUh9iMHmJbIA7qEOULgvxggxUAX7dT6+pwA+0WxzQn7XhAgr0jTk9eXaahHA4N8zscGIBDFuaCyx8iK1D5IZIAAKXL7WDkX/OP6BjqVcKA5VIkmAAAADmVYSWZNTQAqAAAACAAAAAAAAADSU5MAAAAASUVORK5CYII=",
    bush_flowers_orange = "iVBORw0KGgoAAAANSUhEUgAAACAAAAAQCAYAAAB3AH1ZAAAAAXNSR0IArs4c6QAAAchJREFUSEvFlT1Ow0AQhcc/USJIk0iuU5COA1ByCq6AREeNkFCkiBrRIOUKnIKSA9CBILWluAFEFMdGb9bPTEwSFzFiqyi73nk7+763ntSM3mGU163ZNp88xd62+a2T+FAFZJnky1ySSVei87nul34uxGsFbu8sk6Ad6n/hXkuW81TXY74RAfliqcXleCryMJDe6bsrtMi0ftDyCyG5pF+p/vYCT8T3mxGAAjhdMh5K7/JZN+cJbQfYanQAHYHARjoAAdzUFsEJMdAhiJrd7Uv/7EPFsUONCKAHUCzshCK+s469gvim7a7o/kj6Vy/NewAnrBrNdgAnji8GEl1PnUGb9MCfYrgr57uIU1os52gjh+WcJsMVlBlQtJgU0HibvsfevBolZJ4qpiqABRzTgbJsOacJS/wqGNZ9T4zpIxgWgQYTq4CS80lXQ6bKOeeZciq04JxBxNPNRgcrFJRBlbmQQpbIyaOjZfT6IwAO5gSczBaRc+AX33ZcChYoWgyxHjnAtEQekBLmCIX/6kCZ9eOhROO39ZxT4Jootjlh3wsK5BVpevL6Cg+teGAT53xs0CVEcWmo4jGyJrUPEjtAgTS5fawcBf84vgHKA22gupqGbgAAAA5lWElmTU0AKgAAAAgAAAAAAAAA0lOTAAAAAElFTkSuQmCC",
    bush_flowers_pink = "iVBORw0KGgoAAAANSUhEUgAAACAAAAAQCAYAAAB3AH1ZAAAAAXNSR0IArs4c6QAAAchJREFUSEvFlc1Kw0AUhW9+iuKuhTxFd0I3PoJQBRG6UVEfxIUP0oV1I4iCBR/BjSCC9CkCzU4sTRM5d3LibW3TRSPOqnQmc8/cOd8ZT9aMZjvK162pmk9GsVc1XzmJD1VAlkk+yyXpDSUaHul+6edUvEbg9s4yCbZC/S/cachskup6zNciIJ/OtLhc74lcvUjzrusKTTOtHzT8Qkgu6Veqv73AE/H9egSgAE6XdAbSfD3VzXlC2wG2Gh1ARyCwlg5AADe1RXBCDHQIosbHT9K6P1Bx7FAtAugBFAu3QxHfWcdeQdx9cFd08iytt7P6PYATLhrNdgAnjtt9iUaXzqB1euBPMdyU803EKS2Wc7SRw3JOk+EKygwoWkwKaLxV32NvXo0SMkkVUxXAAo7pQFm2nNOEJX4LGK77nhjTRzAsAg0mVgEl572hhswi55xnyqnQgnMGEU833r2Zo6AMqsyFFLJEbvcdLe/nPwLgYE7AyWwROQd+8eGjS8ECRYsh1iMHmJbIA1LCHKHwXx0os74zkOjjYjnnFLgkim1O2PeCAnlFmp68vsJDcx5YxTkfG3QJUVwaqniMrEntg8QOUCBNbh8rR8E/jm/mk22gmMhhoAAAAA5lWElmTU0AKgAAAAgAAAAAAAAA0lOTAAAAAElFTkSuQmCC",
    bush_flowers_white = "iVBORw0KGgoAAAANSUhEUgAAACAAAAAQCAYAAAB3AH1ZAAAAAXNSR0IArs4c6QAAAbxJREFUSEvFVctKA0EQ7H2p5BY1IPiIehH0YkCE6PfrSYgeFLwIvkBZNbdgzD6kerbWTszjkBXnFNKz09U1VTWezFj1g0Y+a8+0evc69qbVpxbxoQLIMsnTXLq379Jorel5SW8gXhS4s7NMgsVQ/wtrkaT9RPejXgmAfJBqc0nORcITqe+tuEaDTPsHkV8AySX5TPS3F3givl8NADTAdM+dR1lvberhnNAyQKrBABgBwEoYAAAeaptgQiwwBFAfN2+yvL+q4MhQJQCoATQLl0IR30nHXkHcedEr6n0dysbRVvUawISjQrMMYOL7sztpnu46gVapgT+14bw+nwecusX6HDRyWZ9TZLiCMgMKiukCCm/S9zibV6MO6SdqUwXABs7TgXrZ+pwiLO03YsNZ39PG1BEEi0CDiBUANyBsEDKjPmedKadAC58ziDjd08XDkAvKoMpcSCFLaguXzi3H2z8AoGAWoGRSRJ/DfvHVq0vBworWhtiPHGBaIg/oEuYIgf9igBQDXbO9M9bnBDguim1O2PeCAHlFmp68vkJDQxqY5HM+NgCBKC4FVTxGVqT2QSIDBEiR28fKueAf1zdwhXCgDPLcRwAAAA5lWElmTU0AKgAAAAgAAAAAAAAA0lOTAAAAAElFTkSuQmCC",
}

for k, v in pairs(textures) do
    mcl_heads.register_head({
        name = "heads_tiny_" .. k,
        texture = "blank.png^[png:" .. v,
        description = "Tiny Block: " .. k,
        longdesc = "A " .. k .. " head is a small decorative block. It can also be worn as a helmet for fun, but does not offer any protection.",
    })
    minetest.override_item("mcl_heads:heads_tiny_" .. k, {
        groups = table.merge(minetest.registered_items["mcl_heads:heads_tiny_" .. k].groups or {}, { dig_immediate = 3, })
    })
    minetest.override_item("mcl_heads:heads_tiny_" .. k .. "_wall", {
        groups = table.merge(minetest.registered_items["mcl_heads:heads_tiny_" .. k .. "_wall"].groups or {},
        { dig_immediate = 3, })
    })
end
