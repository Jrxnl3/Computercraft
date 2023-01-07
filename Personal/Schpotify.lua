local modem = peripheral.find("modem") or error("No modem attached", 0)
modem.open(69) -- Open 69 so we can receive replies

-- Send our message

message = {"play","sans"}

modem.transmit(69, 69, message)