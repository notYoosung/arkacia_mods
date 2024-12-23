local textures = {
    spellbook_netherite_inv = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAAXNSR0IArs4c6QAAAVJJREFUOE9jZKAQMBLSryMv8x+m5srDJxjqcRoA0yghKcYgwMvLIKigxnB813YGdEMwDEDXCLL9w+fPYEcExCQxzOjuQDEEbgA+jTAvgFzi4B+KYggjMRpBNl+8eJHh/YNbYK/o6+vDDQEbAPKnoq4xw/3LZ1HCFCQGUnxg42qwOEizr68vmN1SUcrw7etXBrABLoEhDFdOHAL7ccOSeeBAQwYgjcXFxQy3bt0CawQBVUMThqVLlzLCDXB3d2fobaxmyKtqYNi8eTPcuSCNIBAX5A+mk/OLGOTk5BgePXrEkJ6ezsgozc/zX1NTjWHSvCUMDx8+hBuipqaGVSNIEKR57sQ+iBdAAtgM+fTpK4qN6BqvPHwClodHI7ohIFtATsWlEaYXJSFhMwTmVJiNyJaiuAAW6jBDYF44de0mTAprsscqCDLk6ccveDUSJYmSGHBwAKOwttyhuCpgAAAADmVYSWZNTQAqAAAACAAAAAAAAADSU5MAAAAASUVORK5CYII=",
    spellbook_diamond_inv = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAAXNSR0IArs4c6QAAATtJREFUOE9jZCAAhHrm/ocpeVeSzIiuHEMApgCkke3rGwbtZHeGK6cvMjBeesHwi1uEAd0QDAOQbTSMMGYIFxaGW1oxdRd+A2CakTWufPuW4fyKswwwMXRD4C5A1gyzEmY7SFNHthvcJXVdy8DsF/XljGADkP0L4mPTCDME5CKYGpAYI0gzyHRkW3CxYd4BBS4oQEEAxQBkf4IkQQbDbASFA0wslUOG4dTlqwz+67dCDHhbnMSweMs2hoKbLxhgUQfyBsivMJtAhsE0ggwy09VmkGzqghgA0vS8rgzFEFiIdRnpMMT6eIFthGkEWbbQUBocO/BABEnCXALTALIFXSPMlfAwQE55uAyBeQ85GcNSJEpKhKUFmEtAGkA2YtMIE8OalEFh8l9PAmf6RzYQa2YilAMJGkAgh6NIAwAANs07cvHfpwAAAA5lWElmTU0AKgAAAAgAAAAAAAAA0lOTAAAAAElFTkSuQmCC",
    spellbook_gold_inv = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAAXNSR0IArs4c6QAAAeRJREFUOE+FUzssg1EUPjcRkZakourd1NAFC2oQBiIhnTwGpBImbQwiEo/EJrGoAZFGtBaCeC9ikdi8hhKPsommREsr8WrTFPnlnLo3fSXOcu8993zf+b7z35/BP5GdqZR4icfrY7HlcQlewIHyVDmolBmUvnO6IJYkjkC67aCOz449aBorIOD7xyetjt0Kymc1egVObLCj+6SBCrHIdf0K6mIFre22XDiaCsBgnw8qi2TQYpIJEhYptUpyEcHCvgG66lZo32tMAvtBMuiqQ7Qe3wQov+fPIDtEwH0++15gtfuROmOoSuqFIuyOcZqipdXvD0AwGAQi2FwcBm3ITHJ5F5SKXTF0ba1gX1unPd6PX6XDkrUPqvWDYQXoHSUjKDK43IlpJfnnlkhBqQVq9MYwwU7/m2DnIEwcMjX8fP/ARs+TsIUqZ6zfMLq1DIXlBsbS5DLp/bKZJo9djLNmMPXbyCMGSrX2DAlhqGZ7LkA2aAZ406lhEk4bZenKtHB+ZheAPFUeZObn0Nn74AaNYpfmUTHyRTnxDpAEJ2yZHCASLI4E1jYNUceLeUZKF50SYaNeItpRF+RHkXCgxxseYqeGCXAcASY4CZ+B8/6B20n43yRMIsnH3xBjVUZ95/8uY4sTnX8Be1PhkKbWrr0AAAAOZVhJZk1NACoAAAAIAAAAAAAAANJTkwAAAABJRU5ErkJggg==",
    spellbook_iron_inv = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAAXNSR0IArs4c6QAAAUxJREFUOE9jZKAQMBLSv2PHjv8gNR4eHljV4jQAppGfnx9sx+vXrxn8/Pww1GMIwDTKysoyfPr0ieHnz58MO/sTwIZYJk/CMARuAEyjpqYmw5cvX8A2LmgMB2uU5OOE+/TIzXcMh298gutjRHYqHx8f2NaZVQFwTTeefQJr1pDiw2oI2ACQP5GdClIJ0gjTBGLz87BidQnjpk2b/oNshvnz+afvKLYjGwJjg9R8/PKb4c3nPwxwA0D+hfkV3XZ0jSAXxmU4MAQmr2OEG8DPsZ9hYuUMrIbAbIRpBNGLZhwAhwk4NEHeWNefyjBp8SKGvNg4uCHoGhW0dRmacieDnX7zxXeEAdgMAfkRZiM2ja8+/AZbjpKQbDX4/itLcoJdcvfJMbAB6DbCNMLiFCMlwgyBueDo7c9gtegacRoAkgAZAvMjLo14DSCUQ5HlAaSm00TuAF1kAAAADmVYSWZNTQAqAAAACAAAAAAAAADSU5MAAAAASUVORK5CYII=",
    spellbook_leather_inv = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAAXNSR0IArs4c6QAAAalJREFUOE9jZCAAXJUE/8OU7L73nhFdOYYATAFIoygnE0NAoCjDq/vfGI5d+Mrw+vs/BnRDMAzQV5IF2yjCxc4gzMvOIMTHBbf0+O0XDBfvPUbRA+YgO/MflzCKxnefvjG8/fwTLoZuCCNIc2qUONiZ6y+ygRXCAMz220/fM6hKC8LFPz25B2Yvu/qWkVFJkOu/hRQnWOAPnwSYxqYRZgjIRSHOfxnUtIwZSmu2MTBaq8r+VzZWY3h65SHcFmQbkdkgzTdffmLQ5vwGD1AUA2CBBtIEAiBngzSBAEgjCOibqTEEepswiIqIMNh4lkK8UNGYzfD4yXOGY9tOMIj/fw+OOpATu1p3MFz9DokFZI0g/us3bxhWd8xhAAciKL4d0pNQDIGFmLK3J4ORrjTYRpjGc5efMuiynWGYvewlAzwaQdGXUx7MAJKEaQDZgq5x05qD8DAAGQhPFKDA5GBnx2oIyFCQRh5mBobnb94yKAuyw1MkSqpCNwRkA1zjR0hg3nv1FjMlImcQWLqwMuAGp/8Tz74z3Hv/DWeewSpBKAciW4jTZPRsi4sPALm41w3LBUk8AAAADmVYSWZNTQAqAAAACAAAAAAAAADSU5MAAAAASUVORK5CYII=",
}
for k, v in pairs(textures) do
    textures[k] = "blank.png^[png:" .. textures[k]
    minetest.register_craftitem(":magikacia:zzz_textures_" .. k, {
        description = k,
        inventory_image = textures[k],
    })
end
table.update(magikacia.textures, textures)