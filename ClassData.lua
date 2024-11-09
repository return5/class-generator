local Globals <const> = require('Globals')
local setmetatable <const> = setmetatable
local concat <const> = table.concat

local ClassData <const> = { __type = "ClassData"}
ClassData.__index = ClassData

_ENV = ClassData

function ClassData:toString()
	local strTbl <const> = { "{ className = ",self.className,"; classVars = ",concat(self.vars,","),"; parentClass = ",self.parentClass,"; parentVars = ",concat(self.parentVars,","),"; }" }
	return concat(strTbl)
end

function ClassData:setClassName(tbl)
	self.className = tbl[1] or ""
	return self
end

function ClassData:setVars(tbl)
	self.vars = tbl or Globals.emptyTbl
	return self
end

function ClassData:setParentClass(tbl)
	self.parentClass = tbl[1] or ""
	return self
end

function ClassData:setParentVars(tbl)
	self.parentVars = tbl or Globals.emptyTbl
	return self
end

function ClassData:new()
	return setmetatable({className = "", vars = Globals.emptyTbl, parentVars = Globals.emptyTbl, parentClass = ""},self)
end

return ClassData
