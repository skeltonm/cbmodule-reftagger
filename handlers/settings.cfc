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
			["Default", ""],
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

		this.createJs(existingSettings);

		getInstance("MessageBox@cbmessagebox").info("Settings Saved & Updated!");
		setNextEvent("reftagger.settings");
	}

	private function createJs(settings) {
		var s = arguments.settings;

		var js = "var refTagger={
			settings:{
				addLogosLink:@logosIntegration.addLogosButtonToTooltips@,
				bibleReader:'@bibleOptions.onlineBibleReader@',
				bibleVersion:'@bibleOptions.bibleTranslation@',
				caseInsensitive:@advancedOptions.caseInsensitive@,
				convertHyperlinks:@advancedOptions.enableReftaggerOnExistingBibliaLinks@,
				dropShadow:@additionalStyling.dropShadow@,
				linksOpenNewWindow:@advancedOptions.openBibleInNewWindow@,
				logosLinkIcon:'@logosIntegration.theme@',
				noSearchClassNames:[@excludeContent.tagsToExclude@],
				noSearchTagNames:[@excludeContent.classesToExclude@],
				roundCorners:@additionalStyling.roundedCorners@,
				socialSharing:[@socialSharing@],
				tooltipStyle:'@bodyStyle.background@',
				useTooltip:@advancedOptions.showTooltipOnHover@,
				tagChapters:@advancedOptions.chapterLevelTagging@,
				customStyle:{
					heading:{
						backgroundColor:'@headingStyle.background@',
						color:'@headingStyle.fontColor@',
						fontFamily:'@headingStyle.fontFamily@',
						fontSize:'@headingStyle.fontSize@'
					},
					body:{
						color:'@bodyStyle.fontColor@',
						fontFamily:'@bodyStyle.fontFamily@',
						fontSize:'@bodyStyle.fontSize@',
						moreLink:{
							color:'@bodyStyle.linkColor@'
						}
					}
				}
			}
		};(function(d,t){
			var g=d.createElement(t),
				s=d.getElementsByTagName(t)[0];
				g.src='//api.reftagger.com/v2/RefTagger.js';
				s.parentNode.insertBefore(g,s);
		}(document,'script'));";

		var socialSharing = "";
		var tagsToExclude = replace(s.excludeContent.tagsToExclude, ",", "','", "all");
		var classesToExclude = replace(s.excludeContent.classesToExclude, ",", "','", "all");

		if (tagsToExclude neq "") { tagsToExclude = "'" & tagsToExclude & "'"; }
		if (classesToExclude neq "") { classesToExclude = "'" & classesToExclude & "'"; }

		if (s.socialShare.twitter) { socialSharing &= "'twitter',"; }
		if (s.socialShare.facebook) { socialSharing &= "'facebook',"; }
		if (s.socialShare.googlePlus) { socialSharing &= "'google',"; }
		if (s.socialShare.faithlife) { socialSharing &= "'faithlife',"; }

		// font color defaults
		if (s.headingStyle.background eq "") { s.headingStyle.background = "##e7e7e7"; }
		if (s.headingStyle.fontColor eq "") { s.headingStyle.fontColor = "##333"; }
		if (s.bodyStyle.fontColor eq "") { s.bodyStyle.fontColor = "##666"; }
		if (s.bodyStyle.linkColor eq "") { s.bodyStyle.linkColor = "##0080FF"; }

		// escape quotes in font family
		s.headingStyle.fontFamily = replace(s.headingStyle.fontFamily, "'", "\'", "all");
		s.bodyStyle.fontFamily = replace(s.bodyStyle.fontFamily, "'", "\'", "all");

		js = replace(js, "@logosIntegration.addLogosButtonToTooltips@", s.logosIntegration.addLogosButtonToTooltips);
		js = replace(js, "@bibleOptions.onlineBibleReader@", s.bibleOptions.onlineBibleReader);
		js = replace(js, "@bibleOptions.bibleTranslation@", s.bibleOptions.bibleTranslation);
		js = replace(js, "@advancedOptions.caseInsensitive@", s.advancedOptions.caseInsensitive);
		js = replace(js, "@advancedOptions.enableReftaggerOnExistingBibliaLinks@", s.advancedOptions.enableReftaggerOnExistingBibliaLinks);
		js = replace(js, "@additionalStyling.dropShadow@", s.additionalStyling.dropShadow);
		js = replace(js, "@advancedOptions.openBibleInNewWindow@", s.advancedOptions.openBibleInNewWindow);
		js = replace(js, "@logosIntegration.theme@", s.logosIntegration.theme);
		js = replace(js, "@excludeContent.tagsToExclude@", tagsToExclude);
		js = replace(js, "@excludeContent.classesToExclude@", classesToExclude);
		js = replace(js, "@additionalStyling.roundedCorners@", s.additionalStyling.roundedCorners);
		js = replace(js, "@socialSharing@", socialSharing);
		js = replace(js, "@bodyStyle.background@", s.bodyStyle.background);
		js = replace(js, "@advancedOptions.showTooltipOnHover@", s.advancedOptions.showTooltipOnHover);
		js = replace(js, "@advancedOptions.chapterLevelTagging@", s.advancedOptions.chapterLevelTagging);
		js = replace(js, "@headingStyle.background@", s.headingStyle.background);
		js = replace(js, "@headingStyle.fontColor@", s.headingStyle.fontColor);
		js = replace(js, "@headingStyle.fontFamily@", s.headingStyle.fontFamily);
		js = replace(js, "@headingStyle.fontSize@", s.headingStyle.fontSize);
		js = replace(js, "@bodyStyle.fontColor@", s.bodyStyle.fontColor);
		js = replace(js, "@bodyStyle.fontFamily@", s.bodyStyle.fontFamily);
		js = replace(js, "@bodyStyle.fontSize@", s.bodyStyle.fontSize);
		js = replace(js, "@bodyStyle.linkColor@", s.bodyStyle.linkColor);

		writeJsToDisk(js);
	}

	private function writeJsToDisk(js) {
		arguments.js = replace(arguments.js, chr(9), "", "all");
		arguments.js = replace(arguments.js, chr(10), "", "all");
		arguments.js &= chr(10);

		fileWrite(getSetting("modules")["cbmodule-reftagger"].path & "/includes/js/reftagger.min.js", arguments.js);
	}
}
