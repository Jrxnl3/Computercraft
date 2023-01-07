local modem = peripheral.find("modem") or error("No modem attached", 0)
local dfpwm = require("cc.audio.dfpwm")
local speaker = peripheral.find("speaker")

modem.open(69) 

local decoder = dfpwm.make_decoder()

-- And wait for a reply
local event, side, channel, replyChannel, message, distance
repeat
  event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
    if message[1] == "play" then
        for chunk in io.lines("/music/"..message[2]..".dfpwm", 16 * 1024) do
            local buffer = decoder(chunk)
        
            while not speaker.playAudio(buffer, 1.5) do
                os.pullEvent("speaker_audio_empty")
            end
        end
    end
until channel == 69