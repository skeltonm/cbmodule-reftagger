/**
********************************************************************************
Copyright 2017 Reftagger by Mark Skelton and Computer Know How, LLC
compknowhow.com
********************************************************************************

Author:  Mark Skelton
Description:  Creates Reftagger calendars
*/
component {
	// Module Properties
	this.title = "Reftagger";
	this.author = "Computer Know How, LLC";
	this.webURL = "https://compknowhow.com";
	this.description = "Creates tooltips on all Scripture references found on your website.";
	this.version = "1.0";
	// If true, looks for views in the parent first, if not found, then in the module. Else vice-versa
	this.viewParentLookup = true;
	// If true, looks for layouts in the parent first, if not found, then in module. Else vice-versa
	this.layoutParentLookup = true;
	// Module Entry Point
	this.entryPoint = "reftagger";

	function configure(){
		// Reftagger global settings
		settings = {
			headingStyle = {
				fontColor = "",
				fontFamily = "",
				fontSize = "",
				background = ""
			},
			bodyStyle = {
				fontColor = "",
				fontFamily = "",
				fontSize = "",
				background = "",
				linkColor = ""
			},
			bibleOptions = {
				bibleTranslation = "ESV",
				onlineBibleReader = ""
			},
			additionalStyling = {
				dropShadows = true,
				roundedCorners = false
			},
			socialShare = {
				twitter = true,
				facebook = true,
				googlePlus = true,
				faithlife = true
			},
			excludeContent = {
				tagsToExclude = "",
				classesToExclude = ""
			},
			logosIntegration = {
				addLogosButtonToTooltips = false,
				logosButtonTheme = ""
			},
			advancedOptions = {
				showTooltipOnHover = true,
				openBibleInNewWindow = true,
				caseSensitivity = true,
				enableReftaggerOnExistingBibliaLinks = false,
				chapterLevelTagging = false
			}
		};

		// SES Routes
		routes = [
			// Convention Route
			{pattern="/:handler/:action?"}
		];

		// Interceptors
		interceptors = [
			// { class="#moduleMapping#.interceptors.includes", name="includes@reftagger" },
			{ class="#moduleMapping#.interceptors.request", properties={ entryPoint="cbadmin" }, name="request@reftagger" }
		];
	}

	/**
	* Fired when the module is registered and activated.
	*/
	function onLoad(){
		var menuService = controller.getWireBox().getInstance("AdminMenuService@cb");
		var settingService = controller.getWireBox().getInstance("SettingService@cb");

		// Add menu contribution
		menuService.addSubMenu(topMenu=menuService.MODULES,
			name="reftagger",
			label="Reftagger",
			href="reftagger/settings");

		// Flush the settings cache so our new settings are reflected
		settingService.flushSettingsCache();
	}

	/**
	* Fired when the module is activated by ContentBox
	*/
	function onActivate(){
		var settingService = controller.getWireBox().getInstance("SettingService@cb");

		// Store default settings
		var findArgs = { name="reftagger" };
		var setting = settingService.findWhere(criteria=findArgs);

		if(isNull(setting)){
			var args = { name="reftagger", value=serializeJSON(settings) };
			var reftaggerSettings = settingService.new(properties=args);
			settingService.save(reftaggerSettings);
		}

		// Flush the settings cache so our new settings are reflected
		settingService.flushSettingsCache();
	}

	/**
	* Fired when the module is unregistered and unloaded
	*/
	function onUnload(){
		var settingService = controller.getWireBox().getInstance("SettingService@cb");
		var menuService = controller.getWireBox().getInstance("AdminMenuService@cb");

		// Remove menu contribution
		menuService.removeSubMenu(topMenu=menuService.MODULES, name="reftagger");
	}

	/**
	* Fired when the module is deactivated by ContentBox
	*/
	function onDeactivate(){
		var settingService = controller.getWireBox().getInstance("SettingService@cb");

		var args = { name="reftagger" };
		var setting = settingService.findWhere(criteria=args);

		if(!isNull(setting)){
			settingService.delete(setting);
		}

		// Flush the settings cache so our new settings are reflected
		settingService.flushSettingsCache();
	}
}
