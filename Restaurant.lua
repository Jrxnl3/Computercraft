local dfpwm = require("cc.audio.dfpwm")
local speaker = peripheral.find("speaker")

local decoder = dfpwm.make_decoder()

local music = fs.list("/music/")

for songID = 1, #music do
  for chunk in io.lines("/music/"..music[songID], 16 * 1024) do
    local buffer = decoder(chunk)

    while not speaker.playAudio(buffer, 2.0) do
        os.pullEvent("speaker_audio_empty")
    end
  end
end
os.reboot()