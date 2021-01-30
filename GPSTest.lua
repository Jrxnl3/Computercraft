myCords = {0,0,0}

toCords = {0,0,0}

myCords = gps.locate(1)

for i = 1,4,1   do 
    print(myCords[i])
end

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


