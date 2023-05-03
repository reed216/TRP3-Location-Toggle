------------------------------------------------------
-- TRP3 Location Toggle by iMintty_ (Curse)
------------------------------------------------------

------------------------------------------------------

-- WoW imports
local format = format

-- TRP imports
local getConfigValue, registerConfigHandler, setConfigValue, loc, color = TRP3_API.configuration.getValue, TRP3_API.configuration.registerHandler, TRP3_API.configuration.setValue, TRP3_API.loc, TRP3_API.utils.str.color

local function onStart()
    local visibleIcon = "inv_darkmoon_eye"
    local hiddenIcon = "spell_shadow_auraofdarkness"
    if TRP3_API.globals.is_classic then
        visibleIcon = "spell_shadow_shadowworddominate"
    end

    local location_setting_updated = true

    local tooltip_loc_shown = format(loc.ADDON_LOCTOGGLE_tooltip_visible, color("g"))
    local tooltip_loc_hidden = format(loc.ADDON_LOCTOGGLE_tooltip_hidden, color("r"))

    TRP3_API.RegisterCallback(TRP3_Addon, TRP3_Addon.Events.WORKFLOW_ON_LOADED, function()
        if not TRP3_API.toolbar then
            TRP3_API.utils.message.displayMessage(color("r").."The 'Toolbar' module must be enabled for Location Toggle to work!")
            return
        end

        TRP3_API.toolbar.toolbarAddButton{
            id = "trp3_location_toggle",
            icon = visibleIcon,
            configText = "Location Toggle",
            tooltip = "Location Toggle",
            tooltipSub = loc.ADDON_LOCTOGGLE_tooltip_subtitle,
            onUpdate = function(Uibutton, buttonStructure)
                TRP3_API.toolbar.updateToolbarButton(Uibutton, buttonStructure)
                if GetMouseFocus() == Uibutton then
                    TRP3_API.ui.tooltip.refresh(Uibutton)
                end
            end,
            onModelUpdate = function(buttonStructure)
                -- Instead of checking getConfigValue() and setting each buttonStructure element every 0.5
                -- seconds we for config handler event to throw then check/set new values appropriately.
                if location_setting_updated then
                    if getConfigValue('register_map_location') then
                        buttonStructure.tooltip = tooltip_loc_shown
                        buttonStructure.icon = visibleIcon
                    else
                        buttonStructure.tooltip = tooltip_loc_hidden
                        buttonStructure.icon = hiddenIcon
                    end
                    location_setting_updated = false
                end
            end,
            onClick = function(Uibutton, buttonStructure, button)
                if getConfigValue('register_map_location') then
                    setConfigValue('register_map_location', false)
                    buttonStructure.toolbar = tooltip_loc_hidden
                    buttonStructure.icon = hiddenIcon
                else
                    setConfigValue('register_map_location', true)
                    buttonStructure.toolbar = tooltip_loc_shown
                    buttonStructure.icon = visibleIcon
                end
                TRP3_API.configuration.refreshPage(TRP3_API.register.CONFIG_STRUCTURE.id)
            end,
        }

    end)

    TRP3_API.RegisterCallback(TRP3_Addon, TRP3_Addon.Events.WORKFLOW_ON_FINISH, function()
        -- As of TRP 1.5.0 'register_map_location' isn't always loaded until after we're initialized
        registerConfigHandler({'register_map_location'}, function()
            location_setting_updated = true
        end)
        location_setting_updated = true
    end)

end

-- Module Registration
TRP3_API.module.registerModule({
    ["name"] = "Location Toggle",
    ["description"] = "Adds a toolbar button to quickly enable/disable map location.",
    ["version"] = 1.13,
    ["id"] = "trp_location_toggle",
    ["onStart"] = onStart,
    ["minVersion"] = 3,
})
