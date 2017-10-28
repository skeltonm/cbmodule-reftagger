<cfoutput>
	<style>
		.no-margin-top {
			margin-top: 0;
		}
	</style>

	<script src="//cdnjs.cloudflare.com/ajax/libs/jscolor/2.0.4/jscolor.min.js"></script>

	<form action="/reftagger/settings/saveSettings" method="POST">
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
									<a href="##basicCustomization" data-toggle="tab">Basic Customization</a>
								</li>

								<li>
									<a href="##advancedSettings" data-toggle="tab">Advanced Settings</a>
								</li>
							</ul>

							<div class="tab-content">
								<div class="tab-pane active" id="basicCustomization">
									<div class="row">
										<div class="col-md-6">
											<fieldset>
												<legend>Heading Style</legend>

												<div class="form-group">
													<label for="headingStyle_fontColor">Font Color <small>(Leave blank for default)</small>:</label>
													<input type="text"
														name="headingStyle_fontColor"
														value="#prc.settings.headingStyle.fontColor#"
														class="form-control jscolor {required:false, hash: true}">
												</div>

												<div class="form-group">
													<label for="headingStyle_fontFamily">Font Family:</label>
													<select name="headingStyle_fontFamily" class="form-control">
														<cfloop array="#prc.fontFamilyOptions#" index="option">
															<option value="#option[2]#"<cfif option[2] eq prc.settings.headingStyle.fontFamily> selected</cfif>>
																#option[1]#
															</option>
														</cfloop>
													</select>
												</div>

												<div class="form-group">
													<label for="headingStyle_fontSize">Font Size (px) <small>(Leave blank for default)</small>:</label>
													<input type="number"
														name="headingStyle_fontSize"
														value="#prc.settings.headingStyle.fontSize#"
														class="form-control">
												</div>

												<div class="form-group">
													<label for="headingStyle_background">Background <small>(Leave blank for default)</small>:</label>
													<input type="text"
														name="headingStyle_background"
														value="#prc.settings.headingStyle.background#"
														class="form-control jscolor {required:false, hash: true}">
												</div>
											</fieldset>

											<fieldset>
												<legend>Body Style</legend>

												<div class="form-group">
													<label for="bodyStyle_fontColor">Font Color <small>(Leave blank for default)</small>:</label>
													<input type="text"
														name="bodyStyle_fontColor"
														value="#prc.settings.bodyStyle.fontColor#"
														class="form-control jscolor {required:false, hash: true}">
												</div>

												<div class="form-group">
													<label for="bodyStyle_fontFamily">Font Family:</label>
													<select name="bodyStyle_fontFamily" class="form-control">
														<cfloop array="#prc.fontFamilyOptions#" index="option">
															<option value="#option[2]#"<cfif option[2] eq prc.settings.bodyStyle.fontFamily> selected</cfif>>
																#option[1]#
															</option>
														</cfloop>
													</select>
												</div>

												<div class="form-group">
													<label for="bodyStyle_fontSize">Font Size (px) <small>(Leave blank for default)</small>:</label>
													<input type="number"
														name="bodyStyle_fontSize"
														value="#prc.settings.bodyStyle.fontSize#"
														class="form-control">
												</div>

												<div class="form-group">
													<label for="bodyStyle_background">Background:</label>

													<div>
														<label class="radio-inline">
															<input type="radio"
																name="bodyStyle_background"
																value="light"<cfif prc.settings.bodyStyle.background eq "light"> checked</cfif>> Light
														</label>

														<label class="radio-inline">
															<input type="radio"
																name="bodyStyle_background"
																value="dark"<cfif prc.settings.bodyStyle.background eq "dark"> checked</cfif>> Dark
														</label>
													</div>
												</div>

												<div class="form-group">
													<label for="bodyStyle_linkColor">Link Color <small>(Leave blank for default)</small>:</label>
													<input type="text"
														name="bodyStyle_linkColor"
														value="#prc.settings.bodyStyle.linkColor#"
														class="form-control jscolor {required:false, hash: true}">
												</div>
											</fieldset>
										</div>

										<div class="col-md-6">
											<fieldset>
												<legend>Bible Options</legend>

												<div class="form-group">
													<label for="bibleOptions_bibleTranslation">Bible Translation:</label>
													<select name="bibleOptions_bibleTranslation" class="form-control">
														<cfloop array="#prc.bibleTranslationOptions#" index="option">
															<option value="#option[2]#"<cfif option[2] eq prc.settings.bibleOptions.bibleTranslation> selected</cfif>>
																#option[1]#
															</option>
														</cfloop>
													</select>
												</div>

												<div class="form-group">
													<label for="bibleOptions_onlineBibleReader">Online Bible Reader:</label>

													<div>
														<label class="radio-inline">
															<input type="radio"
																name="bibleOptions_onlineBibleReader"
																value="bible.biblia"<cfif prc.settings.bibleOptions.onlineBibleReader eq "bible.biblia"> checked</cfif>> Biblia
														</label>

														<label class="radio-inline">
															<input type="radio"
																name="bibleOptions_onlineBibleReader"
																value="bible.faithlife"<cfif prc.settings.bibleOptions.onlineBibleReader eq "bible.faithlife"> checked</cfif>> Faithlife Study Bible
														</label>
													</div>
												</div>
											</fieldset>

											<fieldset>
												<legend>Additional styling:</legend>

												<div class="checkbox no-margin-top">
													<label>
														<input type="checkbox" name="additionalStyling_dropShadow"<cfif prc.settings.additionalStyling.dropShadow> checked</cfif>> Drop shadow
													</label>
												</div>

												<div class="checkbox">
													<label>
														<input type="checkbox" name="additionalStyling_roundedCorners"<cfif prc.settings.additionalStyling.roundedCorners> checked</cfif>> Rounded corners
													</label>
												</div>
											</fieldset>

											<fieldset>
												<legend>Social share:</legend>

												<div class="checkbox no-margin-top">
													<label>
														<input type="checkbox"
															name="socialShare_twitter"
															<cfif prc.settings.socialShare.twitter> checked</cfif>> Twitter
													</label>
												</div>

												<div class="checkbox">
													<label>
														<input type="checkbox"
															name="socialShare_facebook"
															<cfif prc.settings.socialShare.facebook> checked</cfif>> Facebook
													</label>
												</div>

												<div class="checkbox no-margin-top">
													<label>
														<input type="checkbox"
															name="socialShare_googlePlus"
															<cfif prc.settings.socialShare.googlePlus> checked</cfif>> Google+
													</label>
												</div>

												<div class="checkbox">
													<label>
														<input type="checkbox"
															name="socialShare_faithlife"
															<cfif prc.settings.socialShare.faithlife> checked</cfif>> Faithlife
													</label>
												</div>
											</fieldset>
										</div>
									</div>
								</div>

								<div class="tab-pane" id="advancedSettings">
									<div class="row">
										<div class="col-md-6">
											<fieldset>
												<legend>Exclude Content</legend>

												<div class="form-group">
													<label for="excludeContent_tagsToExclude">Tags to exclude:</label>
													<input type="text"
														name="excludeContent_tagsToExclude"
														value="#prc.settings.excludeContent.tagsToExclude#"
														class="form-control">
												</div>

												<div class="form-group">
													<label for="excludeContent_classesToExclude">Classes to exclude:</label>
													<input type="text"
														name="excludeContent_classesToExclude"
														value="#prc.settings.excludeContent.classesToExclude#"
														class="form-control">
												</div>
											</fieldset>

											<fieldset>
												<legend>Logos Integration</legend>

												<div class="checkbox no-margin-top">
													<label>
														<input type="checkbox"
															name="logosIntegration_addLogosButtonToTooltips"
															<cfif prc.settings.logosIntegration.addLogosButtonToTooltips> checked</cfif>> Add Logos buttons to tooltip
													</label>
												</div>

												<div class="form-group">
													<label for="logosIntegration_theme">Logos button theme:</label>

													<div>
														<label class="radio-inline">
															<input type="radio"
																name="logosIntegration_theme"
																value="light"
																<cfif prc.settings.logosIntegration.theme eq "light"> checked</cfif>> Light
														</label>

														<label class="radio-inline">
															<input type="radio"
																name="logosIntegration_theme"
																value="dark"
																<cfif prc.settings.logosIntegration.theme eq "dark"> checked</cfif>> Dark
														</label>
													</div>
												</div>
											</fieldset>
										</div>

										<div class="col-md-6">
											<fieldset>
												<legend>Advanced options</legend>

												<div class="checkbox">
													<label>
														<input type="checkbox"
															name="advancedOptions_showTooltipOnHover"
															<cfif prc.settings.advancedOptions.showTooltipOnHover> checked</cfif>> Show tooltip on hover
													</label>
												</div>

												<div class="checkbox">
													<label>
														<input type="checkbox"
															name="advancedOptions_openBibleInNewWindow"
															<cfif prc.settings.advancedOptions.openBibleInNewWindow> checked</cfif>> Open Bible in new window
													</label>
												</div>

												<div class="checkbox">
													<label>
														<input type="checkbox"
															name="advancedOptions_caseInsensitive"
															<cfif prc.settings.advancedOptions.caseInsensitive> checked</cfif>> Case insensitive
													</label>
												</div>

												<div class="checkbox">
													<label>
														<input type="checkbox"
															name="advancedOptions_enableReftaggerOnExistingBibliaLinks"
															<cfif prc.settings.advancedOptions.enableReftaggerOnExistingBibliaLinks> checked</cfif>> Enable Reftagger on existing Biblia links
													</label>
												</div>

												<div class="checkbox">
													<label>
														<input type="checkbox"
															name="advancedOptions_chapterLevelTagging"
															<cfif prc.settings.advancedOptions.chapterLevelTagging> checked</cfif>> Chapter-level tagging
													</label>
												</div>
											</fieldset>
										</div>
									</div>
								</div>

								<div class="form-actions">
									<button type="submit" class="btn btn-danger">Save Settings</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
</cfoutput>
