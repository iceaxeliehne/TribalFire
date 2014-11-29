
local tileClass = {}
tileClass.__index = className
 -- table titled with class name holds the functions of the class
 -- table titled _mt provides instances of class with 
 -- meta table classname. ie it tells the instance to look
 -- for functions in the className table

 function className:new(property1,property2)
 	local newInstance = {
 		property = property1
 		info = property2
 	}
 	return setmetatable( newInstance, self )
 end

 --[[ constructor function
	called by 
	local instancename = className.new(propety1,property2)

	saves table of instance propeties with className_mt meta table
	wich tells the computer to look for functions in the className 
	table
]]--

-- private functions

local function title(parameter)
	return parameter
end

-- public functions

function className:functionTitle()
	print("put stuff here")
end

--[[ stores function in className table 
allowing instances to share it
]]--