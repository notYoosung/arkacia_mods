magikacia.textures = magikacia.textures or {}
local textures = {
    firefly_green = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAAXNSR0IArs4c6QAAAFpJREFUOE9jZKAQMFKon2E4G/D//38D5PBhZGS8gC28sIYBTLN9jstskKaDU/akgmhshuA0AKRZLFjSBKTx1drnZ0CG0NcAkM1kewGkmaJAJCV1DueUSGw4AAC4BzARPbvQuwAAAA5lWElmTU0AKgAAAAgAAAAAAAAA0lOTAAAAAElFTkSuQmCC",
    firefly_purple = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAAXNSR0IArs4c6QAAAFpJREFUOE9jZKAQMFKon2E4G/D//38D5PBhZGS8gC28sIYBTHOkfdhskKblB1elgmhshuA0AKTZQtTMBKTxxOtTZ0CG0NcAkM1kewGkmaJAJCV1DueUSGw4AAC35zARyhHv2QAAAA5lWElmTU0AKgAAAAgAAAAAAAAA0lOTAAAAAElFTkSuQmCC",
    firefly_blue = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAAXNSR0IArs4c6QAAAFpJREFUOE9jZKAQMFKon2E4G/D//38D5PBhZGS8gC28sIYBTLODf9xskKYDGxelgmhshuA0AKRZUsfeBKTx+ZWDZ0CG0NcAkM1kewGkmaJAJCV1DueUSGw4AAC3xzARtWqbWQAAAA5lWElmTU0AKgAAAAgAAAAAAAAA0lOTAAAAAElFTkSuQmCC",
}
for k, v in pairs(textures) do
    textures[k] = "blank.png^[png:" .. textures[k]
end
table.update(magikacia.textures, textures)

