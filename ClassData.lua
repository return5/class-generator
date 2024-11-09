local setmetatable <const> = setmetatable

local ClassData <const> = { __type = "ClassData"}
ClassData.__index = ClassData

_ENV = ClassData

function ClassData:setClassName(tbl)
	self.className = tbl[1] or ""
	return self
end

function ClassData:setVars(tbl)
	self.vars = tbl or {}
	return self
end

function ClassData:setParentClass(tbl)
	self.parentClass = tbl[1] or ""
	return self
end

function ClassData:setParentVars(tbl)
	self.parentVars = tbl or {}
	return self
end

function ClassData:new()
	return setmetatable({},self)
end

return ClassData
