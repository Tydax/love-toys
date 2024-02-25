local Object = require("libs/classic")

---@meta

---@class (exact) Point1D
---@field x number

---@class (exact) Segment
---@field left Point1D
---@field right Point1D

---@class CollisionSegment: Segment
local CollisionSegment = Object:extend()

---Constructs a new collision segment, starting from `leftPoint` to the `rightPoint`
---@param leftPoint Point1D
---@param rightPoint Point1D
function CollisionSegment:new(leftPoint, rightPoint)
   self.left = leftPoint
   self.right = rightPoint
end

---Checks if a point is inside a segment, returns `true` if it is.
---@param point Point1D
---@param segment Segment
---@return boolean
local function isPointInsideSegment(point, segment)
   return segment.left.x <= point.x and point.x <= segment.right.x
end

-- self.left.x     300
-- self.right.x    410
-- bounds.left.x      -1
-- bounds.right.x     0
function CollisionSegment:isCollidingWith(bounds)
   print('self.left.x', self.left.x)
   print('self.right.x', self.right.x)
   print('seg.left.x', bounds.left.x)
   print('seg.right.x', bounds.right.x)
   print('isPointInsideSegment(bounds.left, self)',
      isPointInsideSegment(bounds.left, self))
   print('isPointInsideSegment(bounds.right, self)',
      isPointInsideSegment(bounds.right, self))
   print('isPointInsideSegment(self.left, bounds)',
      isPointInsideSegment(self.left, bounds))
   print('isPointInsideSegment(self.right, bounds)',
      isPointInsideSegment(self.right, bounds))


   return isPointInsideSegment(bounds.left, self)
       or isPointInsideSegment(bounds.right, self)
       or isPointInsideSegment(self.left, bounds)
       or isPointInsideSegment(self.right, bounds)
end

return CollisionSegment
