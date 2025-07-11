var plasma = getApiVersion(1);
/*General*/
panelbottom = new Panel
panelbottom.location = "bottom"
panelbottom.height = gridUnit * 2.48
panelbottom.hiding = "none"

/*spacer*/
panelbottom.addWidget("org.kde.plasma.weather")

//Add Widgets
panelbottom_add_widgets = panelbottom.addWidget("com.himdek.kde.plasma.runcommand")
panelbottom_add_widgets.currentConfigGroup = ["General"]
panelbottom_add_widgets.writeConfig("icon", "/usr/share/icons/Eleven/desktop/widgets_button.png")
panelbottom_add_widgets.writeConfig("command", "qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.toggleWidgetExplorer")

//spacer
panelbottom.addWidget("org.kde.plasma.panelspacer")


/*App Launcher*/
panelbottom_startmenu = panelbottom.addWidget("menu11")
panelbottom_startmenu.currentConfigGroup = ["General"]
panelbottom_startmenu.writeConfig("icon", "/usr/share/icons/Eleven/start11.png")
panelbottom_startmenu.writeConfig("reduceIconSizeFooter", "true")
panelbottom_startmenu.writeConfig("recentGridModel", "1")

//Find (for windows 10)
//panelbottom_changedesktop = panelbottom.addWidget("search11")
//panelbottom_changedesktop.currentConfigGroup = ["General"]
//panelbottom_changedesktop.writeConfig("icon", "/usr/share/icons/Eleven/desktop/desktops_button.png")

//Find Windows 11
panelbottom_find11 = panelbottom.addWidget("com.himdek.kde.plasma.runcommand")
panelbottom_find11.currentConfigGroup = ["General"]
panelbottom_find11.writeConfig("icon", "/usr/share/icons/Eleven/desktop/search_button.svg")
panelbottom_find11.writeConfig("command", "qdbus org.kde.krunner /App display")


//Show Desktop
panelbottom_changedesktop = panelbottom.addWidget("com.himdek.kde.plasma.runcommand")
panelbottom_changedesktop.currentConfigGroup = ["General"]
panelbottom_changedesktop.writeConfig("icon", "/usr/share/icons/Eleven/desktop/desktops_button.png")
panelbottom_changedesktop.writeConfig("command", "qdbus org.kde.kglobalaccel /component/kwin org.kde.kglobalaccel.Component.invokeShortcut ShowDesktopGrid")



/*Find-Widget*/
//panelbottom.addWidget("org.kde.milou")
/*Desktops button*/
//panelbottom_desktops = panelbottom.addWidget("com.github.doncsugar.presentwindows")
//panelbottom_desktops.currentConfigGroup = ["General"]
//panelbottom_desktops.writeConfig("icon", "presentwindows-48px")
panelbottom.addWidget("org.kde.plasma.icontasks")
panelbottom.addWidget("org.kde.plasma.panelspacer")

/*systemtray*/
var systraprev = panelbottom.addWidget("org.kde.plasma.systemtray")
//var SystrayContainmentId = systraprev.readConfig("SystrayContainmentId")
//const systray = desktopById(SystrayContainmentId)
//systray.currentConfigGroup = ["General"]
//let ListTrays = systray.readConfig("extraItems")
//let ListTrays2 = ListTrays.replace(",org.kde.plasma.notifications", "")
//systray.writeConfig("extraItems", ListTrays2)
//systray.writeConfig("iconSpacing", 1)
//systray.writeConfig("shownItems", "org.kde.plasma.mediacontroller,org.kde.plasma.volume,org.kde.plasma.networkmanagement,org.kde.plasma.weather,org.kde.plasma.battery")


/*Cambiando configuracion Dolphin*/
const IconsStatic_dolphin = ConfigFile('dolphinrc')
IconsStatic_dolphin.group = 'KFileDialog Settings'
IconsStatic_dolphin.writeEntry('Places Icons Static Size', 16)
const PlacesPanel = ConfigFile('dolphinrc')
PlacesPanel.group = 'PlacesPanel'
PlacesPanel.writeEntry('IconSize', 16)
/******************************/

/*Clock*/
panelbottom.addWidget("org.kde.plasma.marginsseparator")
panelbottom_clock = panelbottom.addWidget("org.kde.plasma.digitalclock")
panelbottom_clock.currentConfigGroup = ["Appearance"]
panelbottom_clock.writeConfig("fontSize", "24")
panelbottom_clock.writeConfig("autoFontAndSize", "false")
panelbottom_clock.writeConfig("fontFamily", "Sans Serif")
panelbottom.addWidget("org.kde.plasma.marginsseparator")

/*Notification*/
//panelbottom.addWidget("org.kde.plasma.notifications")

//Copilot
panelbottom_copilot = panelbottom.addWidget("com.himdek.kde.plasma.runcommand")
panelbottom_copilot.currentConfigGroup = ["General"]
panelbottom_copilot.writeConfig("icon", "/usr/share/icons/Eleven/copilot/256_button.png")
panelbottom_copilot.writeConfig("command", "/opt/microsoft/msedge/microsoft-edge --profile-directory=Default --app=https://copilot.microsoft.com/")


//MinimizeAll
panelbottom_minimize = panelbottom.addWidget("org.kde.plasma.win7showdesktop")
panelbottom_minimize.currentConfigGroup = ["General"]
panelbottom_minimize.writeConfig("click_action", "showdesktop")
panelbottom_minimize.writeConfig("size", "8")
panelbottom_minimize.writeConfig("click_action", "minimizeall")
panelbottom_minimize.writeConfig("edgeColor", "#669e9e9e")
panelbottom_minimize.writeConfig("hoveredColor", "#cbcbcb")


/* accent color config*/
ColorAccetFile = ConfigFile("kdeglobals")
ColorAccetFile.group = "General"
ColorAccetFile.writeEntry("accentColorFromWallpaper", "false")
ColorAccetFile.deleteEntry("AccentColor")
ColorAccetFile.deleteEntry("LastUsedCustomAccentColor")
/*Buttons of aurorae*/
Buttons = ConfigFile("kwinrc")
Buttons.group = "org.kde.kdecoration2"
Buttons.writeEntry("ButtonsOnRight", "IAX")
Buttons.writeEntry("ButtonsOnLeft", "")
plasma.loadSerializedLayout(layout);
