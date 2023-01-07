local speaker = peripheral.find("speaker")

local dfpwm = require("cc.audio.dfpwm")
local decoder = dfpwm.make_decoder()

musicFolder = fs.list("/music/")

local choice local function printInterface()
    print("========Schpotify========")
    print("[1]. Print all Songs")
    print("[2]. Choose a Songs (ID)")
    print("[3]. Play a random Song")
    print("[4]. Play all Songs")
    print("[5]. Exit")
    print("========================")
    print("Auswahl: ")
    return io.read()
end

local function printAllSongs()
    for songID = 1, #musicFolder do
        local formattedString = string.sub(musicFolder[songID],0, #musicFolder[songID] - 6)
        print(formattedString)
    end
end

local function playSong(id)
    local songName = musicFolder[id + 0]

    for chunk in io.lines("/music/"..songName, 16 * 1024) do
        local buffer = decoder(chunk)

        while not speaker.playAudio(buffer, 2.0) do
            os.pullEvent("speaker_audio_empty")
        end
    end
end

local function playAllSongs()
    for songID = 1, #musicFolder do
        for chunk in io.lines("/music/"..musicFolder[songID], 16 * 1024) do
            local buffer = decoder(chunk)

            while not speaker.playAudio(buffer, 2.0) do
                os.pullEvent("speaker_audio_empty")
            end
        end
    end
end

local returnedSongID local function songAuswahl()
    print("Song ID: ")
    return io.read()
end

local userInput = printInterface()

if userInput == "1" then
    printAllSongs()
elseif userInput == "2" then
        local songGewaehltID = songAuswahl()
        playSong(songGewaehltID)
elseif userInput == "3" then
    local x = math.random(1, #musicFolder) --Pick a random question from a table
    playSong(x)
elseif userInput == "4" then
    playAllSongs()
end