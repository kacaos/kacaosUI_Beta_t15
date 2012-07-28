local T, C, L = unpack(Tukui)
T.kacaosrelease = GetAddOnMetadata("KacaosUI", "Version")

local wmes = CreateFrame("Frame")
wmes:RegisterEvent("PLAYER_ENTERING_WORLD")
wmes:SetScript("OnEvent", function(self, event)
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")

	print(L.wmes_1)
	print(L.wmes_2)
end )

if TukuiConfigUILocalization then
	if T.client == "deDE" then
		TukuiConfigUILocalization.unitframesmouseoverhighlight = "Aktiviere aufblinken der Raidframes per Mouseover in Heallayout"
		TukuiConfigUILocalization.unitframesstyle = "Unitframestyle waehle zwischen 1, 2 oder 3"
		TukuiConfigUILocalization.unitframestotshow = "Aktiviere Ziel des Ziels"
		TukuiConfigUILocalization.unitframespetshow = "Aktiviere Begleiteranzeige"
		TukuiConfigUILocalization.unitframeshpshow = "Zeige HP/MP auf dem Ziel (nur style1 u 3 layout)"
		TukuiConfigUILocalization.unitframeshpshowp = "Zeige HP/MP auf dem Spieler (nur style1 u. 3 layout)"
		TukuiConfigUILocalization.unitframesshowdb = "Zeige Debuffs auf dem Ziel (nur in Layout3)"
		TukuiConfigUILocalization.unitframescbbutton = "Zeige Zauberleisten Button/Icon (nur in Layout3)"
		TukuiConfigUILocalization.actionbarstyle = "Aktionsleistenstyle 1 oder 2"
		TukuiConfigUILocalization.actionbarallbars = "Aktiviere alle Bars (nur in Aktionsleistenlayout1)"
		TukuiConfigUILocalization.actionbarbar4 = "Aktiviere 2 Bars unten (nur in Aktionsleistenlayout1)"
		TukuiConfigUILocalization.actionbarb2bottom = "Aktiviere 3 Bars unten (funktioniert nur mit Aktiviere 2 Bars unten und Aktionsleistenlayout1)"
		TukuiConfigUILocalization.actionbarsidebar1mouseover = "Bar 5 auf mouseover"
		TukuiConfigUILocalization.actionbarsidebar2mouseover = "Bar 3 auf mouseover (nur in Aktionsleistenlayout1)"
		TukuiConfigUILocalization.actionbarsidebar3mouseover = "Bar 2 auf mouesover (nur in Aktionsleistenlayout1)"
		TukuiConfigUILocalization.actionbarhpetbar = "Aktiviere Horizontale Petbar"
		TukuiConfigUILocalization.chatchattab = "Aktiviere das Panel über dem Chat"
		TukuiConfigUILocalization.chatchatbackground = "Aktiviere den Chatbackground"
		TukuiConfigUILocalization.chatchattabshow = "Zeige Chattabs"
		TukuiConfigUILocalization.chatfadeout = "Aktiviere Fadeout des Chatbackgroundes infight"
		TukuiConfigUILocalization.chatchatbackgroundwidth = "Setze Breite des Chatbackgroundes"
		TukuiConfigUILocalization.chatchatbackgroundheight = "Setze Höhe des Chatbackgroundes"
		TukuiConfigUILocalization.chatnamealert = "Aktiviere Sound bei einem Namen im Chat"
		TukuiConfigUILocalization.misc = "Verschiedenes"
		TukuiConfigUILocalization.miscilvlr = "Zeige Ilvl und Haltbarkeit im Charakterfenster"
		TukuiConfigUILocalization.miscraidstyle = "Wähle zwischen dps und heal"
		TukuiConfigUILocalization.miscafkcam = "Aktiviere Afk Spin Cam"
		TukuiConfigUILocalization.miscuibuttons = "Aktiviere die UIbuttons neben der Minimap"
		TukuiConfigUILocalization.miscthreatbar = "Aktiviere Bedrohungsanzeige"
		TukuiConfigUILocalization.miscraidbuffreminder = "Aktiviere den Raidbuffreminder (anzeige wichtiger spells im raid)"
		TukuiConfigUILocalization.mischyperlink = "Itemlinks im Chat per Mouseover"
		TukuiConfigUILocalization.miscinfobottom = "Aktiviere das Panel am unteren Bildschirmrand"
		TukuiConfigUILocalization.aurasbuffsfadeout = "Blende die Spielerbuffs im Kampf aus"
		TukuiConfigUILocalization.tooltipilvl = "Aktiviere ilvl im Tooltip"
		TukuiConfigUILocalization.filger = "Filger"
		TukuiConfigUILocalization.filgerenable = "Aktiviere Filger"
		TukuiConfigUILocalization.filgerfilgerconfig = "Aktiviere Configmodus"
		TukuiConfigUILocalization.filgericonsize = "Setze Größe der Icons"
		TukuiConfigUILocalization.filgerproccs = "Ausrichtung der Proccs"
		TukuiConfigUILocalization.filgerbuffs = "Ausrichtung der Buffs"
		TukuiConfigUILocalization.filgerdebuffs = "Ausrichtung der Debuffs"
		TukuiConfigUILocalization.filgercd = "Ausrichtung der CDs"
		TukuiConfigUILocalization.filgerpet = "Ausrichtung der Petbuffs"
		TukuiConfigUILocalization.combattext = "xCT"
		TukuiConfigUILocalization.combattextenable = "Kampftext aktivieren"
		TukuiConfigUILocalization.combattextblizzheadnumbers = "Blizzard Schaden-/Heilausgabe benutzen (ueber Spieler/Kreaturen Kopf)"
		TukuiConfigUILocalization.combattextdamagestyle = "Standard Schaden/Heilung Schriftart ueber Kreaturen/Spieler Köpfen aendern (nach restart)"
		TukuiConfigUILocalization.combattextdamage = "Zeige ausgehenden Schaden in einem eigenen Fenster"
		TukuiConfigUILocalization.combattexthealing = "Zeige ausgehende Heilung in einem eigenen Fenster"
		TukuiConfigUILocalization.combattexthots = "Zeige peroidische Heilungseffekte im Heilungsfenster"
		TukuiConfigUILocalization.combattextoverhealing = "Zeige ausgehende Überheilung an"
		TukuiConfigUILocalization.combattextpetdamage = "Zeige Begleiterschaden"
		TukuiConfigUILocalization.combattextdotdamage = "Zeige Schaden von Schaden über Zeit"
		TukuiConfigUILocalization.combattextdamagecolor = "Zeige Schadensnummern in Abhängigkeit von der Art des Zaubers"
		TukuiConfigUILocalization.combattextcritprefix = "Symbol vor einem kritischen Treffer"
		TukuiConfigUILocalization.combattextcritpostfix = "Symbol hinter einem kritischen Treffer"
		TukuiConfigUILocalization.combattexticons = "Zeige Symbole fuer ausgehenden Schaden"
		TukuiConfigUILocalization.combattexticonsize = "Symbolgröße der Zauber im Fenster fuer ausgehenden Schaden. Nimmt auch Einfluss auf die Schriftgröße"
		TukuiConfigUILocalization.combattexttreshold = "Ab welcher Größe soll der Schaden angezeigt werden"
		TukuiConfigUILocalization.combattexthealtreshold = "Ab welche Größe soll ein-/ausgehende Heilung angezeigt werden"
		TukuiConfigUILocalization.combattextscrollable = "Erlaubt es dir mit dem Mausrad durch die letzten Zeilen zu scrollen"
		TukuiConfigUILocalization.combattextmaxlines = "Maximale Zeilen, die behalten werden sollen im Scrollmodus (mehr Zeilen = mehr Speicherverbrauch)"
		TukuiConfigUILocalization.combattexttimevisible = "Zeit(Sekunden) wielange eine einzelne Nachricht angezeigt wird"
		TukuiConfigUILocalization.combattextstopvespam = "Heilung von Priestern in Schattenform wird automatisch ausgeschaltet"
		TukuiConfigUILocalization.combattextdkrunes = "Zeige Runenaufladung vom Todesritter"
		TukuiConfigUILocalization.combattextkillingblow = "Teilt dir mit ob du den Todesstoss bei einer Kreatur/einem Spieler hattest"
		TukuiConfigUILocalization.combattextmergeaoespam = "Vereint mehrfachen Flächenschaden in eine einzige Nachricht"
		TukuiConfigUILocalization.combattextmergeaoespamtime = "Zeit in Sekunden in der ein Flächenzauber in eine Nachricht vereint wird"
		TukuiConfigUILocalization.combattextdispel = "Informiert dich über deine Bannungen"
		TukuiConfigUILocalization.combattextinterrupt = "Informiert dich über deine Unterbrechungen"
		TukuiConfigUILocalization.combattextdirection = "Scrolling Direction('top'(goes down) or 'bottom'(goes up))"
		TukuiConfigUILocalization.classbar = "Klassenleisten"
		TukuiConfigUILocalization.classbarwarlock = "Aktiviere Hexenmeister Klassenleiste"
		TukuiConfigUILocalization.classbardeathknight = "Aktiviere Todesritter Klassenleiste"
		TukuiConfigUILocalization.classbarpaladin = "Aktiviere Paladin Klasseinleiste"
		TukuiConfigUILocalization.classbarshaman = "Aktiviere Shamanen Klassenleiste"
		TukuiConfigUILocalization.classbarpriest = "Aktiviere Priester Klassenleiste"
		TukuiConfigUILocalization.classbardruid = "Aktiviere Druiden Klassenleiste"
		TukuiConfigUILocalization.classbarmonk = "Aktiviere Mönch Klassenleiste"
		TukuiConfigUILocalization.classbarcombopoints = "Aktiviere Klassenleiste für Schurken und für Druiden(in Katzengestalt)"
		TukuiConfigUILocalization.classbarheight = "Setze Höhe der Klassenleiste"
		TukuiConfigUILocalization.classbarwidth = "Setze Breite der Klassenleiste"
	end
end	


if T.client == "deDE" then
	
	L.wmes_1 = "Hey, |cff1E90FF"..T.myname.."!|r Willkommen zu |cff1E90FFKacaosUI|r v"..T.kacaosrelease..""
	L.wmes_2 = "Die akktuellste Version findest du unter: |cff00FF33http://www.tukui.org/addons/index.php?act=view&id=49|r"
	
	L.mover_castbarplayer = "Spieler Zauberleiste"
	L.mover_castbartarget = "Ziel Zauberleiste"
	
	L.mover_tbMover = "Klassenleiste"

	L.mover_debuffs = "PlayerDebuffs"
	
	L.mover_bar1 = "Bar1"
	L.mover_bar2 = "Bar2"
	L.mover_bar3 = "Bar3"
	L.mover_bar4 = "Bar4"
	L.mover_bar5 = "Bar5"
	L.mover_petbar = "Pet"
	
	L.threat = "Bedrohung"
	
	-- helpframe
	L.duffeduihelp_header = "|cff1E90FFKacaosUI|r - Hilfe"
	L.duffeduihelp_button1 = "|cff1E90FFEinheitenfenster|r"
	L.duffeduihelp_button2 = "|cff1E90FFAktionsleisten|r"
	L.duffeduihelp_button3 = "|cff1E90FFVerschiedenes|r"
	L.duffeduihelp_button4 = "|cff1E90FFKlassenleisten|r"
	L.duffeduihelp_button5 = "|cff1E90FFLayouts|r"
	L.duffeduihelp_button6 = "|cff1E90FFBefehle|r"
	L.duffeduihelp_button7 = "|cff1E90FFChat|r"
	L.duffeduihelp_button8 = "|cff1E90FFFilger / xCT|r"
	L.duffeduihelp_button9 = "|cff1E90FFCredits|r"

	L.duffeduihelp_content0_title = "|cff1E90FFAllgemein|r"
	L.duffeduihelp_content0_line1 = "Willkommen zum Hilfepanel von KacaosUI!\n\nDas Panel soll dir dabei helfen die wichtigsten Einstellungen und Kommandos f\195\188r KacaosUI zu finden. :)"
	L.duffeduihelp_content0_line2 = "W\195\164hle eine der Kategorien aus"
	L.duffeduihelp_content0_line3 = "Viel Spa\195\159 !"
	L.duffeduihelp_content0_line4 = "greetz J\195\162spar - Frostwolf EU"

	L.duffeduihelp_content9_title = "|cff1E90FFCredits|r"
	L.duffeduihelp_content9_line1 = ""
	L.duffeduihelp_content9_line2 = "Hiermit bedanke ich mich bei allen die mir geholfen haben dieses UI zu erstellen!"
	L.duffeduihelp_content9_line3 = ""
	L.duffeduihelp_content9_line4 = "Tukz, Pat, Swordyy, Sinaris, Merith, Elv, Smelly, Saft, Ex, Sniffles, Gszus, JerichoHM, Nisha und den allen Editoren die mir geholfen haben."

	L.duffeduihelp_content4_title = "|cff1E90FFKlassenleisten|r"
	L.duffeduihelp_content4_line1 = "Um die jeweiligen Klassenleisten nutzen zu können musst du in der ingameconfig zu dem punkt Klassenleisten gehen. Dort findest du die Optionen einzelne Klassenleisten ein- oder auszuschalten.\n\nEbenso findest du dort die Option die Klassenleisten zu skalieren. Es gibt dort ein Eingabefeld für die Höhe und eins für die Breite."
	L.duffeduihelp_content4_line2 = ""
	L.duffeduihelp_content4_line3 = "Verschieben kannst du die Leisten mit dem moveui Befehl :)"
	L.duffeduihelp_content4_line4 = ""

	L.duffeduihelp_content8_title = "|cff1E90FFFilger / xCT|r"
	L.duffeduihelp_content8_line1 = "Hier geht es um die zwei eingeschlossenen AddOns Filger und xCT.\n\nFilger ist ein Buff/Debuff/CD tracker welchen ihr nach belieben einstellen k\195\182nnt. Diese Optionen findet ihr in der ingameconfig unter *Filger*.\nAu\195\159erdem k\195\182nnt ihr mit dem moveui Befehl die einzelnen Filgerbuffs/debuffs etc. verschieben.\n\nxCT ist ein ScrollingCombatText welchen ihr auch nach belieben in der ingameconfig unter *xCT* einstellen k\195\182nnt.\n\nMit dem Befehl /xct unluck könnt ihr den configmodus anschalten.\n\nMit /xct lock verschließt ihr die fenster wieder.\n\nEin weiterer Befehl ist /xct test damit führt ihr einen testmodus aus."
	L.duffeduihelp_content8_line2 = ""
	L.duffeduihelp_content8_line3 = ""
	L.duffeduihelp_content8_line4 = ""

	L.duffeduihelp_content3_title = "|cff1E90FFVerschiedenes|r"
	L.duffeduihelp_content3_line1 = "Dort hast du einige Optionen welche ich dir hier kurz aufliste:\n\nAktiviere den Raidbuffreminder (Ein Panel welches am oberen Rand des Bildschirm ist. Um zu sehen welche Buffs man besitzt und welche noch fehlen).\n\nDie Bedrohungsleiste ein- und auszuschalten\n\nEine AFK-Spin-Cam zu aktivieren (Drehen des Bildschirms wenn du als AFK geflaged wirst)\n\nAktivieren der Buttons neben der Minimap\n\nDas Itemlevel im Charakterfenster sowie die Haltbarkeit anzuzeigen\n\nItemlinks im Chat per Mouseover anzeigen zu lassen\n\nDas Panel am unteren Rand aktivieren (siehe Layouts)\n\nF\195\188r die Raidlayouts hast du hier die M\195\182glichkeitn zwischen zwei layouts zu w\195\164hlen. Entweder du nutzt ein minimalistisches Grid, oder du nutzt ein Grid was extra f\195\188r Heiler angepasst ist."
	L.duffeduihelp_content3_line3 = ""
	L.duffeduihelp_content3_line4 = ""

	L.duffeduihelp_content2_title = "|cff1E90FFAktionsleisten|r"
	L.duffeduihelp_content2_line1 = "Du hast zwei unterschiedliche Aktionleistenlayouts zwischen den du w\195\164hlen kannst."
	L.duffeduihelp_content2_line2 = "Du kannst einmal das Layout1 benutzen, in welchem du alle deine Bars unten in der mitte und rechts am Rand hast. Oder du nutzt das Layout2 in welchem du eine Splitbar in der Mitte des Bildschirms hast."
	L.duffeduihelp_content2_line3 = "Bei dem Layout1 hast du die wahl:\n\n3x12 Bottombars + 2x12 Rightbars\n2x12 Bottombars + 3x12 Rightbars\n1x14 Bottombar + 3x12 Rightbars\n\nIn dem Layout2 hast du in der Mitte:\n\n2x6 + Splitbar Links u. Rechts 2x6 Bars + 2x12 Rightbars."
	L.duffeduihelp_content2_line4 = "In dem 2. Layout kann man die Petbar horzitonal und vertikal einstellen. Ausserdem sind die Aktionsleisten mit dem Befehl moveui bewegbar :)"

	L.duffeduihelp_content5_title = "|cff1E90FFLayouts|r"
	L.duffeduihelp_content5_line1 = "Hier kannst du zwischen Zwei Panellayouts w\195\164hlen.\n\nDu kannst in der Ingame Config unter - Verschiedenes die Option - Aktiviere das Panel am unteren Bildschirmrand - ausw\195\164hlen."
	L.duffeduihelp_content5_line2 = "Hast du das getan, dann hast du unten ein Panel in welches du mit Hilfe der Option von den Infotexten in der Config, dir die f\195\188r dich wichtigsten Datatexte einstellen kannst.\n\nDu hast insgesamt 6 Datatexte zur Auswahl, da es nur diese 6 eingestellten Pl\195\164tze gibt."
	L.duffeduihelp_content5_line3 = "Nun Liste ich die einzelnen Positionen der Ankerpunkte f\195\188r die Datatexte auf:\n\nLinks unten der 1. = 7\nLinks unten der 2. = 8\nLinks unten der 3. = 9\n\nRechts unten der 1. = 6\nRechts unten der 2. = 5\nRechts unten der 3. = 4"
	L.duffeduihelp_content5_line4 = ""

	L.duffeduihelp_content7_title = "|cff1E90FFChat|r"
	L.duffeduihelp_content7_line1 = "Bei dem Chat hast du die M\195\182glichkeiten:\n\n|cff1E90FF1.|r Ein Hintergrund Panel anzeigen zu lassen\n\n|cff1E90FF2.|r Das Panel f\195\188r die Chattabs anzeigen zu lassen\n\n|cff1E90FF3.|r Die Chattabs anzeigen zu lassen\n\n|cff1E90FF4.|r Den Chat im Kampf ausblenden zu lassen\n\n|cff1E90FF5.|r Einen Ton abspielen zu lassen wenn dein Name im Chat geschrieben wird. Den namen kannst du unter wow/interface/addons/kacaosUI_config/config.lua ausw\195\164hlen\n\n|cff1E90FF6.|r Die H\195\182he und Breite des Chats einstellen"
	L.duffeduihelp_content7_line2 = "All diese Optionen findest du in der Ingame Config unter - Geselligkeit."
	L.duffeduihelp_content7_line3 = ""
	L.duffeduihelp_content7_line4 = ""

	L.duffeduihelp_content1_title = "|cff1E90FFEinheitenfenster|r"
	L.duffeduihelp_content1_line1 = "Als erstes, du hast drei unterschiedliche Layouts f\195\188r die Einheitenfenster."
	L.duffeduihelp_content1_line2 = "Du kannst diese in der Config unter Einheitenfenster - Unitframestyle wechseln. Es gibt die Styles:\n1, 2 und 3."
	L.duffeduihelp_content1_line3 = "Unter den Optionen Einheitenfenster findest du viele verschiedene M\195\182glichkeiten deine Unitframes anzupassen. Hinter einigen Optionen steht in Klammern in welchem Layout man diese Option benutzen kann."
	L.duffeduihelp_content1_line4 = "Die Unitframes sind alle mit dem befehl moveui zu bewegen, sowie deren Klassenleisten und Zauberleisten."

	L.duffeduihelp_content6_title = "|cff1E90FFBefehle|r"
	L.duffeduihelp_content6_line1 = "|cff1E90FF/kuihelp|r => \195\150ffnet dieses Panel\n|cff1E90FF/resetui|r => Setzt die Frameposition des gesamten UIs zur\195\188ck\n|cff1E90FF/install|r => Neuinstallation der gesamten UI"
	L.duffeduihelp_content6_line2 = "|cff1E90FF/moveui|r => Aktiviert die Bewegungsanker der UI-Elemente\n|cff1E90FF/kb|r => Keybindings setzen per mouseover\n|cff1E90FF/rl|r => L\195\164dt das UI neu"
	L.duffeduihelp_content6_line3 = "|cff1E90FF/tc|r => \195\150ffnet die ingame-Config"
	L.duffeduihelp_content6_line4 = "|cff1E90FF/am|r => \195\150ffnet den Addonmanager\n\n|cff1E90FF/xct|r => Zeige xct Befehle im Chat.\n|cff1E90FF/xct unlock|r => Schalte den xct Configmodus an. Zum verschieben der Frames.\n|cff1E90FF/xct lock|r => Verschließe die Frames nach dem verschieben.\n|cff1E90FF/xct test|r => Aktiviere xct Testmodus."
	
	-- Combat text
	L.COMBATTEXTKILLINGBLOW = "Todesstoss"
	L.COMBATTEXTALREADYUNLOCKED = "Kampftext bereits freigegeben."
	L.COMBATTEXTALREADYLOCKED = "Kampftext bereits gespert."
	L.COMBATTEXTTESTDISABLED = "Kampftext Testmodus deaktiviert."
	L.COMBATTEXTTESTENABLED = "Kampftext Testmodus aktiviert."
	L.COMBATTEXTTESTUSEUNLOCK = "Gib '/xct unlock' ein um die Kampftext Fenster freizugeben um sie verschieben und verändern zu können."
	L.COMBATTEXTTESTUSELOCK = "Gib '/xct lock' ein um die Kampftext Fenster zu sperren."
	L.COMBATTEXTTESTUSETEST = "Gib '/xct test' ein um den Kampftext Testmodus zu aktivieren."
	L.COMBATTEXTPOPUP = "Um die Kampftext Fensterpositionen zu sichern muss das Interface neu geladen werden."
	L.COMBATTEXTUNSAVED = "Kampftext Fensterpositionen nicht gespeichert, vergiss nicht das Interface neu zu laden."
	L.COMBATTEXTUNLOCKED = "Kampftext freigegeben."

end