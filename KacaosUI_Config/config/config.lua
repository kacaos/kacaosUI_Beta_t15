local C = {}
-------------------------------------------------------------
-- Adjust your default config here, it will overwrite default
-------------------------------------------------------------

C.general = {
	blizzardreskin = false,							-- to set alpha go to tukui/core/api.lua and set balpha
	backdropcolor = {.06,.06,.06},					-- backdrop color of all panel
	bordercolor = {0,0,0},							-- border color of all panel
	tinydpsreskin = false,                          -- reskin tinydps
}

C.datatext = {
	fps_ms = 11,									-- show fps and ms on panel
	system = 0,										-- show memory on panel
	gold = 0,										-- show gold on panel
	guild = 0,										-- show number of guildmates whose are online on panel
	friends = 0,									-- show number of friedns whose are online on panel
	dur = 0,	                                    -- show durability of your items on panel 
	bags = 0,                                       -- show free space in bags
	wowtime = 10,                                   -- show time
	dps_text = 0,                               	-- show the dps on an panel
	hps_text = 0,                                  	-- show the hps on an panel
	power = 0,                                      -- show you spellpower/attackpower on an panel
	haste = 0,                                      -- show your haste on panel
	crit = 0,                                       -- show your crit chance on panel
	avd = 0,                                       	-- show your avoidance on panel
	armor = 0,                                      -- show your armor on panel
	currency = 0,                                  	-- show your tracked currency on panel
	hit = 0,                                       	-- show your hit chance on panel
	mastery = 0,                                    -- show your mastery on panel
	micromenu = 0,                                  -- show the micromenu on panel
	regen = 0,                                     	-- show your manareg
	talent = 0,                                     -- show talent
	calltoarms = 0,                                 -- show dungeon und call to arms
	
	battleground = false,                           -- enable 3 stats in battleground only that replace stat1,stat2,stat3.
	time24 = true,                                  -- show 24h time instead of am/pm
	localtime = false,                              -- show localtime instead of server time
	fontsize = 10,									-- font size of all datatexts
}

C.actionbar = {
	style = 2,										-- change between styl 1 and 2
	allbars = true,									-- get 1bottom bar with 14buttons and 3 sidebars								
	bar4 = true,									-- activate 2 bottombars and 3 sidebars
	buttonspacing = 3,								-- buttonspacing of actionbars
	petbuttonsize = 18,								-- buttonsize of petbar
	buttonsize = 27,
	sidebar1mouseover = true,						-- rightbar1 on mouseover
	sidebar2mouseover = true,						-- rightbar2 on mouseover
	sidebar3mouseover = true,						-- rightbar3 on mouseover
	b2bottom = true,								-- enable 3 bottomrows (only useable together with 2bottombars option)
	hpetbar = true,									-- enable vertical petbar
}

C.unitframes = {
	style = 2,										-- change unitframe style 1, 2 and 3
	showdb = false,									-- show debuffs on target (only layout 3)
	onlyselfdebuffs = false,						-- track only your debuffs on target
	hpshow = false,									-- show hp/mp on target (only at style 1, at heal its all time visible)
	hpshowp = false,									-- show hp/mp on player (only at style 1, at layout 2 its all time visible)
	charportrait = false,							-- show portrait on healthbar
	totshow = false,								-- show target of target
	petshow = false,								-- show pet
	cbbutton = false,								-- show castbar button/icon
	mouseoverhighlight = true,						-- mouseoverhiglight at raidframes layout2
	showsolo = true,								-- show player solo in raid
}

C.classbar = {
    warlock = true,
	deathknight = true,
	paladin = true,
	shaman = true,
	priest = true,
	druid = true,
	monk = true,
	combopoints = true,
	height = 8,
	width = 175,
}

C.chat = {
	chattab = false,									-- enable/disable chattab panel
	chatbackground = false,							-- enable/disable chatbackground
		chatbackgroundwidth = 300,					-- set chatbackground width
		chatbackgroundheight = 100,					-- set chatbackground height
	chattabshow = false,								-- show chattabs
	fadeout = false,									-- enable/disable chatbackground fadeout infight
	namealert = false,								-- Play sound when your name is called in chat
	names = { -- name alert in chat change to your own names (credit Hydra)
		"Jaspar",
		"Jasper"
	},
}

C.misc = {
	uibuttons = false,								-- enable 3 ui buttons in the top and the 2 over the minimap
	threatbar = false,								-- enable threatbar
	afkcam = false,									-- activate akf spin cam
	hyperlink = false,								-- show itemlinks in chat on mouseover
	raidbuffreminder = false,						-- raidbuffreminder at the top of the screen
	raidstyle = 1,									-- choose between style 1 and 2
	ilvlr = false,									-- show ilvl and durability in charakterframe
	infobottom = false,								-- show infopanel at the bottom of you screen
}

C.auras = {
	buffsfadeout = false,							-- fadeout playerbuffs infight
}

C.tooltip = {
	ilvl = false,									-- activate ilvl in tooltip
}

C.filger = {
	enable = false,									-- enable filger
	filgerconfig = false,							-- enable configmode
	iconsize = 45,									-- bla
	proccs = "RIGHT",								-- direction of proccs
	buffs = "RIGHT",								-- direction of buffs
	debuffs = "RIGHT",								-- direction of debuffs
	cd = "RIGHT",									-- direction of cds
	pet = "RIGHT",									-- direction of petbuffs
}

C.combattext = {
	enable = false,							-- Global enable combat text
	blizzheadnumbers = false,				-- Use blizzard damage/healing output(above mob/player head)
	damagestyle = false,					-- Change default damage/healing font above mobs/player heads(you need to restart WoW to see changes)
	damage = true,							-- Show outgoing damage in it's own frame
	healing = true,							-- Show outgoing healing in it's own frame
	showhots = false,						-- Show periodic healing effects in healing frame
	showoverhealing = false,				-- Show outgoing overhealing
	petdamage = true,						-- Show your pet damage
	dotdamage = true,						-- Show damage from your dots
	damagecolor = true,						-- Display damage numbers depending on school of magic
	critprefix = "*",						-- Symbol that will be added before crit
	critpostfix = "*",						-- Symbol that will be added after crit
	icons = false,							-- Show outgoing damage icons
	iconsize = 16,							-- Icon size of spells in outgoing damage frame, also has effect on dmg font size
	treshold = 1,							-- Minimum damage to show in damage frame
	healtreshold = 1,						-- Minimum healing to show in incoming/outgoing healing messages
	scrollable = false,						-- Allows you to scroll frame lines with mousewheel
	maxlines = 8,							-- Max lines to keep in scrollable mode(more lines = more memory)
	timevisible = 3,						-- Time(seconds) a single message will be visible
	stopvespam = false,						-- Automaticly turns off healing spam for priests in shadowform
	dkrunes = true,							-- Show deathknight rune recharge
	killingblow = false,					-- Tells you about your killingblows
	mergeaoespam = true,					-- Merges multiple aoe damage spam into single message
	mergeaoespamtime = 3,					-- Time in seconds aoe spell will be merged into single message(works only with ["damage"] = true)
	dispel = true,							-- Tells you about your dispels(works only with ["damage"] = true)
	interrupt = true,						-- Tells you about your interrupts(works only with ["damage"] = true)
	direction = "bottom",					-- Scrolling Direction("top"(goes down) or "bottom"(goes up))
}

C.media = {
	["font"] = [=[Interface\Addons\Tukui\medias\fonts\normal_font.ttf]=], 			-- general font of tukui
	["uffont"] = [[Interface\Addons\Tukui\medias\fonts\normal_font.ttf]], 			-- general font of unitframes
	["pixelfont"] = [[Interface\Addons\KacaosUI\media\font\HOOG0555.ttf]],			-- font of datatext uf etc.
	["help"] = [[Interface\Addons\KacaosUI\media\font\normal_font.ttf]],			-- font for helpframe
	["combattextfont"] = [[Interface\Addons\KacaosUI\media\font\HOOG0555.ttf]],		-- font for combattext /xct
	combattextfontsize = 12,														-- fontsize of combattext
	["combattextfontstyle"] = "MONOCHROMEOUTLINE",									-- outline of combattextfont
	["combattextfontshadow"] = false,												-- enable shadow of combattextfont
	normTex = [[Interface\Addons\kacaosUI\media\textures\normTex]],					-- texture for mana/health etc.
	kuihelp_pic = [[Interface\Addons\kacaosUI\media\textures\kuihelp_pic]],			-- texture for helpframe
	namealert = [[Interface\Addons\kacaosUI\media\sounds\namealert.mp3]],			-- sound for chatnamealert
	noinset = true,																	-- inset in icons / panels / true for 1px borders
	datatextcolor1 = {.6,.6,.6}														-- color of the datatext titles
}

-- do not change or delete this!!!
TukuiEditedDefaultConfig = C