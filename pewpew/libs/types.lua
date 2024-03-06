---@meta

---@class (exact) Object
---@field super Object
local Object = {}
function Object:new() end

function Object:extend() end

---@param ... unknown
function Object:implement(...) end

---@param T any
---@return boolean
function Object:is(T) end

---@return string
function Object:__tostring() end

return Object
