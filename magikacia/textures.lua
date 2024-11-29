magikacia.textures = magikacia.textures or {}
local textures = {
}
for k, v in pairs(textures) do
    textures[k] = "blank.png^[png:" .. textures[k]
end
table.update(magikacia.textures, textures)