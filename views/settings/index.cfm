<cfoutput>
	#renderView( "viewlets/assets" )#
	<!--============================Main Column============================-->
	<div class="row">
		<div class="col-md-12">
			<h1 class="h1">
				<i class="fa fa-gear"></i> Reftagger Global Settings
			</h1>
		</div>
	</div>

	<div class="row">
		<div class="col-md-12">
			<div class="panel panel-default">
				<div class="panel-body">
					#getInstance("MessageBox@cbmessagebox").renderit()#

					<div class="tabbable tabs-left">
						<ul class="nav nav-tabs">
							<li class="active">
								<a href="##basicCustomization" data-toggle="tab">
									<i class="fa fa-calendar"></i>
									Basic Customization
								</a>
							</li>
						</ul>

						<div class="tab-content">
							<!--- Settings: Basic Customization --->
							<form action="/reftagger/settings/saveSettings" method="POST">
								<div class="tab-pane active" id="basicCustomization">
									<div class="row">
										<div class="col-md-6">
											<fieldset>
												<legend>Heading Style</legend>

												<div class="form-group">
													<label for="headingStyle.fontColor">Font Color:</label>
													<input type="text"
														name="headingStyle.fontColor"
														value="#prc.settings.headingStyle.fontColor#"
														class="form-control jscolor {required:false, hash: true}">
												</div>

												<div class="form-group">
													<label for="headingStyle.fontFamily">Font Family:</label>
													<select name="headingStyle.fontFamily" class="form-control">
														<cfloop array="#prc.fontFamilyOptions#" index="option">
															<option value="#option[2]#"<cfif option[2] eq prc.settings.headingStyle.fontFamily> selected</cfif>>
																#option[1]#
															</option>
														</cfloop>
													</select>
												</div>

												<div class="form-group">
													<label for="headingStyle.fontSize">Font Size (px):</label>
													<input type="number"
														name="headingStyle.fontSize"
														value="#prc.settings.headingStyle.fontSize#"
														class="form-control">
												</div>

												<div class="form-group">
													<label for="headingStyle.background">Background:</label>
													<input type="text"
														name="headingStyle.background"
														value="#prc.settings.headingStyle.background#"
														class="form-control jscolor {required:false, hash: true}">
												</div>
											</fieldset>

											<fieldset>
												<legend>Body Style</legend>

												<div class="form-group">
													<label for="bodyStyle.fontColor">Font Color:</label>
													<input type="text"
														name="bodyStyle.fontColor"
														value="#prc.settings.bodyStyle.fontColor#"
														class="form-control jscolor {required:false, hash: true}">
												</div>

												<div class="form-group">
													<label for="bodyStyle.fontFamily">Font Family:</label>
													<select name="bodyStyle.fontFamily" class="form-control">
														<cfloop array="#prc.fontFamilyOptions#" index="option">
															<option value="#option[2]#"<cfif option[2] eq prc.settings.bodyStyle.fontFamily> selected</cfif>>
																#option[1]#
															</option>
														</cfloop>
													</select>
												</div>

												<div class="form-group">
													<label for="bodyStyle.fontSize">Font Size (px):</label>
													<input type="number"
														name="bodyStyle.fontSize"
														value="#prc.settings.bodyStyle.fontSize#"
														class="form-control">
												</div>

												<div class="form-group">
													<label for="bodyStyle.background">Background:</label>
													<input type="text"
														name="bodyStyle.background"
														value="#prc.settings.bodyStyle.background#"
														class="form-control jscolor {required:false, hash: true}">
												</div>
											</fieldset>
										</div>

										<div class="col-md-6">
											<fieldset>
												<legend>Bible Options</legend>

												<div class="form-group">
													<label for="bibleOptions.bibleTranslation">Bible Translation:</label>
													<select name="bibleOptions.bibleTranslation" class="form-control">
														<cfloop array="#prc.bibleTranslationOptions#" index="option">
															<option value="#option[2]#"<cfif option[2] eq prc.settings.bibleOptions.bibleTranslation> selected</cfif>>
																#option[1]#
															</option>
														</cfloop>
													</select>
												</div>
											</fieldset>
										</div>
									</div>
								</div>

								<div class="form-actions">
									<button type="submit" class="btn btn-danger">Save Settings</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</cfoutput>
