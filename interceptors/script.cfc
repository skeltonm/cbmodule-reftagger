/*
********************************************************************************
Copyright 2017 Reftagger by Mark Skelton and Computer Know How, LLC
compknowhow.com
********************************************************************************

Author:  Mark Skelton
Description:  Intercepts the cbui_beforeHeadEnd ContentBox event to insert the required js to make Reftagger work
*/
component extends="coldbox.system.Interceptor" {
	// include the necessary js at the head of the page
	function cbui_beforeHeadEnd(event, struct interceptData) {
		var scriptLocation = event.getModuleRoot("cbmodule-reftagger") & "/includes/js/reftagger.min.js";

		appendToBuffer("<script src=""#scriptLocation#""></script>");
	}
}
