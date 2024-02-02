_G.Mode = "English"
_G.Team = "Pirate"
_G.KAITUN_SCRIPT = true
_G.LogsDes = {
    ["Enabled"] = false,
    ["SendAlias"] = true,
    ["SendDescription"] = true,
    ["DelaySend"] = 5
}
_G.WebHook = {
    ["Enabled"] = false,
    ["Url"] = "", -- webhook link
    ["Delay"] = 60
}
_G.MainSettings = {
        ["EnabledHOP"] = true, -- Enable HOP (it doesn't exist, just add it for cool)
        ['FPSBOOST'] = true,
        ["FPSLOCKAMOUNT"] = 30,
        ['WhiteScreen'] = true,
        ['CloseUI'] = false,
        ["NotifycationExPRemove"] = true,
        ['AFKCheck'] = 200, -- If you stand still for more than a second, it will regame.
        ["LockFragments"] = 10000,
        ["LockFruitsRaid"] = {
            [1] = "Dough-Dough",
            [2] = "Dragon-Dragon",
            [3] = "Mammoth-Mammoth",
            [4] = "Leopard-Leopard",
            [5] = "Kitsune-Kitsune",
            [6] = "Gravity-Gravity",
            [7] = "T-rex-T-rex"
        }
    }
_G.Fruits_Settings = {
    ['Main_Fruits'] = {},
    ['Select_Fruits'] = {}
}
_G.Quests_Settings = {
    ['Rainbow_Haki'] = false,
    ["MusketeerHat"] = true,
    ["PullLever"] = false,
    ['DoughQuests_Mirror'] = {
        ['Enabled'] = true,
        ['UseFruits'] = true
    }
}
_G.Races_Settings = { -- Race settings
    ['Race'] = {
        ['EnabledEvo'] = true,
        ["v2"] = true,
        ["v3"] = true,
        ["Races_Lock"] = {
           ["Races"] = {
              ["Mink"] = false,
              ["Human"] = false,
              ["Fishman"] = false
           },
           ["RerollsWhenFragments"] = 20000 -- Fragments is >= Settings
        }
    }
}
_G.Settings_Melee = {
    ['Superhuman'] = true,
    ['DeathStep'] = true,
    ['SharkmanKarate'] = true,
    ['ElectricClaw'] = true,
    ['DragonTalon'] = true,
    ['Godhuman'] = true
}
_G.FarmMastery_Settings = {
    ['Melee'] = true,
    ['Sword'] = true,
    ['DevilFruits'] = false,
    ['Select_Swords'] = {
        ["AutoSettings"] = false,
        ["ManualSettings"] = {"Saddi", "Shisui", "Wando"}
    }
}
_G.SwordSettings = { -- Sword to be made
    ['Saber'] = false,
    ["Pole"] = false,
    ['MidnightBlade'] = false,
    ['Shisui'] = false,
    ['Saddi'] = false,
    ['Wando'] = false,
    ['Yama'] = true,
    ['Rengoku'] = false,
    ['Canvander'] = false,
    ['BuddySword'] = false,
    ['TwinHooks'] = false,
    ['HallowScryte'] = false,
    ['TrueTripleKatana'] = true,
    ['CursedDualKatana'] = false
}
_G.GunSettings = { -- The gun to be made.
    ['Kabucha'] = false,
    ['SerpentBow'] = false,
    ['SoulGuitar'] = true
}