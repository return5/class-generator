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
