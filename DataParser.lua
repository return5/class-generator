local ClassData <const> = require('ClassData')
local setmetatable <const> = setmetatable
local pairs <const> = pairs

local DataParser <const> = { __type = "DataParser"}
DataParser.__index = DataParser

_ENV = DataParser

local setters <const> = {
	p = ClassData.setParentClass,
	v = ClassData.setVars,
	c = ClassData.setClassName,
	s = ClassData.setParentVars
}

function DataParser.parseData(argsTbl)
	local classData <const> = ClassData:new()
	for flag,options in pairs(argsTbl) do
		if setters[flag] then
			setters[flag](classData,options)
		end
	end
	return classData
end

function DataParser:new()
	return setmetatable({},self)
end

return DataParser
