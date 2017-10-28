/*
********************************************************************************
Copyright 2017 Reftagger by Mark Skelton and Computer Know How, LLC
compknowhow.com
********************************************************************************

Author:  Mark Skelton
Description:  Intercepts the cbui_beforeHeadEnd ContentBox event to insert the required js to make Reftagger work
*/
component extends="coldbox.system.Interceptor" {
	property name="settingService" inject="id:settingService@cb";

	// include the necessary js at the head of the page
	function cbui_beforeHeadEnd(event, struct interceptData) {
		js = "<script>
	var refTagger = {
		settings: {
			addLogosLink: true,
			bibleReader: 'bible.faithlife',
			bibleVersion: 'MESSAGE',
			caseInsensitive: !false,
			convertHyperlinks: true,
			dropShadow: false,
			linksOpenNewWindow: false,
			logosLinkIcon: 'dark',
			noSearchClassNames: ['class'],
			noSearchTagNames: ['h1','h2'],
			roundCorners: true,
			socialSharing: ['twitter','google'],
			tooltipStyle: 'dark',
			useTooltip: false,
			tagChapters: true,
			customStyle : {
				heading: {
					backgroundColor : '##c9daf8',
					color : '##6fa8dc',
					fontFamily : 'TimesNewRoman, \'Times New Roman\', Times, Baskerville, Georgia, serif',
					fontSize : '16px'
				},
				body   : {
					color : '##434343',
					fontFamily : 'Verdana, Geneva, sans-serif',
					fontSize : '18px',
					moreLink : {
						color: '##ffe599'
					}
				}
			}
		}
	};
	(function(d, t) {
		var g = d.createElement(t), s = d.getElementsByTagName(t)[0];
		g.src = '//api.reftagger.com/v2/RefTagger.js';
		s.parentNode.insertBefore(g, s);
	}(document, 'script'));
</script>"
		appendToBuffer(js);
	}
}