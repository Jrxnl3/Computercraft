local auswahl

while true do
    shell.run("clear")
    print("|=================================================|")
    print(" ")
    print("Was wollen Sie tuen? ")
    print("[1]. Vertragerstellen")
    print("[2]. Kundenvertrag erstellen")
    print("[3]. AGBs drucken")
    print(" ")
    print("|=================================================|")
    print(" ")
    print("Ihre Auswahl: ")
    auswahl = io.read()

    if auswahl == "1" then
        shell.run("VertragsErsteller")
    end 
    if auswahl == "2" then
        shell.run("KundenerstellVertrag")
    end 
    if auswahl == "3" then
        shell.run("AGBPrinter")
    end 
end

