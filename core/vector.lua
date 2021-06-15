vector = {}
vector.__index = vector
 
function vector.__add(a, b)
  if type(a) == "number" then
    return vector.new(b.x + a, b.y + a)
  elseif type(b) == "number" then
    return vector.new(a.x + b, a.y + b)
  else
    return vector.new(a.x + b.x, a.y + b.y)
  end
end
 
function vector.__sub(a, b)
  if type(a) == "number" then
    return vector.new(b.x - a, b.y - a)
  elseif type(b) == "number" then
    return vector.new(a.x - b, a.y - b)
  else
    return vector.new(a.x - b.x, a.y - b.y)
  end
end
 
function vector.__mul(a, b)
  if type(a) == "number" then
    return vector.new(b.x * a, b.y * a)
  elseif type(b) == "number" then
    return vector.new(a.x * b, a.y * b)
  else
    return vector.new(a.x * b.x, a.y * b.y)
  end
end
 
function vector.__div(a, b)
  if type(a) == "number" then
    return vector.new(b.x / a, b.y / a)
  elseif type(b) == "number" then
    return vector.new(a.x / b, a.y / b)
  else
    return vector.new(a.x / b.x, a.y / b.y)
  end
end
 
function vector.__eq(a, b)
  return a.x == b.x and a.y == b.y
end
 
function vector.__lt(a, b)
  return a.x < b.x or (a.x == b.x and a.y < b.y)
end
 
function vector.__le(a, b)
  return a.x <= b.x and a.y <= b.y
end
 
function vector.__tostring(a)
  return "(" .. a.x .. ", " .. a.y .. ")"
end
 
function vector.new(x, y)
  return setmetatable({ x = x or 0, y = y or 0 }, vector)
end
 
function vector.distance(a, b)
  return (b - a):len()
end
 
function vector:clone()
  return vector.new(self.x, self.y)
end
 
function vector:unpack()
  return self.x, self.y
end
 
function vector:len()
  return math.sqrt(self.x * self.x + self.y * self.y)
end
 
function vector:lenSq()
  return self.x * self.x + self.y * self.y
end
 
function vector:normalize()
  local len = self:len()
  self.x = self.x / len
  self.y = self.y / len
  return self
end
 
function vector:normalized()
  return self / self:len()
end
 
function vector:rotate(phi)
  local c = math.cos(phi)
  local s = math.sin(phi)
  self.x = c * self.x - s * self.y
  self.y = s * self.x + c * self.y
  return self
end
 
function vector:rotated(phi)
  return self:clone():rotate(phi)
end
 
function vector:perpendicular()
  return vector.new(-self.y, self.x)
end
 
function vector:projectOn(other)
  return (self * other) * other / other:lenSq()
end
 
function vector:cross(other)
  return self.x * other.y - self.y * other.x
end
 
setmetatable(vector, { __call = function(_, ...) return vector.new(...) end })