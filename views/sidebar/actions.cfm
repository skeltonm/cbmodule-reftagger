﻿<cfoutput>
	<div class="panel panel-primary">
		<!--- Info Box --->
		<div class="panel-heading">
			<h3 class="panel-title">
				<i class="fa fa-cogs"></i> Actions
			</h3>
		</div>
		<div class="panel-body">
			<!--- Forms --->
			<button class="btn btn-danger" style="margin-right: 5px" onclick="return to('#event.buildLink(prc.xehCalendars)#')">Calendars</button>
			<button class="btn btn-default" style="margin-right: 5px" onclick="return to('#event.buildLink('cbadmin.module.fullCalendar.settings.index')#')">Settings</button>
			<button class="btn btn-default" onclick="return to('#event.buildLink('cbadmin.module.fullCalendar.help.index')#')">Help</button>
		</div>
	</div>
</cfoutput>