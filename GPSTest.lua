string.startswith = function(self, str) 
    return self:find('^' .. str) ~= nil
end

msg = 0

toCords = {"toX","toY","toZ"}

rednet.open("left")


    for i = 1,4,1   do 

        senderId,message,protocol = rednet.receive("QuarryCords")

        toCords[i] = message
        print(toCords[i])
    end


    senderId,message,protocol = rednet.receive("QuarryCords")

    if message == "start" then
        msg = 1
        print("Received "..msg)

    end


