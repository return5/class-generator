
local ArgReader <const> = require('ArgReader')
local DataParser <const> = require('DataParser')

local function main()
	local argsTable <const> = ArgReader:new().readArgs(arg)
	local classData <const> = DataParser:new().parseData(argsTable)
	io.write(classData:toString(),"\n")
end

main()
