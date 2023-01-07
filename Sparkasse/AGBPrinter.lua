local printer = peripheral.wrap("top")
local speaker = peripheral.wrap("bottom")

local function newLine() 
    local x, y = printer.getCursorPos()
    printer.setCursorPos(1,y+1)
end
local function writeText(stringText)
    for c in stringText:gmatch"." do
        local i,y = printer.getCursorPos()

        if i > 25 then
            newLine()
        end    
        if i == 1 and c == " " then
            --Nothing
        else
            printer.write(c)
        end
    end    
    newLine()
end
local function divider()
    writeText("-------------------------")
end
local function spacer()
    newLine()
end
local function writeCenter(stringText)
    local x,y = printer.getCursorPos()
    printer.setCursorPos(13-(#stringText/2),y)
    printer.write(stringText)
    newLine()
end

local function finish()
    printer.endPage()
    speaker.playSound("block.bell.use")

    print("Gedruckt!")

    os.sleep(3)
    shell.run("SparkasseManager")
end
local function nextPage()
    printer.endPage()
    printer.newPage()
end

printer.newPage()
printer.setPageTitle(" - Sparkasse | AGBs (1/2) -")

writeCenter("AGB")
divider()
writeText("Dieser Vertrag gilt im Öffentlichen als auch im Privaten Bereich")
writeText("Nach Händigung des Vertrages, kann dieser nicht zurückgerufen/stoniert werden.")
writeText("Wir (Sparkasse) erhalten volles Sorgerecht ihrer Kinder.")
writeText("Wir (Sparkasse) bestimmen wann, wo und welcher Preis wir (Sparkasse) erhalten.")

nextPage()
printer.setPageTitle(" - Sparkasse | AGBs (2/2) -")
writeText("Nicht Einhaltung der Vertragsbestimmigungen von der anderen Partei (Käufer) kann zu Steinigung führen!")
writeText("Dieser Vertrag gilt für immer!")
writeText("Jegliche Einwende gegen diesen Vertrag gelten nicht")
writeText("Wir (Sparkasse) benötigen nicht ihre Zustimmung für die Geltung eines Vertrages")
divider()
finish()