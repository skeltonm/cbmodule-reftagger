/**
********************************************************************************
Copyright 2017 Regtagger by Mark Skelton and Computer Know How, LLC
ggacres.org
compknowhow.com
********************************************************************************

Author:  Mark Skelton
Description:  Base handler for the Regtagger module
*/
component{
	property name="settingService" inject="id:settingService@cb";

	// pre handler
	function preHandler() {
		// get module root
		prc.moduleRoot = event.getModuleRoot("cbmodule-reftagger");

		//check login and redirect is needed.
		if(!prc.oCurrentAuthor.isLoaded()){
			getInstance("MessageBox@cbmessagebox").setMessage("warning", "Please login!");
			setNextEvent(prc.xehLogin);
		}

		// use the CB admin layout
		event.setLayout(name="admin", module="contentbox-admin");
	}
}
