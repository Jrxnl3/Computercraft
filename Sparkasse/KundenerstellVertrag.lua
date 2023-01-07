local printer = peripheral.wrap("top")
local speaker = peripheral.wrap("bottom")

local function newLine() 
    local x, y = printer.getCursorPos()
    printer.setCursorPos(1,y+1)
end
local function writeText(stringText)
    for c in stringText:gmatch"." do
        local i,y = printer.getCursorPos()

        if i > 24 then
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
local function nextPage()
    printer.endPage()
    printer.newPage()
end
local name
local iban
local alter
local password

local ersteller


shell.run("clear")
print("|================Kundenvertrag================|") 
print(" ")
print(" ")

print("Name des Kunden: ")
name = io.read()
print(" ")

print("IBAN des Kunden: ")
iban = io.read()
print(" ")

print("Alter des Kunden: ")
alter = io.read()
print("")

print("Password")
password = io.read()
print(" ")

print("Ersteller des Vertrages: ")
ersteller = io.read()
print("")

print(" ")
print(" ")
print("|=================================================|")


-- # PRINT OF VERTRAG#
-- Page 1 Kundendaten

printer.newPage()
printer.setPageTitle(" - Sparkasse | Kundenvertrag -")

writeCenter("Kundenname:")
writeText(name)

divider()

writeCenter("Kunden-IBAN:")
writeText(iban)

divider()

writeCenter("Kundenalter:")
writeText(alter)

divider()

writeCenter("Password:")
writeText(password)

divider()

writeCenter("ABGs zugestimmt")
writeText("Ja")
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