Config = {}

-- Please enable when you are having issues, and send these in support logs.
Config.Debug = false

-- What bank account should money go into on successful purchase (Renewed Banking)
Config.DefaultAccount = "government"

-- Should we give and take vehicle keys? (Configure at the bottom)
Config.GiveVehicleKeys = true
Config.RemoveVehicleKeys = true

-- Where should we log vehicle sales, test drives, and failures.
Config.GlobalWebhook =
    "https://discord.com/api/webhooks/1353521605065572372/cgHpPrroJlWRMkwVFTsbmmyPv6A54V90zTBi5oZZx2ipuB0ZXcPIypDh6koBVPlq_Uu_"

-- What about blips?
Config.GlobalBlipToggle = true
-- Should we use "Dealership" or the name of the dealership?
Config.BlipUseDealershipLabel = false
-- What blip icon?
Config.GlobalBlipIcon = 67

-- During Test drive, should we give an item: (test_drive_paperwork)
Config.RentalItem = true

Config.AllowCustomPlate = true

Config.HighValueThreshold = 1000000
Config.MaxHighValuePerModel = 5
Config.SellVehicle = true
Config.DefaultResalePercentage = 35


-- What plates can players not set as there vehicle number plate, "partial" means it checks everything around the text, "exact" - matches everything
Config.BlacklistPlates = {{
    word = "POLICE",
    match = "partial"
}, {
    word = "ADMIN",
    match = "partial"
}, {
    word = "MOD",
    match = "partial"
}, {
    word = "GOV",
    match = "partial"
}, {
    word = "STAFF",
    match = "partial"
}, {
    word = "FIRE",
    match = "partial"
}, {
    word = "AMBU",
    match = "partial"
}, {
    word = "NHS",
    match = "partial"
}, {
    word = "fuck",
    match = "partial"
}, {
    word = "Aurora",
    match = "partial"
}, {
    word = "shit",
    match = "partial"
}, {
    word = "AUPD",
    match = "partial"
}, {
    word = "AUHS",
    match = "partial"
}, {
    word = "AUFS",
    match = "partial"
}, {
    word = "AUH",
    match = "partial"
}, {
    word = "BIT",
    match = "partial"
}, {
    word = "B1T",
    match = "partial"
}, {
    word = "SH1T",
    match = "partial"
}, {
    word = "SHIT",
    match = "partial"
}, {
    word = "W4NK",
    match = "partial"
}, {
    word = "BENTEST",
    match = "partial"
}, {
    word = "PDMTEST",
    match = "partial"
}, {
    word = "FOXTEST",
    match = "partial"
}, {
    word = "POST",
    match = "partial"
}, {
    word = "TAXI",
    match = "partial"
}, {
    word = "GRU6",
    match = "partial"
}, {
    word = "CJOB",
    match = "partial"
}, {
    word = "BJOB",
    match = "partial"
}, {
    word = "CUSTM",
    match = "partial"
}}

-- The following Section is where you set your vehicles to display, should you wish to.
Config.VehicleDisplay = {

}

-- Configure your dealerships
Config.Dealerships = {
     ["roxwood1"] = {
        label = "RoxWood 1", -- The label..
        coords = vector3(-363.55, 7414.67, 6.41), -- where the ped spawns..
        heading = 203.05, -- where the ped faces..
        pedModel = "csb_car3guy1", -- what ped model...
        bankAccount = "government", -- The bank we pay these sales into..
        preview = vector4(-354.17, 7415.72, 6.34, 134.23), -- Where we preview the car.
        testDrive = true, -- Can we test drive here?
        testDriveSpawn = vector4(-336.37, 7434.9, 5.96, 269.11), -- Where does it spawn, this is also the location of purchases!
        testDriveLength = 120, -- How many seconds should a test drive last?
        testDrivePlate = 'ROX1TEST', -- What about the test drive plate?
        license = "driver", -- this must match metadata.licences["driver"]
        licenseItem = "driver_license", -- physical item name in ox_inventory
        CheckLicense = "meta", -- options: "meta", "item", "both"
        webhook = false, -- Does the dealership owner want a webhook for sales? post it here!
        blip = true, -- is this blip enabled?
        blipicon = '', -- If not global icon - what icon shall we choose?
        resalePercentage = 20, -- Sell back for 70%
        allowSellBack = true,

        -- Add your vehicles, model (must match), label (What it displays as), Price (How much!), Category - what we list it under.
        vehicles = {{
            model = "alpha",
            label = "Albany Alpha",
            price = 1830000,
            category = "SportsCars"
        }, {
            model = "banshee",
            label = "Bravado Banshee",
            price = 1980000,
            category = "SportsCars"
        }, {
            model = "bestiagts",
            label = "Grotti Bestia GTS",
            price = 1850000,
            category = "SportsCars"
        }, {
            model = "buffalo4",
            label = "Bravado Buffalo STX",
            price = 2340000,
            category = "MuscleCars"
        }, {
            model = "novak",
            label = "Lampadati Novak",
            price = 2190000,
            category = "SUVs"
        }, {
            model = "vigero2",
            label = "Declasse Vigero ZX",
            price = 1879000,
            category = "MuscleCars"
        }, {
            model = "vigero3",
            label = "Declasse Vigero ZX Convertible",
            price = 2310000,
            category = "MuscleCars"
        }, {
            model = "coquette4",
            label = "Invertero Coquette D10",
            price = 2123000,
            category = "SportsCars"
        }, {
            model = "ardent",
            label = "Ocelot Ardent",
            price = 1900000,
            category = "SportsClassics"
        }, {
            model = "btype",
            label = "Albany Roosevelt",
            price = 2230000,
            category = "SportsClassics"
		
        },{
            model = "btype2",
            label = "Albany Franken-Stange",
            price = 2260000,
            category = "SportsClassics"
        }, {
            model = "adder",
            label = "Truffade Adder",
            price = 2030000,
            category = "Supercars"
        }, {
            model = "banshee2",
            label = "Bravado Banshee 900R",
            price = 1830000,
            category = "Supercars"
        }, {
            model = "autarch",
            label = "  Overflod Autarch",
            price = 1836000,
            category = "Supercars"
        }, {
            model = "turismor",
            label = "Grotti Turismo R",
            price = 1470000,
            category = "Supercars"
        }, {
            model = "turismo3",
            label = "Grotti Turismo Omaggio",
            price = 2050000,
            category = "Supercars"
        }, {
            model = "tezeract",
            label = "Pegassi Tezeract",
            price = 1800000,
            category = "Supercars"
        }, {
            model = "zentorno",
            label = "Pegassi Zentorno",
            price = 1650000,
            category = "Supercars"
        }, {
            model = "zeno",
            label = " Overflod Zeno",
            price = 2100000,
            category = "Supercars"
        }, {
            model = "tropos",
            label = "Lampadati Tropos Rallye",
            price = 1900000,
            category = "SportsCars"
        },  {
            model = "tenf",
            label = "Obey 10F",
            price = 2200000,
            category = "SportsCars"
        },{
            model = "tenf2",
            label = "Obey 10F Widebody",
            price = 2300000,
            category = "SportsCars"
        }, {
            model = "sultan",
            label = "Karin Sultan",
            price = 2065000,
            category = "SportsCars"
        }, {
            model = "sultanrs",
            label = "Karin Sultan RS",
            price = 1940000,
            category = "MuscleCars"
        }, {
            model = "sultan3",
            label = "Karin Sultan RS Classic",
            price = 2000000,
            category = "MuscleCars"
        }, {
            model = "sultan2",
            label = "Karin Sultan Classic",
            price = 2085000,
            category = "MuscleCars"
        }, {
            model = "Schlagen",
            label = "Benefactor Schlagen GT",
            price = 1780000,
            category = "SportsCars"
        }, {
            model = "elegy",
            label = "Annis Elegy Retro Custom",
            price = 2000000,
            category = "SportsCars"
        }, {
            model = "comet3",
            label = "Pfister Comet Retro Custom",
            price = 2400000,
            category = "SportsCars"
        }, {
            model = "specter2",
            label = "Dewbauchee Specter Custom",
            price = 1840000,
            category = "SportsCars"
        },  {
            model = "seven70",
            label = "Dewbauchee Seven-70",
            price = 1770000,
            category = "SportsCars",
			maxOwned = 7
        }, {
            model = "schafter4",
            label = "Benefactor Schafter LWB",
            price = 121800,
            category = "Sedans"
        }, {
            model = "schafter3",
            label = "Benefactor Schafter V12",
            price = 1700000,
            category = "Sedans"
        }, {
            model = "Peyote3",
            label = "Vapid Peyote Custom",
            price = 1600000,
            category = "SportsClassics"
        }, {
            model = "tornado5",
            label = "Declasse Tornado Custom",
            price = 2300000,
            category = "SportsClassics"
        }, {
            model = "weevil2",
            label = "BF Weevil Custom",
            price = 2050000,
            category = "MuscleCars"
        }, {
            model = "gauntlet5",
            label = "Bravado Gauntlet Classic Custom",
            price = 1450000,
            category = "MuscleCars"
        }, {
            model = "manana2",
            label = "Albany Manana Custom",
            price = 2110000,
            category = "MuscleCars"
        }, {
            model = "virgo2",
            label = "Dundreary Virgo Classic Custom",
            price = 1810000,
            category = "MuscleCars"
        }, {
            model = "slamvan3",
            label = "Vapid Slamvan Custom",
            price = 1460000,
            category = "MuscleCars"
        }, {
            model = "faction3",
            label = "Willard Faction Custom Donk",
            price = 1300000,
            category = "MuscleCars"
        }, {
            model = "sabregt2",
            label = "Declasse Sabre Turbo Custom",
            price = 1650000,
            category = "MuscleCars"
        }, {
            model = "chino2",
            label = "Vapid Chino Custom",
            price = 1550000,
            category = "MuscleCars"
        }, {
            model = "faction2",
            label = "Willard Faction Custom",
            price = 1400000,
            category = "MuscleCars"
        }, {
            model = "thrax",
            label = "Truffade Thrax",
            price = 2100000,
            category = "Supercars"
        }, 	{
            model = "Deveste",
            label = "Principe Deveste Eight",
            price = 1750000,
            category = "Supercars"
        }, {
            model = "visione",
            label = "Grotti Visione",
            price = 1850000,
            category = "Supercars"
        }, {
            model = "GP1",
            label = "Progen GP1",
            price = 1875000,
            category = "Supercars"
        }, {
            model = "nero",
            label = "Truffade Nero",
            price = 2090000,
            category = "Supercars"
        }, {
            model = "nero2",
            label = "Truffade Nero Custom",
            price = 1940000,
            category = "Supercars"
        }, {
            model = "italigtb2",
            label = "Progen Itali GTB Custom",
            price = 1710000,
            category = "Supercars"
        }, {
            model = "prototipo",
            label = "Grotti X80 Proto",
            price = 1850000,
            category = "Supercars"
        }, {
            model = "pfister811",
            label = "Pfister 811",
            price = 1350000,
            category = "Supercars"
        }, {
            model = "t20",
            label = "Progen T20",
            price = 1900000,
            category = "Supercars"
        }, {
            model = "deity",
            label = "Enus Deity",
            price = 1800000,
            category = "Sedans"
        }, {
            model = "Glendale2",
            label = "Benefactor Glendale Custom",
            price = 104600,
            category = "Sedans"
        }, {
            model = "Stafford",
            label = "Enus Stafford",
            price = 1810000,
            category = "Sedans"
        }, {
            model = "primo2",
            label = "Albany Primo Custom",
            price = 1820000,
            category = "Sedans"
        }, {
            model = "jubilee",
            label = "Enus Jubilee",
            price = 2100000,
            category = "SUVs"
        }, {
            model = "Baller7",
            label = "Gallivanter Baller ST",
            price = 1995000,
            category = "SUVs"
        },  {
            model = "Baller8",
            label = "Gallivanter Baller ST-D",
            price = 2030000,
            category = "SUVs"
        },  {
            model = "cavalcade3",
            label = "Albany Cavalcade XL",
            price = 1950000,
            category = "SUVs"
        },{
            model = "dubsta3",
            label = "Benefactor Dubsta 6x6",
            price = 3380000,
            category = "OffroadVehicles"
        }, {
            model = "Voodoo",
            label = "Declasse Voodoo Custom",
            price = 1650000,
            category = "MuscleCars"
        }, {
            model = "ZType",
            label = "Truffade Z-Type",
            price = 24000000,
            category = "SportsClassics"
        }, {
            model = "FQ2",
            label = "Fathom FQ 2",
            price = 1400000,
            category = "SUVs"
        }, {
            model = "Futo2",
            label = "Karin Futo GTX",
            price = 1833000,
            category = "CompactCars"
        }, {
            model = "Ruston",
            label = "Hijak Ruston",
            price = 1580000,
            category = "SportsCars"
        },  {
            model = "jester3",
            label = "Dinka Jester Classic",
            price = 2080000,
            category = "SportsCars"
        }, 
			{
            model = "veto",
            label = "Dinka Veto Classic",
            price = 1000000,
            category = "Track"
        }, {
            model = "veto2",
            label = "Dinka Veto Modern",
            price = 1000000,
            category = "Track"
        }, {
            model = "Swinger",
            label = "Ocelot Swinger",
            price = 2000000,
            category = "SportsClassics"
        }, {
            model = "rapidgt3",
            label = "Dewbauchee Rapid GT Classic",
            price = 2000000,
            category = "SportsClassics"
        }, {
            model = "Cheetah2",
            label = "Grotti Cheetah Classic",
            price = 2100000,
            category = "SportsClassics"
        }, {
            model = "infernus2",
            label = "Pegassi Infernus Classic",
            price = 2100000,
            category = "SportsClassics"
        }, {
            model = "turismo2",
            label = "Grotti Turismo Classic",
            price = 2100000,
            category = "SportsClassics"
        }, {
            model = "tornado6",
            label = "Declasse Tornado Rat Rod",
            price = 1400000,
            category = "HotRods"
        }, {
            model = "btype3",
            label = "Albany Roosevelt Valor",
            price = 2300000,
            category = "HotRods"
        }, {
            model = "mamba",
            label = "Declasse Mamba",
            price = 2200000,
            category = "SportsClassics"
        }, {
            model = "feltzer3",
            label = "Benefactor Stirling GT",
            price = 2200000,
            category = "SportsClassics"
        }, {
            model = "Hermes",
            label = "Albany Hermes",
            price = 1780000,
            category = "HotRods"
        }, {
            model = "Hustler",
            label = "Vapid Hustler",
            price = 1960000,
            category = "HotRods"
        }, {
            model = "Hotknife",
            label = "Vapid Hotknife",
            price = 1785000,
            category = "HotRods"
        }, {
            model = "buffalo3",
            label = "Bravado Sprunk Buffalo",
            price = 1925000,
            category = "Track"
        }, {
            model = "dominator2",
            label = "Vapid Piswasser Dominator",
            price = 1840000,
            category = "Track"
        }, {
            model = "gauntlet2",
            label = "Declasse Redwood Gauntlet",
            price = 1625000,
            category = "Track"
        },  {
            model = "moonbeam2",
            label = "Declasse Moonbeam Custom",
            price = 1725000,
            category = "MuscleCars"
        },
			{
            model = "stalion2",
            label = "Declasse Burger Shot Stallion",
            price = 1725000,
            category = "Track"
        }, {
            model = "hotring",
            label = "Declasse Hotring Sabre - Min 2 per purchase",
            price = 2520000,
            category = "Track"
        }, {
            model = "everon2",
            label = "Karin Hotring Everon - Min 2 per purchase",
            price = 1600000,
            category = "Track"
        }, {
            model = "gauntlet6",
            label = "Bravado Hotring Hellfire - Min 2 per purchase",
            price = 1900000,
            category = "Track"
        }, {
            model = "Peyote2",
            label = "Vapid Peyote Gasser",
            price = 194400,
            category = "MuscleCars",
            maxOwned = 10
        },}
    },
     ["roxwood2"] = {
        label = "Benefactor Roxwood", -- The label..
        coords = vector3(-361.17, 7468.81, 6.41), -- where the ped spawns..
        heading = 346.64, -- where the ped faces..
        pedModel = "csb_car3guy1", -- what ped model...
        bankAccount = "government", -- The bank we pay these sales into..
        preview = vector4(-361.95, 7460.85, 6.34, 91.88), -- Where we preview the car.
        testDrive = true, -- Can we test drive here?
        testDriveSpawn = vector4(-372.14, 7498.07, 5.95, 270.36), -- Where does it spawn, this is also the location of purchases!
        testDriveLength = 120, -- How many seconds should a test drive last?
        testDrivePlate = 'ROX1TEST', -- What about the test drive plate?
        license = "driver", -- this must match metadata.licences["driver"]
        licenseItem = "driver_license", -- physical item name in ox_inventory
        CheckLicense = "meta", -- options: "meta", "item", "both"
        webhook = false, -- Does the dealership owner want a webhook for sales? post it here!
        blip = true, -- is this blip enabled?
        blipicon = '', -- If not global icon - what icon shall we choose?
        resalePercentage = 20, -- Sell back for 70%
        allowSellBack = true,

        -- Add your vehicles, model (must match), label (What it displays as), Price (How much!), Category - what we list it under.
        vehicles = {{
            model = "alpha",
            label = "Albany Alpha",
            price = 1830000,
            category = "SportsCars"
        }, {
            model = "banshee",
            label = "Bravado Banshee",
            price = 1980000,
            category = "SportsCars"
        }}
    },
    ["pdm"] = {
        label = "Premium Deluxe Motorsport",
        coords = vector3(-54.15, -1097.37, 26.42),
        heading = 7.3,
        pedModel = "a_m_m_business_01",
        bankAccount = "government",
        preview = vector4(-50.41, -1096.42, 26.25, 14.17),
        testDrive = true,
        testDriveSpawn = vector4(-53.57, -1110.42, 26.26, 76.54),
        testDriveLength = 180,
        testDrivePlate = 'PDMTEST',
        license = "driver", -- this must match metadata.licences["driver"]
        licenseItem = "driver_license", -- physical item name in ox_inventory
        CheckLicense = "meta", -- options: "meta", "item", "both"
        resalePercentage = 35, -- Sell back for 70%
        allowSellBack = true,
        webhook = false,
        blip = true,
        blipicon = '',
        vehicles = {{
            model = "cogcabrio",
            label = "Cognoscenti Cabrio",
            price = 155400,
            category = "Coupes"
        }, {
            model = "exemplar",
            label = "Dewbauchee Exemplar",
            price = 201000,
            category = "SportsClassics"
        }, {
            model = "f620",
            label = "Ocelot F620",
            price = 181000	,
            category = "Coupes"
        }, {
            model = "fr36",
            label = "Fathom FR36",
            price = 161600	,
            category = "Coupes"
        }, {
            model = "dubsta",
            label = "Benefactor Dubsta",
            price = 155700,
            category = "SUVs"
        },{
            model = "toros",
            label = "Pegassi Toros",
            price = 186500,
            category = "SUVs"
        }, {
            model = "dubsta2",
            label = "Benefactor Dubsta Custom",
            price = 170300,
            category = "SUVs"
        }, -- Additional Vehicles
        {
            model = "akuma",
            label = "Dinka Akuma",
            price = 121000,
            category = "Motorcycles"
        }, {
            model = "hakuchou2",
            label = "Shitzu Hakuchou Drag",
            price = 154000,
            category = "Motorcycles"
        }, {
            model = "hakuchou",
            label = "Shitzu Hakuchou",
            price = 131200,
            category = "Motorcycles"
        }, {
            model = "diablous",
            label = "Principe Diabolus",
            price = 156400,
            category = "Motorcycles"
        }, {
            model = "diablous2",
            label = "Principe Diabolus Custom",
            price = 165200,
            category = "Motorcycles"
        }, {
            model = "fcr",
            label = "Pegassi FCR 1000",
            price = 131600,
            category = "Motorcycles"
        }, {
            model = "fcr2",
            label = "Pegassi FCR 1000 Custom",
            price = 154800,
            category = "Motorcycles"
        },{
            model = "blade",
            label = "Vapid Blade",
            price = 108400,
            category = "MuscleCars"
        }, {
            model = "buccaneer",
            label = " Albany Bucaneer",
            price = 106000,
            category = "MuscleCars"
        }, {
            model = "buccaneer2",
            label = "Albany Bucaneer Custom",
            price = 112000,
            category = "MuscleCars"
        }, {
            model = "bfinjection",
            label = "BF Injection",
            price = 85000,
            category = "OffroadVehicles"
        }, {
            model = "shinobi",
            label = "Shinobi",
            price = 156600,
            category = "Motorcycles"
        }, {
            model = "bifta",
            label = "BF Bifta",
            price = 119000,
            category = "OffroadVehicles"
        }, {
            model = "brawler",
            label = "Coil Brawler",
            price = 127000,
            category = "OffroadVehicles"
        }, {
            model = "baller",
            label = "Gallivanter Baller First Gen",
            price = 158030,
            category = "SUVs"
        }, {
            model = "baller2",
            label = "Gallivanter Baller Second Gen",
            price = 158024,
            category = "SUVs"
        }, {
            model = "baller3",
            label = "Gallivanter Baller LE",
            price = 158210,
            category = "SUVs"
        }, {
            model = "asea",
            label = "Declasse Asea",
            price = 121000,
            category = "Sedans"
        }, {
            model = "impaler6",
            label = "Declasse Impaler LX",
            price = 156800,
            category = "Sedans"
        }, {
            model = "asterope2",
            label = "Karin Asterope GZ",
            price = 168600,
            category = "Sedans"
        }, {
            model = "asterope",
            label = "Karin Asterope",
            price = 125200,
            category = "Sedans"
        }, {
            model = "cog55",
            label = "Enus Cognoscenti 55",
            price = 145000,
            category = "Sedans"
        }, {
            model = "bf400",
            label = "Nagasaki BF400",
            price = 157000,
            category = "Scooter"
        }, {
            model = "corsita",
            label = "Lampadati Corsita",
            price = 180000,
            category = "SportsCars"
        }, {
            model = "sm722",
            label = "Benefactor SM722",
            price = 194000,
            category = "SportsCars"
        }, {
            model = "Comet7",
            label = "Comet S2 Cabrio",
            price = 193600,
            category = "SportsCars"
        }, {
            model = "CALICO",
            label = "Karin Calico GTF",
            price = 197000,
            category = "SportsCars"
        }, {
            model = "euros",
            label = "Annis Euros",
            price = 185000,
            category = "SportsCars"
        }, {
            model = "jester4",
            label = "Dinka Jester RR",
            price = 177000,
            category = "SportsCars"
        }, {
            model = "remus",
            label = "Annis Remus",
            price = 177800,
            category = "SportsCars"
        }, {
            model = "rt3000",
            label = "Dinka RT3000",
            price = 181400,
            category = "SportsCars"
        }, {
            model = "ZR350",
            label = "Annis ZR350",
            price = 190600,
            category = "SportsCars"
        }, {
            model = "COMET6",
            label = "Pfister Comet S2",
            price = 184000,
            category = "SportsCars"
        }, {
            model = "Vectre",
            label = "Emperor Vectre",
            price = 183800,
            category = "SportsCars"
        }, {
            model = "Growler",
            label = "Pfister Growler",
            price = 200000,
            category = "SportsCars"
        }, {
            model = "cypher",
            label = " Ubermacht Cypher",
            price = 149000,
            category = "SportsCars"
        }, {
            model = "italirsx",
            label = "Grotti Itali RSX",
            price = 204000,
            category = "SportsCars"
        }, {
            model = "penumbra2",
            label = "Maibatsu Penumbra FF",
            price = 165000,
            category = "SportsCars"
        }, {
            model = "komoda",
            label = "Lampadati Komoda",
            price = 181800,
            category = "Sedans"
        }, {
            model = "sugoi",
            label = "Dinka Sugoi",
            price = 190600,
            category = "Sedans"
        }, {
            model = "vstr",
            label = "Albany VSTR",
            price = 148500,
            category = "Sedans"
        }, {
            model = "paragon",
            label = "Enus Paragon R",
            price = 182600,
            category = "SportsCars"
        }, {
            model = "drafter",
            label = "Obey 8F Drafter",
            price = 154000,
            category = "SportsCars"
        }, {
            model = "issi7",
            label = "Weeny Issi Sport",
            price = 173000,
            category = "SportsCars"
        }, {
            model = "neo",
            label = "Vysser Neo",
            price = 167000,
            category = "SportsCars"
        }, {
            model = "locust",
            label = "Ocelot Locust",
            price = 167000,
            category = "SportsCars"
        }, {
            model = "Jugular",
            label = "Ocelot Jugular",
            price = 196400,
            category = "Sedans"
        },  {
            model = "rhinehart",
            label = "Ubermacht Rhinehart",
            price = 161000,
            category = "Sedans"
        }, {
            model = "italigto",
            label = "Grotti Itali GTO",
            price = 179000,
            category = "SportsCars"
        }, {
            model = "GB200",
            label = "Vapid GB200",
            price = 183500,
            category = "SportsCars"
        }, {
            model = "flashgt",
            label = "Vapid Flash GT",
            price = 178000,
            category = "SportsCars"
        }, {
            model = "Raiden",
            label = "Coil Raiden",
            price = 185000,
            category = "Sedans"
        }, {
            model = "comet4",
            label = "Pfister Comet Safari",
            price = 180000,
            category = "OffroadVehicles"
        }, {
            model = "Sentinel3",
            label = " Ubermacht Sentinel Classic",
            price = 157000,
            category = "SportsCars"
        }, {
            model = "streiter",
            label = "Benefactor Streiter ",
            price = 192400,
            category = "SUVs"
        }, {
            model = "Revolter",
            label = "Ubermacht Revolter",
            price = 177200,
            category = "Sedans"
        }, {
            model = "neon",
            label = "Pfister Neon",
            price = 210000,
            category = "SportsCars"
        }, {
            model = "comet5",
            label = "Pfister Comet SR",
            price = 184000,
            category = "SportsCars"
        }, {
            model = "specter",
            label = "Dewbauchee Specter",
            price = 155300,
            category = "SportsCars"
        }, {
            model = "raptor",
            label = "BF Raptor ",
            price = 155300,
            category = "Motorcycles"
        }, {
            model = "omnis",
            label = "Obey Omnis",
            price = 129000,
            category = "SportsCars"
        }, {
            model = "tampa2",
            label = "Declasse Drift Tampa",
            price = 141860,
            category = "SportsCars"
        }, {
            model = "lynx",
            label = "Ocelot Lynx",
            price = 164000,
            category = "SportsCars"
        }, {
            model = "verlierer2",
            label = "Bravado Verlierer",
            price = 181000,
            category = "SportsCars"
        }, {
            model = "kuruma",
            label = "Karin Kuruma",
            price = 200600,
            category = "SportsCars"
        }, {
            model = "massacro2",
            label = "Dewbauchee Massacro (Racecar)",
            price = 162600,
            category = "SportsCars"
        }, {
            model = "jester2",
            label = "Dinka Jester(Racecar)",
            price = 165100,
            category = "SportsCars"
        }, {
            model = "sentinel4",
            label = "Ubermacht Sentinel Classic Widebody",
            price = 205000,
            category = "SportsClassics"
        }, {
            model = "Nebula",
            label = "Vulcar Nebula Turbo",
            price = 151000,
            category = "SportsClassics"
        }, {
            model = "zion3",
            label = " Ubermacht Zion Classic",
            price = 159000,
            category = "SportsClassics"
        }, {
            model = "Dynasty",
            label = "Weeny Dynasty",
            price = 199000,
            category = "SportsClassics"
        }, {
            model = "fagaloa",
            label = "Vulcar Fagaloa",
            price = 173000,
            category = "SportsClassics"
        }, {
            model = "Michelli",
            label = "Lampadati Michelli GT",
            price = 163000,
            category = "SportsClassics"
        }, {
            model = "Cheburek",
            label = "RUNE Cheburek",
            price = 149000,
            category = "SportsClassics"
        }, {
            model = "Viseris",
            label = "Lampadati Viseris",
            price = 180000,
            category = "SportsClassics"
        }, {
            model = "GT500",
            label = "Grotti GT500 ",
            price = 173000,
            category = "SportsClassics"
        }, {
            model = "z190",
            label = "Karin 190z",
            price = 176600,
            category = "SportsClassics"
        }, {
            model = "Retinue",
            label = "Vapid Retinue Mk I",
            price = 106000,
            category = "MuscleCars"
        }, {
            model = "Torero",
            label = "Pegassi Torero XO",
            price = 1835000,
            category = "SportsClassics"
        }, {
            model = "casco",
            label = "Lampadati Casco",
            price = 139000,
            category = "SportsClassics"
        }, {
            model = "furoregt",
            label = "Lampadati Furore GT",
            price = 125000,
            category = "SportsClassics"
        }, {
            model = "coquette2",
            label = "Invetero Coquette Classic",
            price = 148000,
            category = "SportsClassics"
        }, {
            model = "brioso3",
            label = "Grotti Brioso 300 Widebody",
            price = 7200,
            category = "CompactCars"
        }, {
            model = "brioso2",
            label = "Grotti Brioso 300",
            price = 7200,
            category = "CompactCars"
        }, {
            model = "weevil",
            label = "BF Weevil",
            price = 12500,
            category = "CompactCars"
        }, {
            model = "Club",
            label = "BF Club",
            price = 16700,
            category = "CompactCars"
        }, {
            model = "Kanjo",
            label = "Dinka Blista Kanjo",
            price = 1670,
            category = "CompactCars"
        }, {
            model = "issi3",
            label = "Weeny Issi Classic",
            price = 12900,
            category = "CompactCars"
        }, {
            model = "kanjosj",
            label = "Dinka Kanjo SJ",
            price = 133000,
            category = "Coupes"
        }, {
            model = "postlude",
            label = "Dinka Postlude",
            price = 139400,
            category = "Coupes"
        }, {
            model = "previon",
            label = "Karin Previon",
            price = 160000,
            category = "Coupes"
        }, {
            model = "windsor2",
            label = "Enus Windsor Drop",
            price = 193000,
            category = "Sedans"
        }, {
            model = "windsor",
            label = "Enus Windsor",
            price = 153400,
            category = "Coupes"
        }, {
            model = "greenwood",
            label = "Bravado Greenwood",
            price = 137000,
            category = "MuscleCars"
        }, {
            model = "ruiner4",
            label = "Imponte Ruiner ZZ-8",
            price = 87000,
            category = "MuscleCars"
        }, {
            model = "dominator8",
            label = "Vapid Dominator GTT",
            price = 113000,
            category = "MuscleCars"
        }, {
            model = "dominator7",
            label = "Vapid Dominator ASP",
            price = 162400,
            category = "MuscleCars"
        },{
            model = "Retinue2",
            label = "Vapid Retinue Mk II",
            price = 112500,
            category = "MuscleCars"
        }, {
            model = "Yosemite2",
            label = "Declasse Drift Yosemite",
            price = 52000,
            category = "MuscleCars"
        }, {
            model = "Gauntlet3",
            label = "Bravado Gauntlet Classic",
            price = 112000,
            category = "MuscleCars"
        }, {
            model = "Gauntlet4",
            label = "Bravado Gauntlet Hellfire",
            price = 135000,
            category = "MuscleCars"
        }, {
            model = "Tulip",
            label = "Declasse Tulip",
            price = 93800,
            category = "MuscleCars"
        }, {
            model = "Deviant",
            label = "Schyster Deviant",
            price = 157400,
            category = "MuscleCars"
        }, {
            model = "Vamos",
            label = "Declasse Vamos",
            price = 84200,
            category = "MuscleCars"
        }, {
            model = "Ellie",
            label = "Vapid Ellie",
            price = 168000,
            category = "MuscleCars"
        }, {
            model = "dominator3",
            label = "Vapid Dominator GTX",
            price = 163400,
            category = "MuscleCars"
        }, {
            model = "Yosemite",
            label = "Declasse Yosemite",
            price = 33000,
            category = "MuscleCars"
        }, {
            model = "Savestra",
            label = "Annis Savestra",
            price = 158800,
            category = "MuscleCars"
        }, {
            model = "tampa",
            label = "Declasse Tampa",
            price = 155200,
            category = "MuscleCars"
        },  {
            model = "faction",
            label = "Willard Faction",
            price = 103400,
            category = "MuscleCars"
        }, {
            model = "moonbeam",
            label = "Declasse Moonbeam",
            price = 110000,
            category = "Vans"
        },  {
            model = "vivanite",
            label = "Karin Vivanite",
            price = 170600,
            category = "Vans"
        },{
            model = "voodoo2",
            label = "Declasse Voodoo",
            price = 58000,
            category = "MuscleCars"
        }, {
            model = "coquette3",
            label = "Invetero Coquette BlackFin",
            price = 103000,
            category = "MuscleCars"
        }, {
            model = "virgo",
            label = "Albany Virgo",
            price = 87000,
            category = "MuscleCars"
        }, {
            model = "slamvan",
            label = "Vapid Slamvan",
            price = 115000,
            category = "MuscleCars"
        }, {
            model = "lm87",
            label = "Benefactor LM87",
            price = 1956000,
            category = "Supercars"
        }, {
            model = "champion",
            label = "Dewbauchee Champion",
            price = 1730000,
            category = "Supercars"
        }, {
            model = "ignus",
            label = "Pegassi Ignus",
            price = 1800000,
            category = "Supercars"
        }, {
            model = "tigon",
            label = "Lampadati Tigon",
            price = 1750000,
            category = "Supercars"
        }, {
            model = "Furia",
            label = "Grotti Furia",
            price = 2000000,
            category = "Supercars"
        }, {
            model = "imorgon",
            label = "Overflod Imorgon",
            price = 1735000,
            category = "Supercars"
        }, {
            model = "S80",
            label = "Annis S80RR",
            price = 1900000,
            category = "Supercars"
        }, {
            model = "emerus",
            label = "Progen Emerus",
            price = 1850000,
            category = "Supercars"
        }, {
            model = "Krieger",
            label = "Benefactor Krieger",
            price = 1850000,
            category = "Supercars"
        }, {
            model = "Zorrusso",
            label = "Pegassi Zorrusso",
            price = 1700000,
            category = "Supercars"
        }, {
            model = "taipan",
            label = "Cheval Taipan",
            price = 1700000,
            category = "Supercars"
        }, {
            model = "entity2",
            label = "Overflod Entity XXR",
            price = 1678000,
            category = "Supercars"
        },  {
            model = "entity3",
            label = "Överflöd Entity MT",
            price = 2000000,
            category = "Supercars"
        }, {
            model = "Tyrant",
            label = "Overflod Tyrant",
            price = 2000000,
            category = "Supercars"
        }, {
            model = "Pariah",
            label = "Ocelot Pariah",
            price = 1700000,
            category = "Supercars"
        }, {
            model = "sc1",
            label = "Ubermacht SC1",
            price = 1790000,
            category = "Supercars"
        }, {
            model = "cyclone",
            label = "Coil Cyclone",
            price = 1600000,
            category = "Supercars"
        }, {
            model = "vagner",
            label = "Dewbauchee Vagner",
            price = 1850000,
            category = "Supercars"
        }, {
            model = "xa21",
            label = "Ocelot XA-21",
            price = 1780000,
            category = "Supercars"
        }, {
            model = "Penetrator",
            label = "Ocelot Penetrator",
            price = 1850000,
            category = "Supercars"
        }, {
            model = "Tempesta",
            label = "Pegassi Tempesta",
            price = 1990000,
            category = "Supercars"
        }, {
            model = "italigtb",
            label = "Progen Itali GTB",
            price = 1860000,
            category = "Supercars"
        }, {
            model = "le7b",
            label = "Annis RE-7B",
            price = 1900000,
            category = "Supercars"
        }, {
            model = "sheava",
            label = "Emperor ETR1",
            price = 1650000,
            category = "Supercars"
        }, {
            model = "tyrus",
            label = "Progen Tyrus",
            price = 1750000,
            category = "Supercars"
        }, {
            model = "reaper",
            label = "Pegassi Reaper",
            price = 1850000,
            category = "Supercars"
        }, {
            model = "fmj",
            label = "Vapid FMJ",
            price = 1645000,
            category = "Supercars"
        }, {
            model = "osiris",
            label = "Pegassi Osiris",
            price = 950000,
            category = "Supercars"
        }, {
            model = "omnisegt",
            label = "Obey Omnis e-GT",
            price = 193000,
            category = "Sedans"
        }, {
            model = "cinquemila",
            label = "Lampadati Cinquemila",
            price = 149000,
            category = "Sedans"
        }, {
            model = "tailgater2",
            label = "Obey Tailgater S",
            price = 192200,
            category = "Sedans"
        }, {
            model = "warrener2",
            label = "Vulcar Warrener HKR",
            price = 91200,
            category = "Sedans"
        }, {
            model = "cognoscenti",
            label = "Enus Cognoscenti",
            price = 160400,
            category = "Sedans"
        },{
            model = "mesa3",
            label = "Canis Mesa (off-road)",
            price = 159800,
            category = "OffroadVehicles"
        },{
            model = "draugur",
            label = "Declasse Draugur",
            price = 130600,
            category = "OffroadVehicles"
        },{
            model = "monstrociti",
            label = "Maibatsu MonstroCiti",
            price = 172600,
            category = "OffroadVehicles"
        },{
            model = "ratel",
            label = "Vapid Ratel",
            price = 150200,
            category = "OffroadVehicles"
        },{
            model = "boor",
            label = "Karin Boor",
            price = 136000,
            category = "OffroadVehicles"
        }, {
            model = "patriot3",
            label = "Mammoth Patriot Mil-Spec",
            price = 188000,
            category = "OffroadVehicles"
        }, {
            model = "Winky",
            label = "Vapid Winky",
            price = 112500,
            category = "OffroadVehicles"
        }, {
            model = "Yosemite3",
            label = "Declasse Yosemite Rancher",
            price = 173080,
            category = "OffroadVehicles"
        }, {
            model = "everon",
            label = "Karin Everon",
            price = 185200,
            category = "OffroadVehicles"
        }, {
            model = "Vagrant",
            label = "Maxwell Vagrant",
            price = 215000,
            category = "OffroadVehicles"
        }, {
            model = "outlaw",
            label = "Nagasaki Outlaw",
            price = 151000,
            category = "OffroadVehicles"
        }, {
            model = "caracara2",
            label = "Vapid Caracara 4X4",
            price = 188000,
            category = "OffroadVehicles"
        }, {
            model = "kamacho",
            label = "Canis Kamacho",
            price = 175800,
            category = "OffroadVehicles"
        }, {
            model = "trophytruck2",
            label = "Vapid Desert Raid",
            price = 88000,
            category = "OffroadVehicles"
        }, {
            model = "trophytruck",
            label = "Vapid Trophy Truck",
            price = 88000,
            category = "OffroadVehicles"
        }, {
            model = "guardian",
            label = "Vapid Guardian",
            price = 224300,
            category = "OffroadVehicles"
        }, {
            model = "astron",
            label = "Pfister Astron",
            price = 188000,
            category = "SUVs"
        }, {
            model = "granger2",
            label = "Declasse Granger 3600LX",
            price = 179100,
            category = "SUVs"
        }, {
            model = "IWAGEN",
            label = "Obey I-Wagen",
            price = 179400,
            category = "SUVs"
        }, {
            model = "squaddie",
            label = "Mammoth Squaddie",
            price = 156200,
            category = "SUVs"
        }, {
            model = "slamtruck",
            label = "Vapid Slamtruck",
            price = 107100,
            category = "SUVs"
        }, {
            model = "landstalker2",
            label = "Dundreary Landstalker XL",
            price = 187500,
            category = "SUVs"
        }, {
            model = "seminole2",
            label = "Canis Seminole Frontier",
            price = 175500,
            category = "SUVs"
        }, {
            model = "Rebla",
            label = " Ubermacht Rebla GTS",
            price = 200000,
            category = "SUVs"
        }, {
            model = "Hellion",
            label = "Annis Hellion",
            price = 155800,
            category = "OffroadVehicles"
        }, {
            model = "dune",
            label = "BF Dune Buggy",
            price = 144000,
            category = "OffroadVehicles"
        }, {
            model = "Bodhi",
            label = "Canis Bodhi",
            price = 141400,
            category = "OffroadVehicles"
        }, {
            model = "Patriot2",
            label = "Mammoth Patriot Stretch",
            price = 163600,
            category = "SUVs"
        }, {
            model = "Freecrawler",
            label = "Canis Freecrawler",
            price = 170400,
            category = "OffroadVehicles"
        }, {
            model = "Riata",
            label = "Vapid Riata",
            price = 180000,
            category = "OffroadVehicles"
        }, {
            model = "contender",
            label = "Vapid Contender",
            price = 146000,
            category = "OffroadVehicles"
        }, {
            model = "xls",
            label = "Benefactor XLS",
            price = 177900,
            category = "SUVs"
        },  {
            model = "aleutian",
            label = "Vapid Aleutian",
            price = 176800,
            category = "SUVs"
        }, {
            model = "dorado",
            label = "Bravado Dorado",
            price = 149000,
            category = "SUVs"
        }, {
            model = "terminus",
            label = "Canis Terminus",
            price = 163500,
            category = "SUVs"
        }, {
            model = "issi8",
            label = "Weeny Issi Rally",
            price = 202000,
            category = "SUVs"
        },{
            model = "baller4",
            label = "Gallivanter Baller LE LWB",
            price = 157970,
            category = "SUVs"
        }, {
            model = "rumpo3",
            label = "Bravado Rumpo Custom",
            price = 183000,
            category = "Vans"
        }, {
            model = "pigalle",
            label = "Lampadati Pigalle",
            price = 123000,
            category = "SportsClassics"
        }, {
            model = "rhapsody",
            label = "Declasse Rhapsody",
            price = 13800,
            category = "CompactCars"
        }, {
            model = "warrener",
            label = "Vulcar Warrener",
            price = 87000,
            category = "Sedans"
        }, {
            model = "glendale",
            label = "Benefactor Glendale",
            price = 80400,
            category = "Sedans"
        }, {
            model = "panto",
            label = "Benefactor Panto",
            price = 12900,
            category = "CompactCars"
        }, {
            model = "thrust",
            label = "Dinka Thrust",
            price = 149000,
            category = "Motorcycles"
        }, {
            model = "massacro",
            label = "Dewbauchee Massacro",
            price = 161880,
            category = "SportsCars"
        }, {
            model = "huntley",
            label = "Enus Huntley S",
            price = 161900,
            category = "SUVs"
        }, {
            model = "jester",
            label = "Dinka Jester",
            price = 163400,
            category = "SportsCars"
        }, {
            model = "kalahari",
            label = "Canis Kalahari",
            price = 135000,
            category = "OffroadVehicles"
        }, {
            model = "Paradise",
            label = "Bravado Paradise",
            price = 151000,
            category = "Vans"
        }, {
            model = "ninef",
            label = "Obey 9F",
            price = 187000,
            category = "SportsCars"
        }, {
            model = "ninef2",
            label = "Obey 9F Cabrio",
            price = 184000,
            category = "SportsCars"
        }, {
            model = "blista2",
            label = "Blista Compact ",
            price = 14300,
            category = "CompactCars"
        }, {
            model = "buffalo",
            label = "Bravado Buffalo",
            price = 176124,
            category = "SportsCars"
        }, {
            model = "buffalo2",
            label = "Bravado Buffalo S",
            price = 175800,
            category = "SportsCars"
        }, {
            model = "carbonizzare",
            label = "Grotti Carbonizzare",
            price = 198600,
            category = "SportsCars"
        }, {
            model = "comet2",
            label = "Piftster Comet",
            price = 161000,
            category = "SportsCars"
        }, {
            model = "Coquette",
            label = "Invertero Coquette",
            price = 167000,
            category = "SportsCars"
        }, {
            model = "elegy2",
            label = "Annis Elegy RH8",
            price = 166000,
            category = "SportsCars"
        }, {
            model = "feltzer2",
            label = "Benefacter Feltzer",
            price = 177800,
            category = "SportsCars"
        }, {
            model = "Fusilade",
            label = "Schyster Fusilade",
            price = 139000,
            category = "SportsCars"
        }, {
            model = "Futo",
            label = "Karin Futo",
            price = 13840,
            category = "CompactCars"
        }, {
            model = "blista3",
            label = "Dinka Go Go Monkey Blista",
            price = 10600,
            category = "CompactCars"
        }, {
            model = "Penumbra",
            label = "Maibatsu Penumbra",
            price = 143000,
            category = "SportsCars"
        }, {
            model = "rapidgt",
            label = "Dewbauchee Rapid GT",
            price = 168400,
            category = "SportsCars"
        }, {
            model = "rapidgt2",
            label = "Dewbauchee Rapid GT(cabrio)",
            price = 174400,
            category = "SportsCars"
        }, {
            model = "schwarzer",
            label = "Benefactor Schwartzer",
            price = 132000,
            category = "SportsCars"
        }, {
            model = "Surano",
            label = "Benefactor Surano",
            price = 187520,
            category = "SportsCars"
        }, {
            model = "dominator9",
            label = "Vapid Dominator GT",
            price = 197000,
            category = "SportsCars"
        },{
            model = "r300",
            label = "Annis 300R",
            price = 189000,
            category = "SportsCars"
        },{
            model = "panthere",
            label = "Toundra Panthere",
            price = 179000,
            category = "SportsCars"
        },{
            model = "Dominator",
            label = "Vapid Dominator",
            price = 126600,
            category = "MuscleCars"
        },{
            model = "impaler5",
            label = "Declasse Impaler SZ",
            price = 181000,
            category = "MuscleCars"
        },{
            model = "brigham",
            label = "Albany Brigham",
            price = 147000,
            category = "MuscleCars"
        },{
            model = "tahoma",
            label = "Declasse Tahoma Coupe",
            price = 127000,
            category = "MuscleCars"
        },{
            model = "tulip2",
            label = "Declasse Tulip M-100",
            price = 142000,
            category = "MuscleCars"
        },{
            model = "broadway",
            label = "Classique Broadway",
            price = 155000,
            category = "MuscleCars"
        },{
            model = "eudora",
            label = "Willard Eudora",
            price = 149000,
            category = "MuscleCars"
        },{
            model = "Gauntlet",
            label = "Bravado Gauntlet",
            price = 128800,
            category = "MuscleCars"
        }, {
            model = "Phoenix",
            label = "Imponte Phoenix",
            price = 59000,
            category = "MuscleCars"
        }, {
            model = "Picador",
            label = "Cheval Picador",
            price = 113000,
            category = "MuscleCars"
        }, {
            model = "Ruiner",
            label = "Imponte Ruiner",
            price = 99000,
            category = "MuscleCars"
        }, {
            model = "SABREGT",
            label = "Declasse Sabre Turbo",
            price = 157000,
            category = "MuscleCars"
        }, {
            model = "Stalion",
            label = "Declasse Stallion",
            price = 129000,
            category = "MuscleCars"
        }, {
            model = "Vigero",
            label = "Declasse Vigero",
            price = 139400,
            category = "MuscleCars"
        }, {
            model = "Bullet",
            label = "Vapid Bullet",
            price = 1720000,
            category = "Supercars"
        }, {
            model = "Cheetah",
            label = "Grotti Cheetah",
            price = 1730000,
            category = "Supercars"
        }, {
            model = "entityxf",
            label = "Overflod Entity XF",
            price = 1698000,
            category = "Supercars"
        }, {
            model = "Infernus",
            label = "Pegassi Infernus",
            price = 1350000,
            category = "Supercars"
        }, {
            model = "Vacca",
            label = "Pegassi Vacca",
            price = 1760000,
            category = "Supercars"
        }, {
            model = "Voltic",
            label = "Coil Voltic",
            price = 1500000,
            category = "Supercars"
        }, {
            model = "Manana",
            label = "Albany Manana",
            price = 108000,
            category = "SportsClassics"
        }, {
            model = "Stinger",
            label = "Grotti Stinger",
            price = 171000,
            category = "SportsClassics"
        }, {
            model = "stingertt",
            label = "Grotti Itali GTO Stinger TT",
            price = 197000,
            category = "SportsClassics"
        }, {
            model = "Tornado",
            label = "Declasse Tornado",
            price = 115000,
            category = "SportsClassics"
        }, {
            model = "Tornado2",
            label = "Tornado(cabrio)",
            price = 127000,
            category = "SportsClassics"
        }, {
            model = "Fugitive",
            label = "Cheval Fugitive",
            price = 87400,
            category = "Sedans"
        }, {
            model = "Intruder",
            label = "Karin Intruder",
            price = 125000,
            category = "Sedans"
        }, {
            model = "Premier",
            label = "Declasse Premier",
            price = 67000,
            category = "Sedans"
        }, {
            model = "Primo",
            label = "Albany Primo",
            price = 139000,
            category = "Sedans"
        }, {
            model = "Regina",
            label = "Dundreary Regina",
            price = 86200,
            category = "Sedans"
        }, {
            model = "Schafter2",
            label = "Benefactor Schafter",
            price = 121800,
            category = "Sedans"
        }, {
            model = "Stanier",
            label = "Vapid Stanier",
            price = 106000,
            category = "Sedans"
        }, {
            model = "Stratum",
            label = "Zirconium Stratum",
            price = 85000,
            category = "Sedans"
        }, {
            model = "Stretch",
            label = "Dundreary Stretch",
            price = 85000,
            category = "Sedans"
        }, {
            model = "superd",
            label = "Enus Super Diamond",
            price = 107000,
            category = "Sedans"
        }, {
            model = "Surge",
            label = "Cheval Surge",
            price = 88200,
            category = "Sedans"
        }, {
            model = "Tailgater",
            label = "Obey Tailgater",
            price = 154200,
            category = "Sedans"
        }, {
            model = "Washington",
            label = "Albany Washington",
            price = 134000,
            category = "Sedans"
        }, {
            model = "bjxl",
            label = "Karin BeeJay XL",
            price = 135200,
            category = "SUVs"
        }, {
            model = "Cavalcade",
            label = "Albany Cavalcade",
            price = 126380,
            category = "SUVs"
        }, {
            model = "Cavalcade2",
            label = "Albany Cavalcade (second generation)",
            price = 125900,
            category = "SUVs"
        }, {
            model = "Granger",
            label = "Declasse Granger",
            price = 157100,
            category = "SUVs"
        }, {
            model = "Gresley",
            label = "Bravado Gresley",
            price = 155300,
            category = "SUVs"
        }, {
            model = "Habanero",
            label = "Emperor Habanero",
            price = 131960,
            category = "SUVs"
        }, {
            model = "Landstalker",
            label = "Dundreary Landstalker",
            price = 170700,
            category = "SUVs"
        }, {
            model = "Mesa",
            label = "Canis Mesa",
            price = 156800,
            category = "SUVs"
        }, {
            model = "Patriot",
            label = "Mammoth Patriot",
            price = 166400,
            category = "SUVs"
        }, {
            model = "Radius",
            label = "Vapid Radius",
            price = 118500,
            category = "SUVs"
        }, {
            model = "Rocoto",
            label = "Obey Rocoto",
            price = 160000,
            category = "SUVs"
        }, {
            model = "Seminole",
            label = "Canis Seminole",
            price = 159500,
            category = "SUVs"
        }, {
            model = "Serrano",
            label = "Benefactor Serrano",
            price = 131930,
            category = "SUVs"
        }, {
            model = "Dilettante",
            label = "Karin Dilettante",
            price = 12200,
            category = "CompactCars"
        }, {
            model = "Prairie",
            label = "Bollokan Prairie",
            price = 13700,
            category = "CompactCars"
        }, {
            model = "Felon",
            label = "Lampadati Felon",
            price = 160880,
            category = "Coupes"
        }, {
            model = "Felon2",
            label = "Lampadati Felon GT",
            price = 170400,
            category = "Coupes"
        }, {
            model = "Jackal",
            label = "Ocelot Jackal",
            price = 135000,
            category = "Coupes"
        }, {
            model = "Oracle",
            label = "Ubermacht Oracle XS",
            price = 163000,
            category = "Coupes"
        }, {
            model = "Oracle2",
            label = "Ubermacht Oracle",
            price = 151600,
            category = "Coupes"
        }, {
            model = "Sentinel",
            label = "Ubermacht Sentinel",
            price = 150400,
            category = "Coupes"
        }, {
            model = "Sentinel2",
            label = "Ubermacht Sentinel XS",
            price = 161600,
            category = "Coupes"
        }, {
            model = "Zion",
            label = "Ubermacht Zion",
            price = 132000,
            category = "Coupes"
        }, {
            model = "Zion2",
            label = "Ubermacht Zion Cabrio",
            price = 168000,
            category = "Coupes"
        }, {
            model = "bati",
            label = "Pegassi Bati 801",
            price = 152400,
            category = "Motorcycles"
        }, {
            model = "bati2",
            label = "Pegassi Bati 801RR",
            price = 144600,
            category = "Motorcycles"
        }, {
            model = "CarbonRS",
            label = "Nagasaki Carbon RS",
            price = 129600,
            category = "Motorcycles"
        }, {
            model = "Double",
            label = "Dinka Double T",
            price = 147000,
            category = "Motorcycles"
        }, {
            model = "Nemesis",
            label = "Principe Nemesis",
            price = 114800,
            category = "Motorcycles"
        }, {
            model = "PCJ",
            label = "Shitzu PCJ 600",
            price = 83000,
            category = "Motorcycles"
        }, {
            model = "Ruffian",
            label = "Pegassi Ruffian",
            price = 155200,
            category = "Motorcycles"
        }, {
            model = "Vader",
            label = "Shitzu Vader",
            price = 101000,
            category = "Motorcycles"
        }, {
            model = "blazer3",
            label = "Nagasaki Hot Rod Blazer",
            price = 134000,
            category = "OffroadVehicles"
        },{
            model = "RancherXL",
            label = "Declasse Rancher XL",
            price = 134000,
            category = "OffroadVehicles"
        }, {
            model = "Rebel2",
            label = "Karin Rebel",
            price = 146000,
            category = "OffroadVehicles"
        }, {
            model = "Rebel",
            label = "Karin Rebel(rusty)",
            price = 125000,
            category = "OffroadVehicles"
        }, {
            model = "Sandking2",
            label = "Vapid Sandking SWB",
            price = 155600,
            category = "OffroadVehicles"
        }, {
            model = "Sandking",
            label = "Vapid Sandking XL",
            price = 163600,
            category = "OffroadVehicles"
        }, {
            model = "burrito",
            label = "Declasse Burrito",
            price = 117000,
            category = "Vans"
        }, {
            model = "burrito3",
            label = "Declasse Burrito 2nd Gen",
            price = 117000,
            category = "Vans"
        }, {
            model = "Minivan",
            label = "Vapid Minivan",
            price = 131000,
            category = "Vans"
        }, {
            model = "Rumpo",
            label = "Bravado Rumpo",
            price = 160000,
            category = "Vans"
        }, {
            model = "Speedo",
            label = "Vapid Speedo",
            price = 127000,
            category = "Vans"
        }, {
            model = "Surfer",
            label = "BF Surfer",
            price = 135000,
            category = "Vans"
        }, {
            model = "Youga",
            label = "Bravado Youga",
            price = 131600,
            category = "Vans"
        }, -- Vans
        {
            model = "bison",
            label = "Bravado Bison Mighty Bush",
            price = 149000,
            category = "Vans"
        }, {
            model = "bison2",
            label = "Bravado Bison Construction",
            price = 125000,
            category = "Vans"
        }, {
            model = "bobcatxl",
            label = "Vapid Bobcat XL",
            price = 113000,
            category = "Vans"
        }, {
            model = "Speedo4",
            label = "Vapid Speedo Custom",
            price = 139000,
            category = "Vans"
        }, {
            model = "youga2",
            label = "Bravado Youga Classic",
            price = 157000,
            category = "Vans"
        }, {
            model = "minivan2",
            label = "Vapid Minivan Custom",
            price = 2220000,
            category = "Vans"
        }, {
            model = "Reever",
            label = "WMC Reever",
            price = 105000,
            category = "bike"
        }, {
            model = "asbo",
            label = "Maxwell Asbo",
            price = 1000,
            category = "CompactCars"
        }, {
            model = "brioso",
            label = "Grotti Brioso R/A",
            price = 9800,
            category = "CompactCars"
        }, {
            model = "brioso2",
            label = "Grotti Brioso 300",
            price = 7200,
            category = "CompactCars"
        }, {
            model = "virgo3",
            label = "Dundreary Virgo Classic",
            price = 23000,
            category = "MuscleCars"
        }, {
            model = "Emperor",
            label = "Albony Emperor",
            price = 43000,
            category = "Sedan"
        }, {
            model = "lurcher",
            label = "Hearse",
            price = 40000,
            category = "Sedan"
        }, {
            model = "Yosemite",
            label = "Declasse Yosemite",
            price = 33000,
            category = "MuscleCars"
        }, {
            model = "ratloader",
            label = "Bravado Rat-Loader",
            price = 33000,
            category = "MuscleCars"
        }, {
            model = "ratloader2",
            label = "Bravado Rat-Truck",
            price = 61400,
            category = "MuscleCars"
        }, {
            model = "voodoo2",
            label = "Declasse Voodoo",
            price = 58000,
            category = "MuscleCars"
        }, {
            model = "Nightshade",
            label = "Imponte Nightshade",
            price = 59000,
            category = "MuscleCars"
        }, {
            model = "phoenix",
            label = "Imponte Phoenix",
            price = 53600,
            category = "MuscleCars"
        }, {
            model = "Emperor2",
            label = "Albany Emperor",
            price = 53600,
            category = "MuscleCars"
        }, {
            model = "ingot",
            label = "Vulcar Ingot",
            price = 68000,
            category = "Sedan"
        }, {
            model = "blista",
            label = "Dinka Blista",
            price = 80000,
            category = "compacts"
        }, {
            model = "Surfer2",
            label = "BF Surfer (beater)",
            price = 37000,
            category = "Vans"
        },{
            model = "tribike2",
            label = "Endurex Race Bike",
            price = 56000,
            category = "RaceBikes"
        },{
            model = "tribike3",
            label = "Tri-Cycles Race Bike",
            price = 56000,
            category = "RaceBikes"
        },{
            model = "tribike",
            label = "Whippet Race Bike",
            price = 56000,
            category = "RaceBikes"
        },{
            model = "inductor",
            label = "Coil Inductor",
            price = 84000,
            category = "RaceBikes"
        },{
            model = "inductor2",
            label = "Coil Junk Energy Inductor",
            price = 84000,
            category = "RaceBikes"
        }
}
    },
    ["Bike"] = {
        label = "Motorbike",
        coords = vector3(240.77, 2592.94, 45.16),
        heading = 58.46,
        pedModel = "a_m_m_business_01",
        bankAccount = "government",
        preview = vector4(234.34, 2592.92, 44.56, 21.34),
        testDrive = true,
        testDriveSpawn = vector4(234.34, 2592.92, 44.56, 21.34),
        testDriveLength = 180,
        testDrivePlate = 'BIKETEST',
        license = "driver", -- this must match metadata.licences["driver"]
        licenseItem = "driver_license", -- physical item name in ox_inventory
        CheckLicense = "meta", -- options: "meta", "item", "both"
        webhook = false,
        allowSellBack = true,
        blip = true,
        blipicon = '',
        vehicles = {{
            model = "zombieb",
            label = "WMC Zombie Chopper",
            price = 50000,
            category = "bike"
        }, {
            model = "chimera",
            label = "Nagasaki Chimera",
            price = 30000,
            category = "trike"
        }, {
            model = "stryder",
            label = "Stryder",
            price = 30000,
            category = "quad"
        }, {
            model = "avarus",
            label = "LCC Avarus",
            price = 75000,
            category = "bike"
        }, {
            model = "bagger",
            label = "WMC Bagger",
            price = 250000,
            category = "bike"
        }, {
            model = "manchez",
            label = "Maibatsu Manchez",
            price = 50000,
            category = "bike"
        }, {
            model = "sanchez2",
            label = "Maibatsu Sanchez",
            price = 96000,
            category = "bike"
        }, {
            model = "manchez2",
            label = "Maibatsu Manchez Scout",
            price = 119800,
            category = "bike"
        }, {
            model = "rrocket",
            label = "WMC Rampant Rocket",
            price = 149800,
            category = "trike"
        }, {
            model = "blazer4",
            label = "Nagasaki Street Blazer",
            price = 147100,
            category = "quad"
        }, {
            model = "Blazer",
            label = "Nagasaki Blazer",
            price = 108000,
            category = "quad"
        }, {
            model = "defiler",
            label = "Shitzu Defiler",
            price = 146800,
            category = "bike"
        }, {
            model = "Nightblade",
            label = "WMC Nightblade",
            price = 155800,
            category = "bike"
        }, {
            model = "ratbike",
            label = "WMC Rat Bike",
            price = 98400,
            category = "bike"
        }, {
            model = "wolfsbane",
            label = "WMC Wolfsbane",
            price = 89000,
            category = "bike"
        }, {
            model = "zombiea",
            label = "WMC Zombie Bobber",
            price = 99000,
            category = "bike"
        }, {
            model = "daemon2",
            label = "WMC Daemon Custom",
            price = 157400,
            category = "bike"
        }, {
            model = "daemon",
            label = "WMC Daemon",
            price = 140200,
            category = "bike"
        }, {
            model = "vortex",
            label = "Pegassi Vortex",
            price = 166800,
            category = "bike"
        }, {
            model = "sanctus",
            label = "LCC Sanctus",
            price = 155000,
            category = "bike",
			maxOwned = 10
        }, {
            model = "esskey",
            label = "Pegassi Esskey",
            price = 137200,
            category = "bike"
        }, {
            model = "gargoyle",
            label = "WMC Gargoyle",
            price = 162400,
            category = "bike"
        }, {
            model = "cliffhanger",
            label = "WMC Cliffhanger",
            price = 146800,
            category = "bike"
        }, {
            model = "vindicator",
            label = "Dinka Vindicator",
            price = 131200,
            category = "bike"
        }, {
            model = "enduro",
            label = "Dinka Enduro",
            price = 116400,
            category = "bike"
        }, {
            model = "lectro",
            label = "Principe Lectro",
            price = 163200,
            category = "bike"
        }, {
            model = "innovation",
            label = "LCC Innovation",
            price = 133900,
            category = "bike"
        }, {
            model = "sovereign",
            label = "WMC Sovereign",
            price = 81000,
            category = "bike"
        }, {
            model = "Hexer",
            label = "LCC Hexer",
            price = 133200,
            category = "bike"
        }, {
            model = "verus",
            label = "Dinka Verus",
            price = 122000,
            category = "quad"
        }, {
            model = "Sanchez",
            label = "Maibatsu Sanchez (Livery)",
            price = 130400,
            category = "bike"
        }, {
            model = "manchez3",
            label = "Maibatsu Manchez Scout C",
            price = 121000,
            category = "bike"
        }, {
            model = "powersurge",
            label = "Western Motorcycle Company Powersurge)",
            price = 167000,
            category = "bike"
        }, {
            model = "youga3",
            label = "Declasse Youga Classic 4x4",
            price = 100000,
            category = "Vans"
        }, {
            model = "gburrito2",
            label = "Declasse Gang Burrito Custom",
            price = 100000,
            category = "Vans"
        }, {
            model = "gburrito",
            label = "Declasse Gang Burrito",
            price = 100000,
            category = "Vans",
			maxOwned = 10
        }}
    },

    ["Helipad"] = {
        label = "Helipad Tours",
        coords = vector3(-733.29, -1466.37, 5.0),
        heading = 320.32,
        pedModel = "a_m_m_business_01",
        bankAccount = "government",
        preview = vector4(-744.25, -1468.93, 4.76, 130.37),
        testDrive = true,
        testDriveSpawn = vector4(-744.25, -1468.93, 4.76, 130.37),
        testDriveLength = 180,
        testDrivePlate = 'HELITEST',
        license = "pilotheli", -- this must match metadata.licences["driver"]
        licenseItem = "pilotheli_license", -- physical item name in ox_inventory
        CheckLicense = "meta", -- options: "meta", "item", "both"
        webhook = false,
        allowSellBack = false,
        blip = true,
        blipicon = '',
        vehicles = {{
            model = "annihilator",
            label = "Western Anhiliator",
            price = 560000,
            category = "helicopters"
        }, {
            model = "maverick",
            label = "Western Maverick",
            price = 600000,
            category = "helicopters"
        }, {
            model = "frogger",
            label = "Maibatsu Frogger",
            price = 600000,
            category = "helicopters"
        },{
            model = "seasparrow2",
            label = "Sea Sparrow Non-Amphibious",
            price = 400000,
            category = "helicopters"
        }, {
            model = "seasparrow",
            label = "Sea Sparrow Amphibious",
            price = 450000,
            category = "helicopters"
        }, {
            model = "Havok",
            label = "Nagasaki Havok",
            price = 300000,
            category = "helicopters"
        }, {
            model = "buzzard2",
            label = "Nagasaki Buzzard",
            price = 500000,
            category = "helicopters"
        }, {
            model = "conada",
            label = "Buckingham Conada",
            price = 600000,
            category = "helicopters"
        }, }
    },
["HelipadAirport"] = {
        label = "Fox Helicopters",
        coords = vector3(-962.24, -2956.97, 13.95),
        heading = 134.25,
        pedModel = "a_m_m_business_01",
        bankAccount = "government",
        preview = vector4(-972.96, -2952.03, 13.95, 141.18),
        testDrive = true,
        testDriveSpawn = vector4(-1146.12, -2864.43, 13.95, 323.95),
        testDriveLength = 180,
        testDrivePlate = 'HELITEST',
        license = "pilotheli", -- this must match metadata.licences["driver"]
        licenseItem = "pilotheli_license", -- physical item name in ox_inventory
        CheckLicense = "meta", -- options: "meta", "item", "both"
        webhook = false,
        allowSellBack = false,
        blip = true,
        blipicon = '',
        vehicles = {{
            model = "Volatus",
            label = "Volatus",
            price = 85000,
            category = "helicopters"
        }, {
            model = "supervolito",
            label = "Volito",
            price = 100000,
            category = "helicopters"
        }, {
            model = "supervolito2",
            label = "Buckingham SuperVolito Carbon",
            price = 150000,
            category = "helicopters"
        }, {
            model = "swift2",
            label = "Buckingham Swift Deluxe",
            price = 125000,
            category = "helicopters"
        }, {
            model = "swift",
            label = "Buckingham Swift",
            price = 100000,
            category = "helicopters"
        }}
    },
    ["FoxPlane"] = {
        label = "Fox Planes",
        coords = vector3(-961.42, -2972.83, 13.95),
        heading = 70.42,
        pedModel = "a_m_m_business_01",
        bankAccount = "mechanic",
        preview = vector4(-956.19, -2988.81, 13.95, 237.06),
        testDrive = true,
        testDriveSpawn = vector4(-1059.92, -2971.29, 13.96, 147.41),
        testDriveLength = 180,
        testDrivePlate = 'PLANETEST',
        license = "pilot", -- this must match metadata.licences["driver"]
        licenseItem = "pilot_license", -- physical item name in ox_inventory
        CheckLicense = "meta", -- options: "meta", "item", "both"
        webhook = false,
        allowSellBack = false,
        blip = true,
        blipicon = '',

        vehicles = {{
            model = "shamal",
            label = "Private Jet : Buckingham Shamal",
            price = 175000,
            category = "Jets"
        }, {
            model = "pyro",
            label = "Pyro",
            price = 80000,
            category = "Jets"
        }, {
            model = "alphaz1",
            label = "Buckingham Alpha-Z1",
            price = 137600,
            category = "Props"
        }, {
            model = "microlight",
            label = "Nagasaki Ultralight",
            price = 16000,
            category = "Props"
        }, {
            model = "howard",
            label = "Buckingham Howard NX-25",
            price = 13280,
            category = "Props"
        }, {
            model = "seabreeze",
            label = "Western Company Seabreeze",
            price = 19600,
            category = "Props"
        }, {
            model = "velum2",
            label = "Jobuilt Velum 5-Seater",
            price = 14800,
            category = "TurboProps"
        }, {
            model = "nimbus",
            label = "Private Jet : Buckingham Nimbus",
            price = 125000,
            category = "Jets"
        }, {
            model = "luxor2",
            label = "Private Jet : Buckingham Luxor Deluxe",
            price = 550000,
            category = "Jets"
        }, {
            model = "besra",
            label = "Western Company Besra",
            price = 124000,
            category = "Jets"
        }, {
            model = "Miljet",
            label = "Private Jet : Buckingham Miljet",
            price = 258000,
            category = "Jets"
        }, {
            model = "vestra",
            label = "Business Jet : Buckingham Vestra",
            price = 168000,
            category = "Jets"
        }, {
            model = "dodo",
            label = "Mammoth Dodo",
            price = 204000,
            category = "Props"
        }, {
            model = "duster",
            label = "Western Company Duster",
            price = 136000,
            category = "Props"
        }, {
            model = "stunt",
            label = " Western Company Mallard",
            price = 148000,
            category = "Props"
        }, {
            model = "mammatus",
            label = "Jobuilt Mammatus",
            price = 139000,
            category = "Props"
        }, {
            model = "titan",
            label = "Eberhard Titan",
            price = 242000,
            category = "TurboProps"
        }, {
            model = "Velum",
            label = "Jobuilt Velum 4-seater",
            price = 20000,
            category = "TurboProps"
        }, {
            model = "streamer216",
            label = "Mammoth Streamer 216",
            price = 190000,
            category = "TurboProps"
        },	{
            model = "cuban800",
            label = "Western Company Cuban 800",
            price = 159000,
            category = "Props"
        }}
    },

    ["Boat"] = {
        label = "Boats",
        coords = vector3(-806.9688, -1497.8684, 1.5952),
        heading = 70.42,
        pedModel = "a_m_m_business_01",
        bankAccount = "government",
        preview = vector4(-813.6932, -1509.1611, -0.4748, 285.3133),
        testDrive = true,
        testDriveSpawn = vector4(-814.6631, -1483.0786, -0.4744, 117.5068),
        testDriveLength = 180,
        testDrivePlate = 'BOATTEST',
        license = "boat", -- this must match metadata.licences["driver"]
        licenseItem = "boat_license", -- physical item name in ox_inventory
        CheckLicense = "meta", -- options: "meta", "item", "both"
        webhook = false,
        allowSellBack = false,
        blip = true,
        blipicon = '',

        vehicles = {{
            model = "avisa",
            label = "Kraken Avisa",
            price = 98000,
            category = "Subs"
        }, {
            model = "submersible2",
            label = "Kraken Kraken",
            price = 54000,
            category = "Subs"
        }, {
            model = "submersible",
            label = "Kraken Submersible",
            price = 54000,
            category = "Subs"
        }, {
            model = "longfin",
            label = "Shitzu Longfin",
            price = 172000,
            category = "Boats"
        }, {
            model = "tug",
            label = "Buckingham Tug",
            price = 35000,
            category = "Boats"
        }, {
            model = "toro",
            label = "Lampadati Toro ",
            price = 103000,
            category = "Boats"
        }, {
            model = "speeder",
            label = "Pegassi Speeder",
            price = 122000,
            category = "Boats"
        }, {
            model = "speeder2",
            label = "Pegassi Speeder Slimline",
            price = 121000,
            category = "Boats"
        }, {
            model = "jetmax",
            label = "Shitzu Jetmax",
            price = 149200,
            category = "Boats"
        }, {
            model = "dinghy2",
            label = "Nagasaki Dinghy 2-seater",
            price = 150400,
            category = "Boats"
        }, {
            model = "dinghy3",
            label = "Nagasaki Dinghy 4-seater",
            price = 150400,
            category = "Boats"
        }, {
            model = "squalo",
            label = "Shitzu Squalo ",
            price = 134000,
            category = "Boats"
        }, {
            model = "suntrap",
            label = "Shitzu Suntrap",
            price = 136000,
            category = "Boats"
        }, {
            model = "tropic",
            label = "Shitzu Tropic ",
            price = 125000,
            category = "Boats"
        }, {
            model = "seashark",
            label = "Speedophile 2000",
            price = 114000,
            category = "JetSkis"
        }, {
            model = "seashark3",
            label = "Speedophile 2001",
            price = 124800,
            category = "JetSkis"
        }}
    },

    ["HGV"] = {
        label = "Trucks",
        coords = vector3(920.34, -1171.25, 25.59),
        heading = 69.96,
        pedModel = "a_m_m_business_01",
        bankAccount = "government",
        preview = vector4(923.86, -1166.68, 25.59, 87.9),
        testDrive = true,
        testDriveSpawn = vector4(923.86, -1166.68, 25.59, 87.9),
        testDriveLength = 180,
        testDrivePlate = 'HGVTEST',
        license = "hgv", -- this must match metadata.licences["driver"]
        licenseItem = "hgv_license", -- physical item name in ox_inventory
        CheckLicense = "meta", -- options: "meta", "item", "both"
        webhook = false,
        allowSellBack = false,
        blip = true,
        blipicon = '',
        vehicles = {{
            model = "benson",
            label = "Benson HD",
            price = 127000,
            category = "Storages"
        }, {
            model = "phantom",
            label = "Phantom",
            price = 800000,
            category = "Cabs"
        }, {
            model = "vetir",
            label = "HVY Vetir",
            price = 171000,
            category = "Storages"
        }, {
            model = "boxville6",
            label = "Brute Boxville (LSDS)",
            price = 129000,
            category = "Storages"
        },{
            model = "benson2",
            label = "Vapid Benson (Cluckin' Bell)",
            price = 129000,
            category = "Storages"
        },{
            model = "brickade2",
            label = "MTL Brickade 6x6",
            price = 88500,
            category = "Storages"
        },{
            model = "mule4",
            label = "Maibatsu Mule Custom",
            price = 163000,
            category = "Storages"
        }, {
            model = "pounder2",
            label = "MTL Pounder Custom",
            price = 144000,
            category = "Storages"
        }, {
            model = "phantom3",
            label = "Jobuilt Phantom Custom",
            price = 160000,
            category = "Cabs"
        }, {
            model = "wastelander",
            label = "MTL Wastelander",
            price = 122000,
            category = "Storages"
        }, {
            model = "rallytruck",
            label = "MTL Dune",
            price = 144000,
            category = "Storages"
        }, {
            model = "brickade",
            label = "MTL Brickade",
            price = 104000,
            category = "Storages"
        }, {
            model = "mule",
            label = "Maibatsu Mule",
            price = 149000,
            category = "Storages"
        }, {
            model = "boxville2",
            label = "Brute Boxville",
            price = 129000,
            category = "Storages"
        }, {
            model = "Barracks",
            label = "HVY Barracks",
            price = 211000,
            category = "Storages"
        }, {
            model = "Pony",
            label = "Brute Pony",
            price = 121500,
            category = "Storages"
        }, {
            model = "Boxville",
            label = "Brute Boxville",
            price = 89000,
            category = "Storages"
        }}
    }


       		--[[ ["RV"] = {
        label = "RVs",
        coords = vector3(1224.6896, 2728.6677, 173.7936),
        heading = 38.0050,
        pedModel = "a_m_m_business_01",
        bankAccount = "government",
        preview = vector4(1236.6852, 2715.8762, 37.4880, 206.9636),
        testDrive = true,
        testDriveSpawn = vector4(1252.5804, 2692.9661, 37.4389, 133.7944),
	    testDriveLength = 180,
	    testDrivePlate = 'RVTEST',
        license = "hgv", -- this must match metadata.licences["driver"]
        licenseItem = "hgv_license",  -- physical item name in ox_inventory
        CheckLicense = "meta", -- options: "meta", "item", "both"
        webhook = false,
        allowSellBack = true,
        blip = true,
        blipicon = '',
        vehicles = {
            { model = "journey", label = "Zirconium Journey", price = 161000, category = "Class B" },
			{ model = "camper", label = "Brute Camper", price = 164000, category = "Class A" },
            { model = "journey2", label = "Zirconium Journey Gen II", price = 162200, category = "Class B" },
			{ model = "surfer3", label = "BF Surfer Custom", price = 135000, category = "Class C" },
			{ model = "galaxyroamer", label = "Brute Galaxy Roamer RV", price = 41000, category = "Class A" },
            { model = "brickaderv", label = "MTL Brickade RV", price = 0, category = "Class A" },
            { model = "sandroamer", label = "Vapid Sandroamer", price = 0, category = "Class B" },
			{ model = "cararv", label = "Caracara RV", price = 0, category = "Class C" },
            { model = "guardianrv", label = "Guardian RV", price = 0, category = "Class B" },
			{ model = "sandkingrv", label = "Sandking RV", price = 0, category = "Class C" },]] --

       -- },
    --}

}

function GiveVehicleKeys(vehicle)
    exports['MrNewbVehicleKeys']:GiveKeys(vehicle)
exports['rcore_fuel']:SetVehicleFuel(vehicle, 100.0)

end

function RemoveVehicleKeys(vehicle)
    exports['MrNewbVehicleKeys']:RemoveKeys(vehicle)
end


