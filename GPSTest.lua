string.startswith = function(self, str) 
    return self:find('^' .. str) ~= nil
end

msg = 0
local toX,toY,toZ

rednet.open("left")


    senderId,message,protocol = rednet.receive("QuarryCords")
    
    if message:startswith("MyX") then
        toX = message
        print("Received "..toX)
    end

    senderId,message,protocol = rednet.receive("QuarryCords")


    if message:startswith("MyY") then
        toY = message
        print("Received "..toY)

    end

    senderId,message,protocol = rednet.receive("QuarryCords")


    if message:startswith("MyZ") then
        toZ = message
        print("Received "..toZ)

    end

    senderId,message,protocol = rednet.receive("QuarryCords")

    if message == "start" then
        msg = 1
        print("Received "..msg)

    end
    
