function has(item, amount)
    local count = Tracker:ProviderCountForCode(item)
    amount = tonumber(amount)
    if not amount then
        return count > 0
    else
        return count >= amount
    end
end

function spring()
    return has("spring")
end

function summer()
    return has("summer")
end

function fall()
    return has("fall")
end

function winter()
    return has("winter")
end

function can_mine_copper()
    return (has("Pick") or has("e5"))
end

function can_mine_iron()
    return (has("CopperPick") or has("e40"))
end

function can_mine_gold()
    return (has("CopperPick") or has("e80"))
end

function has_skull_key()
    return has("skullkey")
end

function can_mine_iridium()
    return (has("CopperPick") and ((has("desert") and has("skullkey")) or has("island")))
end

function can_fish()
    return has("rod")
end

function has_crab_pots()
    return (can_mine_iron() and has("fishing",3))
end

function can_chop_stumps()
    return has("CopperAxe")
end

function can_chop_logs()
    return has("SteelAxe")
end

function has_coop()
    return has("chicken")
end

function has_big_coop()
    return has("duck")
end

function has_deluxe_coop()
    return has("rabbit")
end

function has_barn()
    return has("cow")
end

function has_big_barn()
    return has("goat")
end

function has_deluxe_barn()
    return has("pig")
end

function has_bridge()
    return has("bridge")
end

function secret_notes()
    return has("notes")
end

function can_cook()
    return (has("kitchen") or has("foraging",9))
end

function can_brew()
    return has("farming",8)
end

function farming1()
    return has("farming",1)
end

function tmmon()
    return has("monday")
end

function tmtues()
    return has("tuesday")
end

function tmwed()
    return has("wednesday")
end

function tmthurs()
    return has("thursday")
end

function tmfri()
    return has("friday")
end

function tmsat()
    return has("saturday")
end

function tmsun()
    return has("sunday")
end

function quests1()
    return has("quests",1)
end
function quests2()
    return has("quests",2)
end
function quests3()
    return has("quests",3)
end
function quests4()
    return has("quests",4)
end
function quests5()
    return has("quests",5)
end
function quests6()
    return has("quests",6)
end
function quests7()
    return has("quests",7)
end
function quests8()
    return has("quests",8)
end
function quests9()
    return has("quests",9)
end
function quests10()
    return has("quests",10)
end
function quests11()
    return has("quests",11)
end
function quests12()
    return has("quests",12)
end
function quests13()
    return has("quests",13)
end
function quests14()
    return has("quests",14)
end
function quests15()
    return has("quests",15)
end
function quests16()
    return has("quests",16)
end
function quests17()
    return has("quests",17)
end
function quests18()
    return has("quests",18)
end
function quests19()
    return has("quests",19)
end
function quests20()
    return has("quests",20)
end
function quests21()
    return has("quests",21)
end
function quests22()
    return has("quests",22)
end
function quests23()
    return has("quests",23)
end
function quests24()
    return has("quests",24)
end
function quests25()
    return has("quests",25)
end
function quests26()
    return has("quests",26)
end
function quests27()
    return has("quests",27)
end
function quests28()
    return has("quests",28)
end
function quests29()
    return has("quests",29)
end
function quests30()
    return has("quests",30)
end
function quests31()
    return has("quests",31)
end
function quests32()
    return has("quests",32)
end
function quests33()
    return has("quests",33)
end
function quests34()
    return has("quests",34)
end
function quests35()
    return has("quests",35)
end
function quests36()
    return has("quests",36)
end
function quests37()
    return has("quests",37)
end
function quests38()
    return has("quests",38)
end
function quests39()
    return has("quests",39)
end
function quests40()
    return has("quests",40)
end
function quests41()
    return has("quests",41)
end
function quests42()
    return has("quests",42)
end
function quests43()
    return has("quests",43)
end
function quests44()
    return has("quests",44)
end
function quests45()
    return has("quests",45)
end
function quests46()
    return has("quests",46)
end
function quests47()
    return has("quests",47)
end
function quests48()
    return has("quests",48)
end
function quests49()
    return has("quests",49)
end
function quests50()
    return has("quests",50)
end
function quests51()
    return has("quests",51)
end
function quests52()
    return has("quests",52)
end
function quests53()
    return has("quests",53)
end
function quests54()
    return has("quests",54)
end
function quests55()
    return has("quests",55)
end
function quests56()
    return has("quests",56)
end

function can_get_mastery()
    return (has("farming",10) and has("mining",10) and has("foraging",10) and has("fishing",10) and has("combat",10) )
end

function has_gaterecipe()
    return has("gaterecipe")
end

function has_woodfencerecipe()
    return has("woodfencerecipe")
end

function has_fishsmokerrecipe()
    return has("fishsmokerrecipe")
end

function has_dehydratorrecipe()
    return has("dehydratorrecipe")
end

function has_deluxefertilizerrecipe()
    return has("deluxefertilizerrecipe")
end

function has_hyperspeedgrorecipe()
    return has("hyperspeedgrorecipe")
end

function has_deluxeretainingsoilrecipe()
    return has("deluxeretainingsoilrecipe")
end

function has_ancientseedsrecipe()
    return has("ancientseedsrecipe")
end

function has_grassstarterrecipe()
    return has("grassstarterrecipe")
end

function has_bluegrassstarterrecipe()
    return has("bluegrassstarterrecipe")
end

function has_fiberseedsrecipe()
    return has("fiberseedsrecipe")
end

function has_woodfloorrecipe()
    return has("woodfloorrecipe")
end

function has_rusticplankfloorrecipe()
    return has("rusticplankfloorrecipe")
end

function has_strawfloorrecipe()
    return has("strawfloorrecipe")
end

function has_weatheredfloorrecipe()
    return has("weatheredfloorrecipe")
end

function has_crystalfloorrecipe()
    return has("crystalfloorrecipe")
end

function has_stonefloorrecipe()
    return has("stonefloorrecipe")
end

function has_stonewalkwayfloorrecipe()
    return has("stonewalkwayfloorrecipe")
end

function has_brickfloorrecipe()
    return has("brickfloorrecipe")
end

function has_woodpathrecipe()
    return has("woodpathrecipe")
end

function has_gravelpathrecipe()
    return has("gravelpathrecipe")
end

function has_cobblestonepathrecipe()
    return has("cobblestonepathrecipe")
end

function has_steppingstonepathrecipe()
    return has("steppingstonepathrecipe")
end

function has_crystalpathrecipe()
    return has("crystalpathrecipe")
end

function has_qualitybobberrecipe()
    return has("qualitybobberrecipe")
end

function has_magicbaitrecipe()
    return has("magicbaitrecipe")
end

function has_weddingringrecipe()
    return has("weddingringrecipe")
end

function has_monstermuskrecipe()
    return has("monstermuskrecipe")
end

function has_fairydustrecipe()
    return has("fairydustrecipe")
end

function has_warptotemdesertrecipe()
    return has("warptotemdesertrecipe")
end

function has_warptotemislandrecipe()
    return has("warptotemislandrecipe")
end

function has_torchrecipe()
    return has("torchrecipe")
end

function has_campfirerecipe()
    return has("campfirerecipe")
end

function has_woodenbrazierrecipe()
    return has("woodenbrazierrecipe")
end

function has_stonebrazierrecipe()
    return has("stonebrazierrecipe")
end

function has_goldbrazierrecipe()
    return has("goldbrazierrecipe")
end

function has_carvedbrazierrecipe()
    return has("carvedbrazierrecipe")
end

function has_stumpbrazierrecipe()
    return has("stumpbrazierrecipe")
end

function has_barrelbrazierrecipe()
    return has("barrelbrazierrecipe")
end

function has_skullbrazierrecipe()
    return has("skullbrazierrecipe")
end

function has_marblebrazierrecipe()
    return has("marblebrazierrecipe")
end

function has_woodlamppostrecipe()
    return has("woodlamppostrecipe")
end

function has_ironlamppostrecipe()
    return has("ironlamppostrecipe")
end

function has_jackolanternrecipe()
    return has("jackolanternrecipe")
end

function has_furnacerecipe()
    return has("furnacerecipe")
end

function has_solarpanelrecipe()
    return has("solarpanelrecipe")
end

function has_ostrichincubatorrecipe()
    return has("ostrichincubatorrecipe")
end

function has_heavytapperrecipe()
    return has("heavytapperrecipe")
end

function has_bonemillrecipe()
    return has("bonemillrecipe")
end

function has_geodecrusherrecipe()
    return has("geodecrusherrecipe")
end

function has_tuboflowersrecipe()
    return has("tuboflowersrecipe")
end

function has_wickedstatuerecipe()
    return has("wickedstatuerecipe")
end

function has_chestrecipe()
    return has("chestrecipe")
end

function has_stonechestrecipe()
    return has("stonechestrecipe")
end

function has_bigchestrecipe()
    return has("bigchestrecipe")
end

function has_bigstonechestrecipe()
    return has("bigstonechestrecipe")
end

function has_woodsignrecipe()
    return has("woodsignrecipe")
end

function has_stonesignrecipe()
    return has("stonesignrecipe")
end

function has_textsignrecipe()
    return has("textsignrecipe")
end

function has_deluxescarecrowrecipe()
    return has("deluxescarecrowrecipe")
end

function has_miniobeliskrecipe()
    return has("miniobeliskrecipe")
end

function has_farmcomputerrecipe()
    return has("farmcomputerrecipe")
end

function has_hopperrecipe()
    return has("hopperrecipe")
end

function season_free_harvest()
    return (has("greenhouse") or can_reach_ifarm())
end

function can_reach_ifarm()
    return ((has("turtlew") and has("island")) or (has("parrots") and has("island")))
end