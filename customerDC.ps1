New-ADTrust -Name "IT.net" -Source "fin.customer.net" -Direction Outbound -TrustType Forest

# Parameters
$users = @{
    "CUSTOMER.net" = @(
        "ethan.roberts1993", "zoey.thompson1988", "ryan.baker1981", "hannah.perez1990", "caleb.morris1984",
        "violet.rodriguez1992", "nicholas.paterson1980", "layla.wood1985", "johnson.jackson1987", "aurora.morgan1983",
        "owen.reed1978", "lucy.ross1977", "joshua.perry1982", "stella.cox1989", "levi.richards1991",
        "aiden.hughes1986", "lily.gray1979", "andrew.butler1993", "victoria.bennett1988", "charlotte.rivera1990"
        ),
    "adm.customer.net" = @(
        "james.morris1980", "olivia.smith1975", "lucas.jones1982", "emma.brown1990", "noah.garcia1985",
        "ava.martinez1983", "liam.anderson1978", "sophia.thomas1986", "benjamin.taylor1981", "mia.moore1992",
        "elijah.lee1989", "amelia.clark1977", "jacob.hall1984", "isabella.young1993", "michael.adams1988"
    ),
    "fin.customer.net" = @(
        "alex.wilson1990", "ella.king1987", "william.scott1979", "harper.green1984", "daniel.phillips1982",
        "scarlett.carter1991", "matthew.cook1985", "chloe.mitchell1980", "henry.bailey1986", "nora.evans1983",
        "jack.hill1977", "ella.turner1989", "logan.walker1976", "grace.allen1992", "samuel.collins1988"
    )
}

# Unified Password Pool
$passwords = @(
    "@rch3rFl1ght11", "5had0wyTr41l9", "5parklingWat3r", "5pringB10oms33", "0ceanBreeze!12",
    "5nowfall88$", "5tarlight@Gl0w", "5stormyCloud55", "5unsetG1ft55", "B3achT1m3Fun!",
    "BrightStars22", "ButterFlyWings", "Campf1r35Vib3s!", "CalmTides22", "ChillyHorizon",
    "CloudyDays55", "Comet@H4ze77", "CosmicJourney55", "CosmicLight12", "CozyCabin99",
    "DaybreakBliss", "DewdropNest11", "DriftwoodShore", "EarthlyGlow33", "EveningCalm55",
    "ForestTrails33", "ForestWander11", "Fr0sty5M0rnings", "Free@domR1ngs11", "FrostyPeaks33",
    "GlimmeringSun", "G0ldenSunr1s3!", "GoldenFields55", "GoldenHarvest", "GoldenRays44",
    "HiddenValley99", "H1dden^Tr34sure", "MagicTrail99", "MeadowSunshine", "MeadowWander",
    "MidnightForest", "MoonbeamGlow", "MoonlitLake99", "MoonriseGlow88", "MorningDew11",
    "MountainHike99", "MountainShadow11", "MountainSpring88", "M@giCSpells33", "M0unt4in@Tr33k",
    "OceanDepths77", "OceanWhisper44", "OpenField66", "P3aceful#N1ght", "PastelHues22",
    "PeacefulWinds", "PrairieSky77", "Qu!etPath77", "QuietStream12", "RainbowGlow33",
    "RainbowTrail88", "ReflectingPond", "RiverStream99", "R1v3r@Breeze77", "R0seGarden#55",
    "SeasonalJoy99", "ShadyTrees99", "ShiningAurora", "ShiningMoon22", "SilverMoonlight99",
    "Sk@t3park88", "Snowfall11", "SpringMeadow12", "StarryJourney88", "St@rrySk1es22",
    "StarlitPath22", "SummerBreeze22", "SummerHaven99", "SunnySkies77", "Sunn!yD4ys88",
    "SunsetDream22", "SunsetG1ft^^", "SunsetHike88", "SunsetMountain21", "SunsetView88",
    "T3chn0&ong77", "T1d3s@High99", "TidalWave11", "ValleyPeace88", "WarmMeadow77",
    "WildflowerPath", "Wintry&Land22", "WinterWonderland", "WoodlandWalk12"
)

# Function to select a password
function Get-RandomPassword {
    return $passwords | Get-Random
}

# Create Users with Passwords
foreach ($domain in $users.Keys) {
    $userList = $users[$domain]
    foreach ($user in $userList) {
        $password = Get-RandomPassword
        $ouPath = "OU=Users,DC=$($domain -replace '\.', ',DC=')"

        # Create user
        New-ADUser -SamAccountName $user -UserPrincipalName "$user@$domain" `
            -Name $user -AccountPassword (ConvertTo-SecureString $password -AsPlainText -Force) `
            -Enabled $true -Path $ouPath

        # Display User Info
        Write-Host "Created user: $user in domain: $domain with password: $password"
    }
}
