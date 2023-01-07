-- Usage (program name) <Width> <Depth> <Length> <Direction>
-- Place a chest with enough space for what you are digging behind the turtle before beginning
-- Put any fuel in the first slot, if you don't want to have to refuel, use refuel<amount> before running this
-- Make sure you keep the chunk(s) the turtle is digging in loaded, otherwise it will break


local tArgs = { ... }
if #tArgs ~= 4 then
	print( "Usage: excavate <Width> <Depth> <Length> <Direction>" )
	print( "Direction - 0 for down, 1 for up" )
	return
end


local size1    = tonumber( tArgs[1] )
local size2    = tonumber( tArgs[2] )
local size3    = tonumber( tArgs[3] )
local upordown = tonumber( tArgs[4] )
if size1 < 1 then
	print( "X size must be positive" )
	return
end
if size2 < 1 then
	print( "Depth must be positive" )
	return
end
if size3 < 1 then
	print( "Z size must be positive" )
	return
end
if upordown~=0 and upordown~=1 then
	print( "Invalid direction" )
	return
end

	
local depth = 0
local unloaded = 0
local collected = 0

local xPos,zPos = 0,0
local xDir,zDir = 0,1

local goTo -- Filled in further down
local refuel -- Filled in further down

local function unload()
	print( "Unloading items..." )
	for n=2,16 do
		unloaded = unloaded + turtle.getItemCount(n)
		turtle.select(n)
		turtle.drop()
	end
	collected = 0
	turtle.select(1)
end

local function returnSupplies()
	local x,y,z,xd,zd = xPos,depth,zPos,xDir,zDir
	print( "Returning to surface..." )
	goTo( 0,0,0,0,-1 )
	
	local fuelNeeded = x+y+z + x+y+z + 1
	if not refuel( fuelNeeded ) then
		unload()
		print( "Waiting for fuel" )
		while not refuel( fuelNeeded ) do
			sleep(1)
		end
	else
		unload()	
	end
	
	print( "Resuming mining..." )
	goTo( x,y,z,xd,zd )
end

local function collect()	
	local bFull = true
	local nTotalItems = 0
	for n=1,16 do
		local nCount = turtle.getItemCount(n)
		if nCount == 0 then
			bFull = false
		end
		nTotalItems = nTotalItems + nCount
	end
	
	if nTotalItems > collected then
		collected = nTotalItems
		if math.fmod(collected + unloaded, 50) == 0 then
			print( "Mined "..(collected + unloaded).." items." )
		end
	end
	
	if bFull then
		print( "No empty slots left." )
		return false
	end
	return true
end

function refuel( ammount )
	local fuelLevel = turtle.getFuelLevel()
	if fuelLevel == "unlimited" then
		return true
	end
	
	local needed = ammount or (xPos + zPos + depth + 1)
	if turtle.getFuelLevel() < needed then
		local fueled = false
		for n=1,16 do
			if turtle.getItemCount(n) > 0 then
				turtle.select(n)
				if turtle.refuel(1) then
					while turtle.getItemCount(n) > 0 and turtle.getFuelLevel() < needed do
						turtle.refuel(1)
					end
					if turtle.getFuelLevel() >= needed then
						turtle.select(1)
						return true
					end
				end
			end
		end
		turtle.select(1)
		return false
	end
	
	return true
end

local function tryForwards()
	if not refuel() then
		print( "Not enough Fuel" )
		returnSupplies()
	end
	
	while not turtle.forward() do
		if turtle.detect() then
			if turtle.dig() then
				if not collect() then
					returnSupplies()
				end
			else
				return false
			end
		elseif turtle.attack() then
			if not collect() then
				returnSupplies()
			end
		else
			sleep( 0.5 )
		end
	end
	
	xPos = xPos + xDir
	zPos = zPos + zDir
	return true
end

local function tryDown()
	if not refuel() then
		print( "Not enough Fuel" )
		returnSupplies()
	end
	
	while not turtle.down() do
		if turtle.detectDown() then
			if turtle.digDown() then
				if not collect() then
					returnSupplies()
				end
			else
				return false
			end
		elseif turtle.attackDown() then
			if not collect() then
				returnSupplies()
			end
		else
			sleep( 0.5 )
		end
	end

	depth = depth + 1

	return true
end

local function tryUp()
	if not refuel() then
		print( "Not enough Fuel" )
		returnSupplies()
	end
	
	while not turtle.up() do
		if turtle.detectUp() then
			if turtle.digUp() then
				if not collect() then
					returnSupplies()
				end
			else
				return false
			end
		elseif turtle.attackUp() then
			if not collect() then
				returnSupplies()
			end
		else
			sleep( 0.5 )
		end
	end

	depth = depth - 1

	return true
end

local function turnLeft()
	turtle.turnLeft()
	xDir, zDir = -zDir, xDir
end

local function turnRight()
	turtle.turnRight()
	xDir, zDir = zDir, -xDir
end

function goTo( x, y, z, xd, zd )
	while depth > y do
		if turtle.up() then
			depth = depth - 1
		elseif turtle.digUp() or turtle.attackUp() then
			collect()
		else
			sleep( 0.5 )
		end
	end

	if xPos > x then
		while xDir ~= -1 do
			turnLeft()
		end
		while xPos > x do
			if turtle.forward() then
				xPos = xPos - 1
			elseif turtle.dig() or turtle.attack() then
				collect()
			else
				sleep( 0.5 )
			end
		end
	elseif xPos < x then
		while xDir ~= 1 do
			turnLeft()
		end
		while xPos < x do
			if turtle.forward() then
				xPos = xPos + 1
			elseif turtle.dig() or turtle.attack() then
				collect()
			else
				sleep( 0.5 )
			end
		end
	end
	
	if zPos > z then
		while zDir ~= -1 do
			turnLeft()
		end
		while zPos > z do
			if turtle.forward() then
				zPos = zPos - 1
			elseif turtle.dig() or turtle.attack() then
				collect()
			else
				sleep( 0.5 )
			end
		end
	elseif zPos < z then
		while zDir ~= 1 do
			turnLeft()
		end
		while zPos < z do
			if turtle.forward() then
				zPos = zPos + 1
			elseif turtle.dig() or turtle.attack() then
				collect()
			else
				sleep( 0.5 )
			end
		end	
	end
	
	while depth < y do
		if turtle.down() then
			depth = depth + 1
		elseif turtle.digDown() or turtle.attackDown() then
			collect()
		else
			sleep( 0.5 )
		end
	end
	
	while zDir ~= zd or xDir ~= xd do
		turnLeft()
	end
end

if not refuel() then
	print( "Out of Fuel" )
	return
end

print( "Excavating..." )

local reseal = false
turtle.select(1)
if upordown == 0 then
	if turtle.digDown() then
	end
elseif upordown == 1 then
	if turtle.digUp() then
	end
end

local alternate = 0
local done = 0
while done~=size2 do
	for varx=1,size1 do
		for varz=1,size3-1 do
			if not tryForwards() then
				done = size2
				break
			end
		end
		if done==size2 then
			break
		end
		if varx<size1 then
			if math.fmod(varx + alternate,2) == 0 then
				turnLeft()
				if not tryForwards() then
					done = size2
					break
				end
				turnLeft()
			else
				turnRight()
				if not tryForwards() then
					done = size2
					break
				end
				turnRight()
			end
		end
	end
	if done==size2 then
		break
	end
	
	if size1 > 1 then
		goTo( 0,depth,0,0,1 )
	end
	if done ~= size2-1 then
		if upordown == 0 then
			if not tryDown() then
				done = size2
				break
			end
		elseif upordown == 1 then
			if not tryUp() then
				done = size2
				break
			end
		end
	end
	done = done + 1
end

print( "Returning to surface..." )

-- Return to where we started
goTo( 0,0,0,0,-1 )
unload()
goTo( 0,0,0,0,1 )

-- Seal the hole
if reseal then
	turtle.placeDown()
end

print( "Mined "..(collected + unloaded).." items total." )