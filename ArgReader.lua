--[[
    This file is part of Class Generator.

    Class Generator is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, version 3 of the License only.

    Class Generator is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

    You should have received a copy of the GNU General Public License along with Foobar. If not, see <https://www.gnu.org/licenses/>.
--]]
local setmetatable <const> = setmetatable
local gmatch <const> = string.gmatch
local concat <const> = table.concat

local ArgReader <const> = {__type = "ArgReader"}
ArgReader.__index = ArgReader

_ENV = ArgReader

local function loopOverOptions(flag,options,argsTable)
	local tbl <const> = {}
	if options and options ~= "" then
		for opt in gmatch(options,"([^,]+)") do
			tbl[#tbl + 1] = opt
		end
	end
	argsTable[flag] = tbl
end

function ArgReader.readArgs(args)
	local argsTable <const> = {}
	local argStr <const> = concat(args," ")
	for flag, options in gmatch(argStr,"-(%S*)%s*([^-%s]*)") do
		loopOverOptions(flag,options,argsTable)
	end
	return argsTable
end

function ArgReader:new()
	return setmetatable({},self)
end

return ArgReader
