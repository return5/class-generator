--[[
	Class Generator. command line tool to generate skeleton of a lua class.className
	Copyright (C) <2024> github/return5

	This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, exclusively version 3 of the License.

	This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

	You should have received a copy of the GNU General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.
--]]

local ArgReader <const> = require('ArgReader')
local DataParser <const> = require('DataParser')
local ClassBuilder <const> = require('ClassBuilder')

local function main()
	local argsTable <const> = ArgReader:new().readArgs(arg)
	local classData <const> = DataParser:new().parseData(argsTable)
	local class <const> = ClassBuilder:new().buildClass(classData)
	local file <const> = io.open("./classes/" .. classData.className .. ".lua","w+")
	file:write(class)
	file:close()
end

main()
