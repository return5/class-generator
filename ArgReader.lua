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
	for flag, options in gmatch(argStr,"-(%S*)%s*(%S*)") do
		loopOverOptions(flag,options,argsTable)
	end
	return argsTable
end

function ArgReader:new()
	return setmetatable({},self)
end

return ArgReader
