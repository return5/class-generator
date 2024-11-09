--[[
    This file is part of Class Generator.

    Class Generator is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, version 3 of the License only.

    Class Generator is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

    You should have received a copy of the GNU General Public License along with Foobar. If not, see <https://www.gnu.org/licenses/>.
--]]
local Globals <const> = require('Globals')
local setmetatable <const> = setmetatable
local concat <const> = table.concat

local ClassBuilder <const> = { __type = "ClassBuilder"}
ClassBuilder.__index = ClassBuilder

_ENV = ClassBuilder

local function getParentClassStr(classData)
	if classData.parentClass == "" then return "" end
	local strTbl <const> = {"local ",classData.parentClass," <const> = require('",classData.parentPath,classData.parentClass,"')\n"}
	return concat(strTbl)
end

local function setParentClassMetatable(classData)
	if classData.parentClass == "" then return "" end
	local strTbl <const> = {"setmetatable(",classData.className,",",classData.parentClass,")\n\n"}
	return concat(strTbl)
end

local function addVarsToStrTbl(strTbl,vars)
	strTbl[#strTbl + 1] = vars[1]
	for i=2,#vars,1 do
		strTbl[#strTbl + 1] = ","
		strTbl[#strTbl + 1] = vars[i]
	end
end

local function generateConstructorFunctionStart(className,vars1,vars2)
	local strTbl <const> = {"function ",className,":new("}
	if vars2 ~= Globals.emptyTbl then
		addVarsToStrTbl(strTbl,vars2)
	end
	if vars1 ~= Globals.emptyTbl then
		if vars2 ~= Globals.emptyTbl then strTbl[#strTbl + 1] = "," end
		addVarsToStrTbl(strTbl,vars1)
	end
	strTbl[#strTbl + 1] = ")\n"
	return concat(strTbl)
end

local function generateSetMetatableNoParent(vars)
	if vars == Globals.emptyTbl then return "" end
	local strTbl <const> = {vars[1], " = ",vars[1]}
	for i=2,#vars,1 do
		strTbl[#strTbl + 1] = ","
		strTbl[#strTbl + 1] = vars[i]
		strTbl[#strTbl + 1] = " = "
		strTbl[#strTbl + 1] = vars[i]
	end
	return concat(strTbl)
end

local function generateConstructorNoParent(classData)
	local strTbl <const> = {
		generateConstructorFunctionStart(classData.className,classData.vars,classData.parentVars),
		"\treturn setmetatable({",generateSetMetatableNoParent(classData.vars),"},self)\nend\n\n"
	}
	return concat(strTbl)
end

local function generateCallToParentNew(vars)
	local strTbl < const> = {}
	addVarsToStrTbl(strTbl,vars)
	return concat(strTbl)
end

local function generateSetSelfVars(vars)
	if vars == Globals.emptyTbl then return "" end
	local strTbl <const> = {}
	for i=1,#vars,1 do
		strTbl[#strTbl + 1] = "\to."
		strTbl[#strTbl + 1] = vars[i]
		strTbl[#strTbl + 1] = " = "
		strTbl[#strTbl + 1] = vars[i]
		strTbl[#strTbl + 1] = "\n"
	end
	return concat(strTbl)
end

local function generateConstructorWithParent(classData)
	local strTbl <const> = {
		generateConstructorFunctionStart(classData.className,classData.vars,classData.parentVars),
		"\tlocal o <const> = setmetatable(",classData.parentClass,":new(",generateCallToParentNew(classData.parentVars),"),self)\n",
		generateSetSelfVars(classData.vars),
		"\treturn o\nend\n\n"
	}
	return concat(strTbl)

end

local function generateConstructor(classData)
	if classData.parentClass == "" then return generateConstructorNoParent(classData) end
	return generateConstructorWithParent(classData)
end

local function generateFunction(className,functionName,strTbl)
	strTbl[#strTbl + 1] = "function "
	strTbl[#strTbl + 1] = className
	strTbl[#strTbl + 1] = functionName
	strTbl[#strTbl + 1] ="()\n\nend\n\n"
end

local function generateFunctions(staticFunctions,classFunctions,className)
	local staticName <const> = className .. "."
	local methodName <const> = className .. ":"
	local strTbl <const> = {}
	for i=1,#staticFunctions,1 do
		generateFunction(staticName,staticFunctions[i],strTbl)
	end
	for i=1,#classFunctions,1 do
		generateFunction(methodName,classFunctions[i],strTbl)
	end
	return concat(strTbl)
end

function ClassBuilder.buildClass(classData)
	local strTbl <const> = {
		getParentClassStr(classData),
		"local setmetatable <const> = setmetatable\n\nlocal ",classData.className," <const> = {__type = '",classData.className,"'}\n",classData.className,".__index = ",classData.className,"\n\n",
		setParentClassMetatable(classData),
		"_ENV = ",classData.className,"\n\n",
		generateFunctions(classData.staticFunctions,classData.classFunctions,classData.className),
		generateConstructor(classData),
		"return ",classData.className,"\n"
	}
	return concat(strTbl)
end

function ClassBuilder:new()
	return setmetatable({},self)
end

return ClassBuilder
