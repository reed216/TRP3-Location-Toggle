local ADDON_NAME, API = ...

local Localization = {
    enUS = {
        ADDON_LOCTOGGLE_tooltip_visible = "Location:%s Visible",
        ADDON_LOCTOGGLE_tooltip_hidden = "Location:%s Hidden",
        ADDON_LOCTOGGLE_tooltip_subtitle = "Click to toggle location on/off",
    },
    deDE = {
        ADDON_LOCTOGGLE_tooltip_visible = "Standort:%s Sichtbar",
        ADDON_LOCTOGGLE_tooltip_hidden = "Standort:%s Unsichtbar",
        ADDON_LOCTOGGLE_tooltip_subtitle = "Klicken um Standort ein/aus zu schalten",
    }
    
}

TRP3_API.loc:GetDefaultLocale():AddTexts(Localization.enUS)
for locale, texts in pairs(Localization) do
    TRP3_API.loc:GetLocale(locale):AddTexts(texts)
end