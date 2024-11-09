--[[
    This file is part of Class Generator.

    Class Generator is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, version 3 of the License only.

    Class Generator is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

    You should have received a copy of the GNU General Public License along with Foobar. If not, see <https://www.gnu.org/licenses/>.
--]]
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
	s = ClassData.setParentVars,
	m = ClassData.setClassFunctions,
	f = ClassData.setStaticFunctions
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
