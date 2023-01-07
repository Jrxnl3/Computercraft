local printer = peripheral.wrap("top")
local speaker = peripheral.wrap("bottom")

local vertrag
local name
local iban
local kosten
local ersteller
-- # PRINTER CUSTOM MADE API Jinx_Dev #

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

        printer.write(c)
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

-- # END OF CUSTOM PRINTER API#


-- # USER INPUT #

shell.run("clear")
print("|================Vertragsersteller================|") 
print(" ")
print("Vertragsname: ")
vertrag = io.read()
print(" ")
print("Name des Käufers: ")
name = io.read()
print(" ")
print("IBAN des Käufers: ")
iban = io.read()
print(" ")
print("Kosten des Vertrages: ")
kosten = io.read()
print(" ")
print("Ersteller des Vertrages: ")
ersteller = io.read()
print(" ")
print("")
print("|=================================================|")


-- # END USER INPUT #


-- # PRINT OF VERTRAG#

printer.newPage()
printer.setPageTitle(" - Sparkasse | "..vertrag.." -")

writeCenter("Name:")
writeText(name)

divider()

writeCenter("IBAN:")
writeText(iban)

divider()

writeCenter("Versicherung:")
writeText(vertrag)

divider()

writeCenter("Kosten:")
writeText(kosten)

divider()

writeCenter("Ersteller:")
writeText(ersteller)

spacer()
spacer()
spacer()
spacer()
spacer()

writeText("Datum: "..os.date("%A %d %B %Y"))


finish()
