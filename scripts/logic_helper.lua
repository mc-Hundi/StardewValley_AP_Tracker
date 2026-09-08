function OnChangeTabs()
local booksanity = Tracker:FindObjectForCode("booksanity")
if booksanity.CurrentStage == 0 then
        Tracker:AddLayouts("layouts/tabs/tabs_no_booksanity.json")
	else
		Tracker:AddLayouts("layouts/tabs/tabs.json")
    end
end

ScriptHost:AddWatchForCode("booksanity layout handler", "booksanity", OnChangeTabs)