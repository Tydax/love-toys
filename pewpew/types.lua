---@meta

---@class (exact) Drawable
---@field drawables Drawable[]
---@field draw fun(self: Drawable): nil

---@alias MovementDirection "LEFT" | "RIGHT" | nil

---@class (exact) Updatable
---@field updatables Updatable[]
---@field update fun(self: Updatable, dt: number): nil
