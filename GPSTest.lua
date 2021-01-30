myCords = {0,0,0}

toCords = {0,0,0}

local x,y,z = gps.locate(1)
myCords[1] = x
myCords[2] = y
myCords[3] = z


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


