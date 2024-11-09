local Globals <const> = require('Globals')
local setmetatable <const> = setmetatable
local concat <const> = table.concat
local match <const> = string.match
local gsub <const> = string.gsub

local ClassData <const> = { __type = "ClassData"}
ClassData.__index = ClassData

_ENV = ClassData


function ClassData:toString()
	local strTbl <const> = { "{ className = ",self.className,"; classVars = ",concat(self.vars,","),"; parentClass = ",self.parentClass,"; parentVars = ",concat(self.parentVars,","),"; }" }
	return concat(strTbl)
end

function ClassData:setStaticFunctions(tbl)
	self.staticFunctions = tbl or Globals.emptyTbl
	return self
end

function ClassData:setClassFunctions(tbl)
	self.classFunctions = tbl or Globals.emptyTbl
	return self
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
	local parentClass <const> = tbl[1] or ""
	local path <const> = match(parentClass,"^(.+[/\\])") or ""
	self.parentPath = gsub(path,"[\\/]+",".")
	self.parentClass = match(parentClass,"[\\/]?([^/\\]*)$")
	return self
end

function ClassData:setParentVars(tbl)
	self.parentVars = tbl or Globals.emptyTbl
	return self
end

function ClassData:new()
	return setmetatable({className = "", vars = Globals.emptyTbl, parentVars = Globals.emptyTbl, parentClass = "",staticFunctions = Globals.emptyTbl,classFunctions = Globals.emptyTbl},self)
end

return ClassData
