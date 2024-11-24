local strs = {
    images = {
        balloon_green = "iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAAAXNSR0IArs4c6QAAAERlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAMKADAAQAAAABAAAAMAAAAADbN2wMAAAFEklEQVRoBe1Zy44TRxStHoPHHs9YCFBQhLJiwYoviAQfEfFYwhJWiHxHJFaEBVKyTBQpEp8AUqRs+AAWLLMABiQGPPbYHlfOqdvVfbvdHVd19wQhUVK7q+tx65x7Tz26bczX9Hk9kDQd/vr98+w7wpUgmeFgh5lac9ZaM50dGt5LiQWTPx7ur1WU2lU+nqosDSsk+Je4xrgaDY5+ZHyA6zKuT7iiUxsCHHwP1653qk15JA5XBZZqmiytD12FGV0U1VHJhjbGkMxLgN+ldM6Mz6USsma+mEEq1FY+FKVzOJ1ksfJk0YKeZwQYCaYoOcVGIJNNqns+m+3+jvnxzq9m0B+Zo/mhefT7XdynrHKJRLIopZmjxaGvHh0vLaXIFC2nWAL0aUE2HJWFBD/YHjmvU0Li/TwESWLTCLGHV43TFBvtshTJV8hTwO9GAiXZ7MHzicgjcZ7n6P3+0HmeoGeIgINVMzgjJ/0ZFfYutGbBHsb0hRvltJEADAbJ5smfD5z2iXu+oHyIRScstcOhK/ByInjmp0uSdpj9WGwXJKcQAs4rMChhxhML6MkBtM+LiaCp+7J0XGX2I6S8nBwRSMsZFJ+zQZSctjLboRkMJGNRAvQbn3ilzNY8v244j0Dadb1JcElIBIKNddFwcbRysgq1FR8BZZkykk1LpKGqGmcL0Qmw0igCAtemmk+MX9O7oxGAPG3SiAD1zt2WGxYjwBlQvfKEA2nasiEBmcDcdWUJwa8sP0E4Ck1bhq0xAQLmEaIYgU34Zf2izuVYzQz6SPGmzpX1DQlY0z89NPdu/ozjw47bfR/9dg8yyiOyPhreB6ZyPiJ4zhuZsH4pXu8RUhJPIAu5RGAbZyCf6Mis2heW7t7zHnypOvoxjkAabncDgtkcx2MkmQt14EUfBFwEH421skMUAQbbL5nz5cz89MvtbPL2TtH3Zf/XyYZYhFglqojCKALarrUr8TwwcyIPe/XvxEXPdwPcYwkhwBE/4vLupeh9Ps84i4hRio9LZaxs0J69RZcy5ka2IQRokK98TOP07cmdGI+MrDp+XS/vBcXVht1zPLDDApfU+cePlb1e+jZ198yTdQ10OV40+Db2Dy7ejeieOR6tedYvm+NE59KZg2VrJk1gPltJoXj94tPH7xnxoBQSAW2ISCrkJNLhOV8nLyddVs43kY22EUvAh5g2KuWkjUs+J6W93kY2eoxyzHXdf+br5VTfTRNoIxs9QmwEdN8aOekm1fm2stFW2xColZMeQOe7ko222VhC2khZTrpO57uSjbbZJgLaTlFOtpdtdm4XlnmM3xWjxsSVTErdY/OfrgiInLYW+JpzaZxMvuOnQnz0tWb/7b6xK2BNzGRw9t3l4YXXB/a4R8SeTHP06NmJhDSCG7d+yDY7npfevAYB3JHo9YvPn/0VvElpu3X5riKQ20+WeR4qSbaO5VAEZ+FT4t7Va9976UxAxudVn7hs5wTsN3/nCABvPAYBJLvaGh28uoTP8S7oQZ8Nc0P1uc4JmEQAuyGBNelBPuJnIo/6bFgPO6/pnoDA9eclOSDLeCSQrU45hHa5kyDgNzinFcJLeks7ffvtGDJyq1M7yMXenRNI/21c+8Pu6rUrJNR60hbhG9M5gfIA6pngKS1+jyXB3S5WpP+TgJcWsLsXohe48y/aD7g+y9+sGDc8pWu+kxY871ckTmructl8CbcoLVt9Xo8d7CTafyVwEl6NsfnFR+BfpfYVfmyGH4YAAAAASUVORK5CYII=",
        balloon_light_blue = "iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAAAXNSR0IArs4c6QAAAERlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAMKADAAQAAAABAAAAMAAAAADbN2wMAAAFB0lEQVRoBe1Zu44cRRSt3tnZnZmdGckiRHJmbUoAJFighYjckWVBTu7Yzgj4BgK+goiXtA5AWAiJgBUJAluyVyR+zPbMerubc249XP2a7upu27Lkkmrqfe89956q6u5R6k16tR6Iuqp/95s7XHuAHEWozSZTVOqlZZlSZ+tYsSwk9qx+/fyD8khhYlVzt6qzZR+NP0FeIndSjnWE/Bj5EPkpcnDqA4DKF8hzbX6GQoegNhDVMNlbu6QJUdBCjzaUuwRlTmD1nBy6NJ85Cm0S2ORzBVrYXMVrXTFtYxw9zwgwEkxBdAqNgKON5v2EbTXZHamvPrqiprs7Kr5I1e1f/lFrlA4RJxlAushUnJpwZNlBen5OKjIF0ykUACPm0YY6I7GTxs8ARNpkBBBysk2ZbdP7MmIAyBEAGurETn+ZXV5bNgIo0GYhdkAN9dLzKNRktKM9DjXrJNVbokolF5tI0EoDwZ/J7gV02qFGOjUCgMBG2pAuX969B+O13g1AFN3I9nSyr40liPVGA0D9DIMGl9XFea3o1AaAeAUCdZjpciTxPGhD6jDReM37eg7olTCWkZBVlk6moZcG0akNACddKnTyc+3iRdeFfjuUXxTQMqFouyIcQFvJXebB+CQOu896A6DHe3u9CDYgCr0A8MThabT15CkaN3C7EwB6nLctLyxuR+6BqpNnYFsrxXUCIJIQZt66+h56ATSqNLfc2R0AqMMj1I9AWXy+h5GSBPCs67brNYNhRScAVDkZRer2+5cBYoQ9kKhbP/8re6FuQ3NNjMuLN5bUvRs7YM+W0HUCYKXo5x99kdUZbudK6Xm+n9+fS+0AgKqxcVFwDzCxrDPI9XvGy6KBfoIAiNHyGIzHBlDg5k9/ySMFAY3GY/zmE42vo01+ZvdWEABfDY0jCCYaPqsAIIOe5100ZGCYnzYAqPcJsnYwXkDc2enbQEP5hOcnz3i/O1dnWJl0ycZK2lpnI+Y2ACiQr3xMS/P2NCd34r096RSzccIUzC+dNjLZ/ECONVolZ/SPpBWA5F4v7UBdWdRZN0/68aLBt7H7yCzVzr55vkd9ipeaojC6LzY043w/pRscqUzwvDzA6QgQydu/ffGpQyRztvy0iYC/nDZtpZONeRGML8TQxUaAS4Jo48sKBbCVTkWjLRircCjaWHksizr9sa31bXSqWzgUbXz5oRHw1zbSyZ88JG18uX0AVNPJl16o9zltCqJcszOFnARUinTyx3SdanDa8LjseNqUZeqePhHwZebotJM8O4C94pw007e1IMiyzqeNr8yvDwVA6JTsTdRbf95ZLv/+HZ8Ks3mG56b/Tk9VCq8Dzer88L3D83eOHkebmDZYML49wfVBKORrvXb9hr7sIrUggNOHDxRLJLmkjn/8vvUl5cutqw8VASc/HevHC3aI4eN9CyCK0mRx9ehjoBG/rY5/+E6QucUdKoMDuPfhZ84MvnslKzocdl48O5h++/UJQHC81WdDJ2hLZXAA6e44py4zEYHP6fagz4Y5QTWNwQFAD2lBt/O1TVOEhT6V+PF20H33IgDYC84Zmu3Psr0/jpfRhfyRYaMALP3T4ADMv42lD5xXjz4hIB2R/nY7CYMDcJLLFUstfsYgwDlAWUCdT6SXCcBSi9B4V9xF5l+0j5D5FlaKGvoa00sDYM58MdLQiXuBm5rPGm6/NFpcmKC/ShU6X6fmGwCvOlqvfQT+B8DIDUJbMIhNAAAAAElFTkSuQmCC",
        balloon_lime = "iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAAAXNSR0IArs4c6QAAAERlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAMKADAAQAAAABAAAAMAAAAADbN2wMAAAFKklEQVRoBe1ZvY8bRRyd9ef5/IGCaE5EokFKgURBhygipUcUSAiEREUNBQV/BQUFHRXlNRT0oBTpQFdFyqUmCCVQXBL77LO9w3u/mdmdXe96d9YbTpEyd+Odz9/vvZk3H2sr9Spc7whETd1/88tN9h0jRghqdHTMRKk5rbW6XC4Un7nAgvl3H/65U5FrV5jtFZbWKyT4c8QZYiPn6EfGTxFvIT5HDA6HEKDzKeIkhe94lMyEq87CZGlJh2zDolxQR082tDWDZM6hiAml89r4dZEQ0WziJaSSuqMTjb/F5dzMFQo8KXHkOQOcCYYgOYXOQCIbq3vm1aA7Ul+89yOex+oqXqjT+1+r9fYShFhrgiPkgK/1wlao8XqlKUWGYDmFEiCkrGxYAqQEP+yNVbSNZCYM+JRBFBmlmHKkNevwRHMkJogMppFJ1/qsJJCTzRQjH8loCuiRBT9S6xgjDvBXW4ysG+4cBILXAtyIXgt2Yk4CyUzh0xVWyqmSAAxWyobgf37wrciGUNZYAwYicy5E6mgIwgjCbyUpSW+iZHt1vlhZS051CMiowKCZZuRYwDVA7Q96x0ptARqav+Is0LX9lGTmw9ZaOZkqN9iSY4MgOdUhkIHgq1RcczgZQWg/+KyZ0lyGT2mrpCKcQNL1BSQAfrWIZYzqWj+IgIw4VyZjS0EmIGAWGhOgD9H8tmMWb8nO0xKvUjMNCURy2vLA4mLmGijeeUr9tlbRkAAxAzT3fCsft4RbQ1bTUGMCHPk+Tt/sDFR5NeI2amM6QOwlphsS0KrXGalP3vleDbtjOX1P738lp3H5GaDVcnUpOy6Br3FnsnRkNkvwVRY3JGBgDjrHcgcSLzV2In/kHfhKhBUNGhEwk6/NvQcOeAO1Q1vgzkKVh+tZ0KxhURABWbi8BgMH7/w/nX2J09ecAd1+BxDy50GZbIjWEGuIO+kWRCDpJe5jzEB69xn1cSfaIeAmxh/5doA7LHUI0OOzBJ3G7dQNu7OCJ/Vt7vxp4a7m0zqXMm1owP0rvLZJoM9KtnUI0CBf+Rhm9u0Jr5HIDSEnx0aux7sSSncbdk/xbFZ4ybTZ1Ty5/8zRJPN6yV77Qt7jvrYKLxp8G3uEyKfqH7nuuFpjW92VEBY6rtg+cPZjWC8tejyWuMBZbhz1N3/47C8+a4U6M+AbotcCOfGVnfAtKNsjm0vNuJFnc/MfJpvUklKhBCrl5Bs36ZRGW7LxfTgN+GW10uVyKu/elmx8D6Ez4Pfl0BbIyW+SptuUTWo1XEJ+30I5+Q3y6UN2m7wtl28sIWeAz7yc/Do/vcR2add58G7j2/HTh0jIt5ORk97gimo3pTjVDreqoEPKd1CWbouAyKkz3KiLs7dmzx6c8KvCiY61evL4HxxYGHl85/nGuxe3Tt7/9+lm2ZU8Pw4NrUjIB/Hp5x/bwy6axgD++O8njoDI5u5v9/hsLbQ1AwmgqI9vuRgwNB3MQHewVVZGkY6j6e07H7iDYX7313subfo0+GydwMlHZwkMyv/Gc0MoXkfjh6c3zzW+P0Wo9bVhYmhPonUCUc/OAJwSanfgLmodZoO+NtyDO6lqnQAspzuSu3AaoZCA2Z0S94cnXgQBd8CJVgixN9rqR7/fmMXrjuxOh8NOLbROwP7auPOD3e07b5PQwYs2hW5SrRPIO/DyTlp8eSbBSRs70v9JwEmLnHhW/IHIn2gvEK/lZ1b4rR/sni/Swsi7HYmLmsd0sl7qWzQtOZ0vdXhF4Lqn76Wfgf8AZsAd2l4w6JYAAAAASUVORK5CYII=",
        balloon_magenta = "iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAAAXNSR0IArs4c6QAAAERlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAMKADAAQAAAABAAAAMAAAAADbN2wMAAAFDUlEQVRoBe1Zv48cNRT27I/bXXZvJWr+gBSREEJCiIICCqhQKpCAij+CMlVKqPgzUiHRUXBIqZBACYJIOVEjhRMNSXZ3Nrszw/e9sR3P3HjWnp1LFCnWeW0/28/ve++zPTOn1Kv0Yj2QdF3+h49uc+4cOUFS09emrHjVFUWh0nWqWNYSBatPfvzsUkdtXGNz1CgNE9L4c+QlcqfFMY+IHyFfQ36CHJ2OAcDFT5EXhbHfwPAEwo6rmslZnhnVgU2tqIkObahrCcqcw6gFqTN/fQEKQQpz8qd5SRWrHRVQZ7PaoLuAtYlLJXqeEWAkmKLoFBsBSxvNe7bVcDpSb998Vw1nI5Wnmbr/zT2VbTMxlP30r+G+LdNcugBovs2ekopM0XSKBUCfVmhDb1JI40cAImYjFCJlh06ywdEuRz/bNGhz1EIPi6bTQQA12pzCkERogHXpeTF+MhTP0/gs3ZsdYWy3JY0vMFsGcCLNrSZKT7Gm6TlIp4MAoDCINg+++0Nl4D5TDvoIMmk9+5nMptIgjbYqtfVkbfeEWYt9QXQKASBegUIJs6EAA88ICG3gLxpP/kvijJZk6OSJQBSdQgBUTDGniAjJBniT8bY220plWrVhCFKVSqvU1tDhEUUD8OjpRUzj1/tN097w6j8OALxNOoQ43WtBvYNRbeBWfZhpdweAhbhZMwDgmd/CCrPWlZTdAMDlvG15YTECNN538lyJ1Y7SbgCggJs3w6kjJwoVxvAoZqxjbFO1MwAaPpwOqxFoWqFBJo8TPXGuGwAsPpgM1PWv35K7gLfv/W9/L++BFu9uN3gfIOHwJ3eGBiGAGoCGiLoBoGYYOkAEGAXdlLLtxxgvY7TxbeND+roDgAHZZi9r0JuH7KnQ5tDgEMv1mCgANKLAYzDX56lz99YvevMmajwYN25kH20ibGwdGgWgookRcJ59xrNmAFdBG9eOEAB0+GNk2Z4waK6f4Us9etPSULmTDT0gD6GNAIQmXXL2qlQsaxptWnS5CAFAhXzlY1rqt6cFjZ2kJ6UUxsrjsQZTCvGL5d3TxspRgR5jtFrt1zIW4hWAVF4v3TlN9fqSTWOsDC8afBv7G5mlmg4nLCQNZuVpZNqmzDf6EdsIdJlmW6nR8+td+a4MASP9xudnX7EMSiERcBUxpM10Yk/dHR4CHEsb16BYAIfp5Gqv1fuijau27jO3r7XeRiffxL5o4+qPjYA7108nd5Su90kbV/0xABrp5Cqv1485beq6TLszhYwClnU6uX1ufbVbm6Mz+rRx9bj1YyLg6qnQaZ/s+XmEX4DsFzlWQKOoS8pdwFfvC4DQaVKcqLvTP5cPJn/xU+Eih8kX/16oIuf3omT15uD6tfcG7zxKy29CBozPtiB5LxRyV/ry0y/sZUefP7z4B86XD15Cm7M7PwdfUq5eX72vCFj94wIPdUj0DCNwosaG90mustMP3//AXG+rn+6cmbrM6fLTO4Abjz+2djACT4Z4zgGEndrPb++/P8+URCPos6FV1FLpHcCoqKpkBMqEl+gjvkL7MFRX842Kk9sTCaeOUKS8xAoCkNMpTl376KsAYC44e0DM1LT4Nb+33KmdnE7tJsX19g5A/7fx0j/ssHkJ6OhNW4fXO4D6Ak7bUGsAGQEu+jiRnicAQy1i4l3xGzL/RfsfMt/CLkUNsoPpuQHQZ74YqenEf2RwU8s1fdBSzwCG86VOrwC86PC99BH4H7OCHkZ1vjYsAAAAAElFTkSuQmCC",
        balloon_orange = "iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAAAXNSR0IArs4c6QAAAERlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAMKADAAQAAAABAAAAMAAAAADbN2wMAAAFJ0lEQVRoBe1ZPY/URhge7x3H7e3tRiAaQCKpQpkfkAJFoY9EEVHRUEMDym9IkwYpZZqUadIlTVIghTLpLx0F+QKJ3B57tx93njzPO57x2N61Z2wrJyRGsud73ueZ95kP7yr1LpzvDCRtzT9/dI19R3gSlSRqONxDqmY4rdXJybFSiEuBBbP3v/qjUlFqtza7vbY0rJDgD/BM8LQyjn5kPMVzE88bPNGhCwEaH+PZp1UySByPGk+wcTGYrsWy4FyUJU82NDCBZA6AeT+hhN67DAYDkYg+nRd9QiuQzvx45ih6UuLM0wP0BEOUnGI9kMsGoHeHe8yrwc5QXbr3jUp29pReHqvZdw+VWp0YgbABgpM+EqK3FdYDy7GOFitNKTJEyymWQEE2tGhciHUM8MlF8AExekRLhamVdkmmFBRRalp6ypuNRIaIo+XUSKAkm7FBRxCJzLyk4AFtZ3yJmRcchF0M4AVPZKQYSVr8YRuydAybtrBRTo0EMGCzbAD++PsvjGyIa4U1IDOMyIVE7ewOJUc5LU3KSOvUba/WFmuD5BRCQGYFA4qbZf74woJNMPOUjgSQ0Jx918AUF99SCSfmSsl3LmnJBlFyCiFQxOByACGO5isDVAvedaxNyJC1LYqVHQgUB+ojR/BHizTfsQIG7UbAzbiRRoC9xiZcHzFeaE+AhkTzOLy4A0WZbeQR3KAlASw9nLY8sLjnE/z6nScYR+uGLQkQM1yA09QcSMgLkdY4WndsT4CAL+D0LXigCYdRN7kbyWXXiqZuNfUtCWDet4dq9PkTc32Q+88DcxpXDjBrXavlHGdFBl7zLmSJmELbMCpuSQA2MPNy/+EFTkw270QWvCC34KPgVhtHE6BdOUg19mvMPIOJDQ0pKLxMeRV8oVHrTBwBopCFC9DYhV5/e98t3p0tbKcV+WySDfFuIhzHJY6AP7Z4wLv78Ju4QgAwBSdfeFzaH6hbOoQAzR7hEZEjM0KiIngCNZe0HFAVfF5nU6aN4YY0bc2yOtpkvjaEEOCA/ORjmGRfT/iMVOqi4howdMz1uMyLB5zdbdg9x7M4RV2Wneb3nxmKCp+X7FUXyhbr2ip8aPAj/gUexmr3gu3OHYl3fZtnLQNAbvjAma8Mer6nc2wI0l48ff2jr//i7AeFEA/4A9HOGjmhmDWyPXnNM1ReiSTtzLO6jWz88WIJNMvJH93AdSV9ycYNiETZ535dbXqznDZ360s2voVYD/h9qYA1cvKb5Ok+ZZOPqlQXAmvl5A9eTnfZbcpj2XxrCdkBGJflZOv8wemuww67jR2zHHfxgD9WQU5LvTVCgeDXKaskQEVp1CFlO9bFfREQOY0GK/XD4QeTX46u8afC/RSQ/375ClulkJh9cuXfm59dfTWdnW4RkyVTh6+xzvdyY+OQBvfu3skOu2Ss01T9+c9LS4AL/vrPT58FH1Ih9vrygLO1m5y5dDrQariVqtTIKDnTyfjTWx/bHxdnPz195vTlOkUmeifw+OpvDgKVM710Jof0Ik1GX/5+42Bl4Af9bOgGqkn0TsD3ALEu4AFz0RlQrlE/G9bgdlW9E8CkUxZywEmaOQREJMAfb3tdd70TAEB7wDmgo+0z/eOLy5NFOjhAofUCmnYPvRPI/m2s/GF3+9aHJJT5oztwO0LvBOzAa2KCp7T48UyC+7exIyFmaL0j/Z8ErLQImGfFr3j4F+0hnnP5mxV2w0O254u0MPOUE9cCFzW2qfYLm+58q8M7AuftvrfeA/8BL88Q9t9sIGQAAAAASUVORK5CYII=",
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
