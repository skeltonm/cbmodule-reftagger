/**
********************************************************************************
Copyright 2017 Reftagger by Mark Skelton and Computer Know How, LLC
ggacres.org
compknowhow.com
********************************************************************************

Author:  Mark Skelton
Description:  I handle the setting events
*/
component extends="base" {
	property name="settingService" inject="settingService@cb";
	property name="cb" inject="cbHelper@cb";

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
		var oSetting = settingService.findWhere({ name="reftagger" });

		var incomingSettings = {
			headingStyle = {
				fontColor = rc.headingStyle_fontColor,
				fontFamily = rc.headingStyle_fontFamily,
				fontSize = rc.headingStyle_fontSize,
				background = rc.headingStyle_background
			},
			bodyStyle = {
				fontColor = rc.bodyStyle_fontColor,
				fontFamily = rc.bodyStyle_fontFamily,
				fontSize = rc.bodyStyle_fontSize,
				background = rc.bodyStyle_background,
				linkColor = rc.bodyStyle_linkColor
			},
			bibleOptions = {
				bibleTranslation = rc.bibleOptions_bibleTranslation,
				onlineBibleReader = rc.bibleOptions_onlineBibleReader
			},
			additionalStyling = {
				dropShadow = structKeyExists(rc, "additionalStyling_dropShadow"),
				roundedCorners = structKeyExists(rc, "additionalStyling_roundedCorners")
			},
			socialShare = {
				twitter = structKeyExists(rc, "socialShare_twitter"),
				facebook = structKeyExists(rc, "socialShare_facebook"),
				googlePlus = structKeyExists(rc, "socialShare_googlePlus"),
				faithlife = structKeyExists(rc, "socialShare_faithlife")
			},
			excludeContent = {
				tagsToExclude = rc.excludeContent_tagsToExclude,
				classesToExclude = rc.excludeContent_classesToExclude
			},
			logosIntegration = {
				addLogosButtonToTooltips = structKeyExists(rc, "logosIntegration_addLogosButtonToTooltips"),
				theme = rc.logosIntegration_theme
			},
			advancedOptions = {
				showTooltipOnHover = structKeyExists(rc, "advancedOptions_showTooltipOnHover"),
				openBibleInNewWindow = structKeyExists(rc, "advancedOptions_openBibleInNewWindow"),
				caseInsensitive = structKeyExists(rc, "advancedOptions_caseInsensitive"),
				enableReftaggerOnExistingBibliaLinks = structKeyExists(rc, "advancedOptions_enableReftaggerOnExistingBibliaLinks"),
				chapterLevelTagging = structKeyExists(rc, "advancedOptions_chapterLevelTagging")
			}
		}

		var existingSettings = deserializeJSON(oSetting.getValue());

		// Append the new settings sent in to the existing settings (overwrite)
		structAppend(existingSettings, incomingSettings);

		oSetting.setValue(serializeJSON(existingSettings));
		settingService.save(oSetting);

		// Flush the settings cache so our new settings are reflected
		settingService.flushSettingsCache();

		getInstance("MessageBox@cbmessagebox").info("Settings Saved & Updated!");
		setNextEvent("reftagger.settings");
	}
}
