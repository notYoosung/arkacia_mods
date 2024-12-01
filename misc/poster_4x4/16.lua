local texture = "blank.png^[png:iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAAXNSR0IArs4c6QAAAERlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAQKADAAQAAAABAAAAQAAAAABGUUKwAAAjpklEQVR4Ab2bB3RdV5nv/+ec23TVe7MkW+69O05wOoFACJBMaAk83gNeYAIsmOHBepQE0RkYYBZ1mMkaeAwLmJBASHghvTgFd8dV7kW2LFvFavdKt5/3+44s4yQmMYH1jnSle849Z++v/r+y93Vu+f4P/GO7dmnj4w/LvWymwq11Sv5hq7IHTkhOXvJc6eJpci9qV2hRm+T7yj/yvEKHTiudy+mmi6/WN9/3j/rUr3+oXz/3sG5Z8wbdcNFVet/P/plbff3iQ7erwH3v+f4dSmTSiobC8kKexv2CVrTN1AfXXKuIF1I6m9HU2im6dM5KhUMhJdMpvetHX9T9zz4qNyspElXoU7fLm14jb+OvIC2nUP+I0nduUHZ3rwoVMeWriuT0J+QPDOuNb3yT7vr3O1UciytdyOvu3qNa+9QT6vrJL+FLWvKRW+VCi3PJO97hb3juWeXGU/LK4vKaK5Xp7JZcGI+6ci6dKk2plDI5uQ0VUv+wCgjHL+R03Yqr9atPfF0l0SINJUd159r79P7LrldlWaXu2fiE/LCrm5ZcDvXSXZsf0/t/+EX5vM9A/PL2Obr18jeen/lUSjf/+Au6b/0TUjgixwkp/OFPyVl5KU8X5J7ardhj/6HQ2BjjOUr8artSiTT3QnM6oytnLtMf/uPnikbCkO3rrp6D2jI6oOJ4XKfXb1FJJKLG1SsZFzY3P/M4GsrI4WavEgkqL68iLrhS7J/frOhHL5eDJh0sIdxYqVB7gxQLa9WcpfrvV16vYRi3Y3Q8qcXN7RrPpDQyNqr/fPYh/fzpBzWaGVMiO6a71z2pTMFXGuZXTJ2lD14K8+6k5pvR/IoJzcP8Lcb8psflhMOBAEIf/7TclQjSh0k/q0L9NGUvuVE+VpHtPKX84dNy0rlAs2Ytu3d26uGnngroCsPl4tJqlSDITCKhgfWb1PPceuXHx3VqyzY5oZZa35Urv7pUXlVJYOL+aEr+1dMV/tw10nhW+d0npaMJefUV8jHf8DP79K0Vb1d1VRVPOqopr1T/qLlEVq7j6s5nH9aD254NCLhuxWVcc3T/prWI29PqabP0oSuuU/iM2bfVGfNm9mHMfly3/OsX9TuY90JoHga9v/+MnCUXM1YGq4M7fxxlmB1F5e5/Rtk3/oP8/mSgFL+uVO5QRlmEWNlQr8cffEhLGhp5Rto1MqgvfeEO9a/fjOl7ql4wT6Ndx+UVVVd0ZItCKmA9DmbvQGy+d0SFXSfktFTI5ZX741EmGZNXW6bCvh6NPfy8Tg70a/WchVp/aK8++Z/fVx1CaK6s0jceukdrO5+XF4kxUUh7uw9rX8+xwKVWwfxtV7xJEZg1n2+rhfm5f2L+PTB/L64TDkfhr0jR2z6vMC7kG/O5tPxn75GOdcppninfTShf7cif3SQ99ryc+nKF1syTPzquooKn1/3Dh3UahTVG4qoqimnt8Cn1McZI5z4E6Wustw/LN2tvqutIupg4UvILBTmZggr9mHUKk9rQBfh4yh4dkp/EKpIZ5R7fJY1l1N1zXHs0rkd2bdXw4JC29XZre6pfWzt34bZR7IIfxg15nvIA3spps/WRgPmQMsZ8HYA370/Mv/vHXwqYj4VjPFeQ995bFVl1HZr25eLH+XW/VuHYbmnEaDklvwkhcZ8zY5aEG3qGVzWlypdGtGLxaq25+W1KgQedvT3aAU1HSsMqb29TDqUM7+gMLNVxHXmZsNvhIRFFwwo1VitUU46VZaR8XrGVrYoYCViGXwI+xEvkFMfknxgAjaeob+V0FYohZDCp9KIW9TbEFUpl5SRSEMeDgEwWtzDNf+SK69H8hM+b5tcEPo/Zgxm3/NuXMPsnFUbrTlFYuWuWKdcYkltULTdaDvO/kro7JdyiEMmrMAZIJ0fkNLXKf3S9Cl8F2UfG5SIAb8sxnd6yR+XNjapurFfnnT/T9t/8TuWtLYIqnTx+Sk5psQone8FTBBhprjUgld9WqXB9PYRjVknAJpdSbMUUUDWnDH6drqmAuNjE573DCKCNc5hHQ/lMRvmwQSovhOc+u1MOoS8L4K08D/OvmWQ+Naabv/d53bf9WYViRcxZkKpxubetBvywoJSrKLy67mnmcVXIF5SJJPiM8My8oRwa/8w98vuGJxSI8ryBFPRkVVpfo6vfeLUG164LwNQFUMMrl0gNdYGbOyd6lN6Iq3qVJR25xmLli2A8D4j5hI6uAWVPjsotDitfGdeYTZ6CMcDDAbkdNGX5gBMBOyDFcgUzeR+r0c4jgR/mjfl207z5vGk+G/j8JPMJmL/lO5/Tfc88AhKjWcZzk4S47hH5CNhvAJDv26DcY+vlVJVL5XFlCcVOFtMK8TuUVmxnr9x4VHlc1qvBOsuxTgQXc3GD174GK6gL6M4nAElygXzPKbmlpYqUl6iY8cKVZXhRDMLjMIUX5AmHmcSo8piTn84qtbdfqWQucAEoxPQIl4aWmI4/nub+PHrgQRTvoB1v4wGpZ5C5iPNtMH/5deeYfZMmmU/C/H/7Npp/7lEwJqIix9ObsIoiH3wgDJcfHdbHe5tVfAwsYo78oR7ls2BSMJcrb9BV5CgG7TsKteImdeVyCM32cSHmqaSpWg3trbhQTNEpWHUQ8KEbGrOb0HoPAM+1cF01uot7HRZD/aKIXBIYpwLJM5gBRGQGN+DTBdMwUotUMhHMWpLkIz3FASy7gObdDXvkHuvD7PNaPmO2PnoZGR5hL4fkp9W36JLZywl1ERnz7/3W5/WbZx8nuStSSbxIf3/tDXrr6jWqLi9T14kT+vE/3qGPX3eTFrbN0P3dO+VfNl9e2DOjI95n5I2SAEGv0Z16aDtZ66mAOScewXrGNdLVq9MDp1VfUqLE5p2BwgLCjVaUl+7pk1eCZXceNGOCH0wr1NqI5mDMgMEM20fixixSCxkoYmrBOageunaN8n2nlT/agxKwoPUwf7xfaT+vi2bM1W3XvClw0zzPuhDehgCM+UQqqZu/fTvp7ZMMF0e5ObVWN2jR1OkIZlwXzZmrW197o+a0thtZEGtmaf7OgdA9UmmyLFyOObGMcVLywsGTQRJXGE3LGe+Hfi+gE3znx6yCMc49DKcYc2TDtuAzz6ks64hcs0ihOc1yYyHlDhIf98OYpZYkRJparVxdCb6UwvdjCl1/ldxZU+U21oL+I8o9uE4FokLemJ8F89ffgGaJHQamzO2hqZMjA9QAEX3oR/+Ez2P2MZIYGDKb7Rkc0FFC1fIZc3TZrOWaVt0YCPV369fq5q/8L42fGpAzNCanjjR8AJfIMyiCyd31nPzdxwE4xkEJXhDKcReiTuucObrixusVra5SCKtKd/dMCMIswI5z/vOYkcEBwYW+Ufl7KIJM8iCyP7VKzuUz+IzP0bzedIU0cxpEAEb2DD4YiNt8ftZ8ffS6vwt83mL/+r179IPf34cBFZRCc+/85u36HWm3EKJjVoRZO1NBZKS04/BBJcCXpoo67p/QOOKzGQJhuGNpeYb0gQ8At+QFjtEYEMGfEtwjAv1caygrISVvwEhshIkxgoH+zB/PLQt1FI6i9WRWuecOEbghgJe7ok3hW9eAC2R0xH73Da+TO49MC/ewEJd/DvM70Se/pU7zS6r16avfGpi5VXLrSDz+9Tf36kh3t46RMa7b06nNu3fjx7gReFJ0+UJFpjZSeNUohJV97OobNaN1qgapIRoryEVIvua2tGvJ9Fm6f98WAQZYDBHIBMLLMlZ37hTCH4CdGcc98f2Qo+pYsZY2T1NhJKGsIT8CG964JXDrs1p/kSBMtyrgp5l+0BspmvZDdWWKzWsKgDC4f81yOe11DAgWWF5w75PK7TmCNjH1rlM6tm6Dtu7brWK0u277Nn3/Fz+jKMsoHItpcyjJizoCtA9MdTboTLw2MAo0ar6byYOnMd311IN651c+oSSFih14Fcrgxa12L3kopxYNzhzEdrMmPiQKORpJ59U/jrsQrlPdJzS0YfNEaJ40+cnnzvnvOTUVHYVGEN18ibjvoe3Y/ClyhvF5fC93zcUkD4QSQMpMv/AAvrfzwIQv9gOEj/xRaaqsTXt3aTCT1C8fvE+psSS+CQgtaZeH79qYTglJFIJ1KLoKCStoSLEf2ar03mMIr1P9ZHb3PHyfdndu096Tx9F4WO/58meV6D1t9bOyTWUBzvjmqia83z8vf6+FMwSAKzpZahjw4RRhvKKoSMUI3PoRBp6B9u29HeeeIxhPpVUdVvcHtT9u4PSTUoL4bmlU6dMDyg2jvYXgAOWyE4MBj4G7AJViTLKtjObDCPklicvMBh1cWqP8IJkaNUPsxtUKzW1WYQDURkPeonq5U7j/NDUFtBToP+SPkJYOI2SKln01IeUT3ItFdGZGaWAcUuYoCE8sj3ziFnkr5yl/4EiQF3gmQLI9vxdQtKhlAsFBjMW64mK1lFPEce5QdJWS/UWnNAKEVLQwXLJquSKkydmThE6e85yysg5nLI9fM1AfBCDtwtC48k2EqQgDHz3BRKflveZiokAxaNwgfwitRDDdimK505vI10MqumKhQuQQoXrLJciyVs2GAHwVf1YVMZtujUhSPCKNM0x1RyhzDdnJL0LtTQoRl0O1VdQWRfJnTZdozjjV5YrdeoPCa5bQq6iUa7nHpl1yKdGt+vPHiFK9QxNhEX+piRdrWdMUmLK0mVpmxlTFZ7cHQoxVVsB4M8/VBpHBpTmSJTOcEABEejBhWZcd7uyGiaKHKs6Kk/j0enL1EBXYFOW37VT2rv8bpLtuc5V8Mr88YdMltTTLSf+xU7nDJ+WacGAi/+h2cKJfmlHLZJ4u6SlT63hcJ0Q5O6dN/vveKmcEl+kZUKGKVHYZ7pYxlEeo736nwouWYDFYFZEk+8gzKnST/gK0Btz5bUfMuFAs2MX/POm24VBxFLDlUt7GJeQWw/wnb3mv1qxYFUSnXDqtzP6DKoxi3QBSh1tOwoBGHAY2H3VaaYHhTw6JUXhZu6KGwqPDTLhH6d8+HrSdRGjy6cT4e45PpMXdlKmH+pU/1Rc8mycx0lE+P4SpDUAIr9WhaWodiqrSjWmcjLDnpksQEpqc0UzeAQjHyT1Ac8XyCi9cpuh88Mc4yfpK/fIu5bbvwVVxRQjPP9EZAHLg3+T/LtiYRYFDgGBzRSWMUYZTdqcp1d/9/g/oilnz1IhrtFTV6PFf/ZfSx7oDHPLctuqOQIJM5eMKfoIYH8W/SyhQMLOC9YuwkAIFSuqBDYAhRFpWOMx9zw9Q/WE14EGoB2shP/fjxgCvHGBFiLOEx1whi1sVhsc1paZJJ4Z6tGv7BrRO5rZiHl2cAYVOdgW8WtrtkwsUxvoweSuHAb9/+aH8dSB6dZk8zD48MBgkbYVBXMByWfIAU2AUWuc3NKuUyrKA9YYx8/kfeI8KM9pUh2WUUsjd8/RaAlev8kO4juGHt7Q9yBf8BIzQDAkQCgR3rmhHAIAWaXB4fiu+dlq5DXsnig7aWf5hQiKmCoxi/oDmkEEQBxPnqiiaqukrgnaO5RUJAKuaGpz8oaG8XmPJIaJpmhQ8r9yK2QotxuUs1iUoxo4DvHNrAnc0N4isG5JzaH8AwoXxHOEUwcOsTKj7hxAsCRIWAMeq8su1sh4/h4wcXeWp11+r2e+9WRmsIkpxN/rkem3v7yMXi2mMvCR16PCEC5jW/TQEcFjz05lZE9TQlh2GcIHYDZcotII21MlB+Zi2ZVlB9EFobh0hDhdyLIdgnByRwz9FZCgG+KxC24MrdCFtOy8tonmaUA7BhJgnj/Cy9OV8Ik2oFrf7CVZx/275Fi2qEOCPnibsbpRbVYrl0Zvcwr0IyauNE10o0o5gAVSnfgjax8Iap5weAStqANIQ7pwkBY7TF4jX1mjrD+5U5yOPKl5VTdKXUGo/oRw6PG9WU0eBRqJJ0GKkO4f0tKYYPyZE0BaLvm6JnGlcI277zbjEfvLvQToEZRFFV7dPNE9My0UQ4oypYMyTqgpzp2Ush7AXHBYOydicUvIBBFigi5Q3xwV8/dMJuQ9gXfvp7vKsSznsE5L1KD4fBvDoRfg2XgoXHcOaiPmFE1xjXgez92mcBE1NdJ+ibK5GAJYH5AG70zv3aHDXHp3evisQSqa3VxkLgVZkQYfnXD23QyA9/Ws0XyunllBnssDMQkjI336UJmQVvbS8UkSAQjNNBLQQXz5b0aUsmID0uZMAYA4GS7Aekil/GJwoEKvp8gaJihUTVjcAhEHaSt5f2EnNMYYAEGT4UFJuH/dicaxkyHn7KlJxQiGNDj/JuFMASjDJ6hPX+o00NTChAAQLJmx+7eWhwCVN9eQCWAi0W8ps3aFxGqDWETKGzx5n3nvuwikdjmkBpHVpK5tv+X0jaJ8OUBmxG0vIP7RN6b5eLIDPwQnn0X0K14C01ozg2ezGQ7g+TJv7EC4FODmWo9t8EZhnYcMWmczKghg+lERr+DJjRdNYnVkgBBkY5eeghGsWElIJiXUwMoyPm4XZ2IznhBBQDEsiWhTGaNxAt03ExxRB9Wqwfh/MTx4G8CaIP3d47vyWjsJOipouTJc83xJwf9cxUJ+mI9qwDnBuG1aA/6mepuODnXI2dSm3swuBlWv83u3KPH0AsEPi5USOPbS0+hnHQCIKIdY3NHwwHngfri0JUmNrn4UrS0lKSHiIMj4+niOaWObpW1cay8ju2C+f5CkIybiS24Pg6E67uEUet5EJAHO1kGcVoDFv1edfcoSISUyItjB5zxB/MK809PqYW4ZUNZCd1eBIMQzo+EMAplkJWkn8doP8QbIyeoP+QFqFNIAHXaZ59IrGINRO+PXoOUboIFsGaOFHLhZD7y740DrBZcTt4DrCeB4FHCBELqBoYmwbyzs1Tp5GcwbTXxguVo+XU08hybmrRU21r4p5E5TlVLSX0fRoTjHa2kGIUaVSZFFqpHDBLCFZoYvmyGFZzGmpCUzMAMYH2c2n1UOLykHrMRMUv0m0EgbETHBYlYPGisgLrJtjXcRUYgjzTQBuCJ7RCwgzaLgAtE6OnGKce1ngQPdkn0UK7yGh4ifMOAvqG9VI8lRVFOcKRknbq6GM7vBfqHkeDQ7XN+cxNPZAa0M/CPKtTQJmBJybb+L7PsVRkCNwMW/+Z6ZhTsnheug5aK3YCS8LSzaWfWxAh3VYq83y81wPq07WaeKwa+mTvcpZj4+xXDDBGzUakB3jNYx5WjqAv5PhWWn9zi90aMGVlxPukpxH6RjdoUVXX66MJWev8gjlAbw8qaXVAUZWqKRY6X7cAnML5IHfW1mZ3XNY4ZltKuzuIg8njJAsBWGTiOCAEx4Inqcmp2jnfpdIGJLHWl4+ifOTAOXQriFxFmKt1PWpQH260AH4YQlh0XZLY/785BCMaXV+UwOYjGCaWjT31vdr0TWvVXLF8qAbXbt6mRouXqWaxQuUA+n7N2+bQPq/UBCuT2EXZCRMlCORSZ3Cz4OcgInRhttj0oUxtFd4ijB4hBUVC0GmqFMIjtLXIpyPSTgpe2PvC5hmuRbWtQXPxanPf/2Tn+uuO3+Kx4QpZsJ612e/ofmXvg4LSaqupFJrWmaoFuHnmKeettbCpkaTL17kq5rn/d17lCR9LaLi+0zH53XplVcoFbgQdEwYDW/+8sNzyis6WE2AJ9CgABb4+CE5cwgtilSU3QV0Y1E2jGoUwKPUDEy7QHjhHpOVrfTmTQDmLlyoLy3TooYmlWG2FRQg//Ld7+rNr3u9ZrW3a96ihfKWrtKCq6/RjBUXKzswoCbmKKJFXk38joJKM8jcPFzzbDRj3OHDR5QiiXkfGx/msxA7vahEvQjviW99TwNbt090nP5y/uX5xSUd9ZjbyimtSpJFjVNSLmtsBv/K1Ts6GjC1pLZRDVEmtPU4BLC4vhXi2JhAjl0HIK1onqoxnkugkXrOFzc2Yf6AJ9nYyo99VNPWXKJ2dmoYoO4lrfUJWXnygBCp8vTLX6PxnpMaPXYsyNSqaGhgRy9UKpJwKXF9OtFgpJa1z0BAnrb29WjPs39UppfOMeev5vDmzJzRMbOmCsmzZk4KaS/LpKymLuFlwrHXxHkM7ZYHKFyNKdoy98zqOp4N04yI0zSyc7QHC5b3tL39JrVhqsdJZkxbOyiCdiVZV6T9NtS5O1h68zD76mWLlDx6XGP08QK7fzEnWEDJqiUqmtqiwydP6lh/rw4D0nvTCdUvX6LE4S6le/tfNuF58ZCT596qBfM7TOKWPliRYzm09dzsVYoJT54bEJZYs4FU1PzS7q0qZj0uePbMOUIJ7BZtRJcvVQbmYggmzuuJb39Hu599TvUrlmnw+Z3a/d0fBgxXL1uiscFhjZPj54YB5JHhlzJivsBvpIFuDsCw+/cP6siOXapbtljDnfvV9wxrE4D4ZFk/ydyF/Hdef9WVL4QQM11bKkfrZlrGoWVeRoCVsy+XVhogWO0fQytiZ4Zle7ZGEDp4WKef30a8z2rGO9+mk8+tUxKzN+FVLlmkCEtp1tNnAo1s2qQMy2PWnDn3sLEiRAU7MidOBkBbPncWQuwBvCm6Xq0LzJg2rSMY1f4gaUtayjDJ4jkzlBlCIzQvl912qxpWLlcfUg+EgPZfcpx5tnTFAsWaa2GI4UiEUhs3KUnpaQw1XXyR5tx0g4rr6zSwq5PpfI2zTJ0bGVG0EYFxT7ihga4xSRL4g0rPThMUNtYJOsOsMWxmb7nFyyrl7Ajnf2Npy9nDYn9RW4tiLY1BxtZw0TK99VOfUBWxtmHVCk1Zc7EK9PvPd9izsanNiraiJZoiETY0ZbZsnViStv49plvPGGEqucaLV2vKpa8JxnJxOdP4yKaNE8Ll3viiRRP9CDP9cw4b41xmgxbeOUI659YLfuudawHmQ7lRzIksq7SqUh9+8426fsVqDdJb27H2aR28/w+B1s7na3bNmpC26uqx4ju6cYeyJ2h7W87AZ5Yb9G/boWI0nDjerQP33n92LGMqD1Ca5kNsvBrbsSM4fzEg2hiBlf6VTJ8rnRc6GgMXaCUNbd+td7zrXVo6bWZwb0NyXPsfeFAZzDJY4Tl3hMn3xiRhdHTLbvCjBPyguWHMnzmMyRwrPp33/ja4YktXAbZMfo75Z0H4EfICH6x4CfOYepTkyI40bvNqff7MdGf/vUAAlsSESkvUdstN2hX3tCg1qjG6vD966PcqWbYQ6dOUsVBlGsA8TSOBSU5qhGzSJy3NsnQeXDKNwXhwcH9R2xSVrGBR1ISFy6RP9MLIOV5o1435yfEmyeTZWEuzymyLC9A5vGGLMrbQwXx/7fECAYAoKmLVpHz+7KAk/u69d2tw9155Fn5st0VLk1JIP0B7ytQoPp850g3TFDyTxJxhLmI7Mzgy3biBITTXbbdGkND8GRwJHngx83aRa7EprFWy2dFoDNPnT5t7BQ+c7w9g/sJU6nw3Bde8mVPbOuzm4AUTaVrGaVpIDkB26Ce/0NjRLkXZGZIfGdUImwwtVJnWi1ctVGxWO52bIqWPE9K43wjyCZWRlgbFL2IFmP8+pl4YJqNEi5mTfQpx/1jnAbq/LKag/bNzT9Jwvv+MnaaPFwZfMoTPJD0+nDWY78XPgyaK5FnJKrCv8QJezlWve8sLodYkF5guWrP/SD8wc2MuOOcN6XAJDMZrKGzY11fqRHXovic0TmXYtnKOWt5yLYnKZgjMK3lyXIn1O+3p4DcwbxgK/gcs8NGFHAjQeob8Yxz+nM9S+MgEEE8dCea+kGFDTy74P8F9Nl4w+JmnJszL5MuPzcd1q4OsBrD47dGCXl38iC5dVqHKpmYlmq/SriMVmnvNkGLsCvFogz2xdlCbx1+r7HwenBhw4h+T2RgTBwJmDiPcFmGsLzAZZf50D48bfRYEjA7eB/dwYvSdHYdpQpkRXb2TjRpZSnpry73CEaroZp0PzY6Ro8dL2As4MTqpKSYEMkcoX22OAlvoUmyIjlPmBtxwbdv+ES2cWaqi2oJuWFquT19WoYfo52UB0yRJ5IEtrAaN3K0y6otgSwxjp+kk2X6/IlzBJGtzZ8ZGtHhFVN19xUr0FzTOPcZljHA8ec+F0TfOXDRQbE+x8XEBh5P5Km29dFT/tGuBvrD4eUXp7lhX58vbFmteZUI3thwMBNCdjOv7++bpa0s3Beemyo9tulhvmwZG3PwNLV18s2BJnaz57d36E73hmU8qR/7wPzZcpm8vWaf6+ET76xddc3RwKKLbl7JoSkt7vBDWp/L/U0NV7EjJZ3R79k49tpt6g0bnB2d1InmazBdI3w/3z9Pn5m/VbWuns0BCA+YCZBD6+vE3UwI7Wp+I6ZvdzdYVD6T3dKJEe7G5fc6CQAsjtIvWJ+L6+vGms3LdNFqh1polNDTaVUWPbw79ORrbSkD0d3regCYLrPVX6nsny9mjT4gNkRpPrdfBLumrRwFQOtAZ+g+HqxpUT0+x53SRfnr6Eu0cwTLwt8Fjs4K5L5y+Yn37BEtvOWvT41IXIABHH+ozA+eXBQiXam7SWYMGmfkQLhAcWAaLHXJLzpy6mjalWze/LaYi9hHE6Z9Nj1Zob6ZH4/je5h2O7nuAnWTs76e6Cp5ZXveY5tYe50sMnh4+skZDqXaugyfesGY29OtAXxNWw5KYznShRNgLjgukz0dLuNVNPR9ggZn2vIHWKxwhVdZM3GLSmsQTu/Li8xdda4wc1JLKp+jPz1ec2mHLvhLd8UyFrr9sjD1NfapN7WCfcLW2Dr8FS7dwx0KPtwLNdLMBPa/iqjoEMDF3XrXak5zBypJNwjGpuZej53z0cX8FfvidL/9WFTGEdnagYNTz/nH0v8/C8XlvON/FkJPWNVX/ppiGFKJ6zDa+QQ/sWEx3lt5/ka9LW59Q6cgzaNZR1/gCbR5+MzaGNUFgcxGYAmHd42h/ktHzTfJqrsGzfefjxO2syVzg869KAMZJY+SAVpX9Rqcy7Vo/eD2tdPqJZ7TC3nKtqryfNflD2jT0FvWkZ/HEGW4ntfq3Zv4Mw8UsuHxn6k9V7OAOFxAJXqUAmA1GaiJd7JOoYwMHzL/oCENIWaiXJYGWv72mXzTX2VOEGs6O6NrtfB8py1L+BeQBr14ANqtp8+U0+Uqfn6X8b/QGF6iIs/P0tgQYMGlqLz/2C4uhl7/3pZ++HPN29yt9/tIR/+orlsiV087jS28XdPx1ArigKf7/3kReqWOFu1RBGD+LOy9Dgq1o/ElT51rNpPYmr7343Aa1MGufv+w9PGiB5s/dMzmujfdK90x+bvdOPjd5zc5hJUuuclz/zte5BtlUy+auMzfaIrCtVJtQ7L1dt1eo+ugvoC+vsQS1QCmbHPmx3zHW3m2fTVALMLZtQ0+fWwtwLUm9EGXtwDq/9kyWL0BZ+ltUzIZGCLNCZZSNyxXYY8GWwrnH9hBbI7OI5a7gHrLNMVaLJ+oQJMo9Kbbm25uJWoDbLpC+FLtJahujiuIGBw60qqYuiTuwoZPROjtr1TptSCWxjPbur1FdfSL4LNSz5D1/yrUXXkAtsGRTQLiN+vHNl+iWaQe1svoUU0h/7G3Qc71V+sTC3UiMHXS5kD7S9Xd6V+tBXeltIS8o6O6uGdo3HNdnFlMLcE+arPCO7Uv06Xk7VBGl4YoMfrSHrXOsDr+kFngF+n6wd66+snCbDsUWsh1uPgs1Ob3v3Vv4vkKJ7vzBMn32y0+pJpbVuqdb+GpfXu9991aFvtZ9Q1ALrEtG9Y0TLcFqrDG3NlnC9wIL2usuChgeSflalyzW17qnnBGAo00pvuHV16pHzyxPHxvydHSU7/0cnx0wV1PNzs0lC3W/Fqirr0Gn+sPaOVjMjm7s7Pj0wGRztM7XJ4v07Z7WYKuSzb1hdGJ57PTxOcFcVgtcEH2JYn2vv1EVG0N65onW4NkFi07p6Senqvt4mf7rZwu15oqjevqJtsArFy+1tYkPHAqMlb1jLA2RRplPQQR7Vvhjpn2mFsAMg2sO9ULwOR/jaazXcM59dljeb1+1ccnn8cfaij5d27I20ObG3vnafRKGzu5/PwPTtgafZ+7JOiQY+0zr3WFso8f+XAh97FMKw8JV8bvVta+YPMBR+4xB9XSXUIbTwovm1NiU0KGDlaTkjuYuoPN11etvCKawaf62B1+tQLtl9awh0lIb3Efv0Oz7ArKzV0+HfZ0jrN6S5cFX/Exwebb7uvYNUwRrWFxgFdtc0Y5cztX/A7WoQWxdAOR6AAAAAElFTkSuQmCC"
local fbox = { type = "fixed", fixed = { -8 / 16, -1 / 2, -8 / 16, 8 / 16, -7.5 / 16, 8 / 16 } }
local def = {
    description = "Arkacia 1.0 News - New Spawn (4x4) - 16",
    drawtype = "nodebox",
    tiles = {
        { name = texture },
        { name = texture },
        { name = "blank.png" },
        { name = "blank.png" },
        { name = "blank.png" },
        { name = "blank.png" },
    },
    use_texture_alpha = "clip",
    node_box = fbox,
    collision_box = fbox,
    groups = { oddly_breakable_by_hand = 1, z_item = 1, dig_immediate = 3, not_in_creative_inventory = 1, },
    selection_box = fbox,
    paramtype = "light",
    paramtype2 = "wallmounted",
    sunlight_propagates = true,
    node_placement_prediction = "",
    inventory_image = texture,
}
if 16 == 1 then
    local function rad_to_param2(rad)
        local tau = math.pi * 2
        if rad < tau * 7 / 8 and rad >= tau * 5 / 8 then
            return 2
        elseif rad < tau * 5 / 8 and rad >= tau * 3 / 8 then
            return 5
        elseif rad < tau * 3 / 8 and rad >= tau * 1 / 8 then
            return 3
        else
            return 4
        end
    end
    table.update(def, {
        description = "Arkacia 1.0 News - New Spawn (4x4) - Top Left",
        groups = { oddly_breakable_by_hand = 1, z_item = 1, dig_immediate = 3, not_in_creative_inventory = 0, },
        on_place = function(itemstack, placer, pointed_thing)
            local under = pointed_thing.under
            local player_name = placer and placer:get_player_name() or ""

            local rc = mcl_util.call_on_rightclick(itemstack, placer, pointed_thing)
            if rc then return rc end

            local pos
            local undername = minetest.get_node(under).name
            if minetest.registered_items[undername] and minetest.registered_items[undername].buildable_to then
                pos = under
            else
                pos = pointed_thing.above
            end


            local dir = placer and placer:is_player() and placer:get_look_dir() and
                rad_to_param2(placer:get_look_horizontal()) or 0

            local pos_list = {}
            local pln = 1
            for a = 0, 3 do
                for b = 0, 3 do
                    pos_list[pln] = {x=a, y=b}
                    pln = pln + 1
                end
            end
            for i, p in pairs(pos_list) do
                local botpos = vector.add(pos,
                    vector.rotate_around_axis(vector.new(p.x, -p.y, 0), vector.new(0, 1, 0),
                        math.round(placer:get_look_horizontal() / (math.pi / 2)) * (math.pi / 2)))

                if minetest.is_protected(botpos, player_name) and
                    not minetest.check_player_privs(player_name, "protection_bypass") then
                    minetest.record_protection_violation(botpos, player_name)
                    goto continue
                end

                local botdef = minetest.registered_nodes[minetest.get_node(botpos).name]
                if not botdef or not botdef.buildable_to then
                    goto continue
                end

                minetest.set_node(botpos, { name = "arkacia:poster_arkacia_news_1_0_4x4_" .. i, param2 = dir })
                ::continue::
            end

            if not minetest.is_creative_enabled(player_name) then
                itemstack:take_item()
            end
            return itemstack
        end,
    })
end
minetest.register_node(":arkacia:poster_arkacia_news_1_0_4x4_16", def)