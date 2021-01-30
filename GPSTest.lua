string.startswith = function(self, str) 
    return self:find('^' .. str) ~= nil
end

msg = 0
local toX,toY,toZ

while msg <= 1 do

    senderId,message,protocol = rednet.received("QuarryCords")
    
    if message:startswith("MyX") then
        toX = message
    end

    if message:startswith("MyY") then
        toY = message
    end

    if message:startswith("MyZ") then
        toZ = message
    end

    if message == "start" then
        msg = 1
    end

end




