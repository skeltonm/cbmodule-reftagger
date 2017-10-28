/**
********************************************************************************
Copyright 2017 Full Calendar by Mark Skelton and Computer Know How, LLC
compknowhow.com
********************************************************************************

Author:  Mark Skelton
Description:  I handle the setting events
*/
component extends="base" {
	property name="settingService" 	inject="settingService@cb";
	property name="cb" 				inject="cbHelper@cb";

	function index(event,rc,prc){
		prc.settings = deserializeJSON(settingService.getSetting("reftagger"));

		prc.fontFamilyOptions = [
			["Default font", ""],
			["Arial", "Arial, 'Helvetica Neue', Helvetica, sans-serif"],
			["Courier New", "'Courier New', Courier, 'Lucida Sans Typewriter', 'Lucida Typewriter', monospace"],
			["Georgia", "Georgia, Times, 'Times New Roman', serif"],
			["Palantino", "Palatino, 'Palatino Linotype', 'Palatino LT STD', 'Book Antiqua', Georgia, serif"],
			["Tahoma", "Tahoma, Verdana, Segoe, sans-serif"],
			["Times New Roman", "TimesNewRoman, 'Times New Roman', Times, Baskerville, Georgia, serif"],
			["Verdana", "Verdana, Geneva, sans-serif"]
		];

		prc.bibleTranslationOptions = [
			["American Standard Version (ASV)", "ASV"],
			["English Standard Version (ESV)", "ESV"],
			["King James Version (KJV)", "KJV"],
			["New American Standard Bible (NASB)", "NASB"],
			["New International Version (NIV)", "NIV"],
			["New King James Version (NKJV)", "NKJV"]
		];

		event.setView("settings/index");
	}

	function saveSettings(event,rc,prc){
		var incomingSettings = "";
		var newSettings = {};

		var oSetting = settingService.findWhere({name="reftagger"});

		if(structKeyExists(rc,"googleCalendarApiKey")) {
			var incomingSettings = serializeJSON(
				{
					"googleCalendarApiKey" = rc.googleCalendarApiKey,
					"openGCalEvents" = structKeyExists(rc, "openGCalEvents") ? true : false,
					"newTab" = structKeyExists(rc, "newTab") ? true : false
				}
			);
		}

		if(structKeyExists(rc,"nextPrevButtons")) {
			var incomingSettings = serializeJSON(
				{
					"nextPrevButtons" = structKeyExists(rc, "nextPrevButtons") ? true : false,
					"todayButton" = structKeyExists(rc, "todayButton") ? true : false,
					"dateButton" = structKeyExists(rc, "dateButton") ? true : false,
					"monthButton" = structKeyExists(rc, "monthButton") ? true : false,
					"weekButton" = structKeyExists(rc, "weekButton") ? true : false,
					"dayButton" = structKeyExists(rc, "dayButton") ? true : false,
					"agendaButton" = structKeyExists(rc, "agendaButton") ? true : false,
					"refreshButton" = structKeyExists(rc, "refreshButton") ? true : false,

					"defaultView" = rc.defaultView,
					"showLegend" = structKeyExists(rc, "showLegend") ? true : false,
					"nowIndicator" = structKeyExists(rc, "nowIndicator") ? true : false,

					"navLinks" = structKeyExists(rc, "navLinks") ? true : false,
					"useTooltips" = structKeyExists(rc, "useTooltips") ? true : false,
					"includeJquery" = structKeyExists(rc, "includeJquery") ? true : false,
					"hideJqueryAlert" = structKeyExists(rc, "hideJqueryAlert") ? true : false
				}
			);
		}

		if(structKeyExists(rc,"eventColor")) {
			var incomingSettings = serializeJSON(
				{
					"eventColor" = rc.eventColor,
					"eventTextColor" = rc.eventTextColor
				}
			);
		}

		var newSettings = deserializeJSON(incomingSettings);

		var existingSettings = deserializeJSON(oSetting.getValue());

		// Append the new settings sent in to the existing settings (overwrite)
		structAppend(existingSettings, newSettings);

		oSetting.setValue(serializeJSON(existingSettings));
		settingService.save(oSetting);

		// Flush the settings cache so our new settings are reflected
		settingService.flushSettingsCache();

		getInstance("MessageBox@cbmessagebox").info("Settings Saved & Updated!");
		cb.setNextModuleEvent("reftagger","settings");
	}
}