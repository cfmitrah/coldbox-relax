<cfoutput>
<div id="FileBrowser">
	#html.startForm(name="filebrowser")#
	<div id="container">
		
		<!--- Roots 
		<div style="float:right;margin-right:3px">
			<strong>Volumes:</strong>
			<select name="roots" id="roots" onChange="javascript:doEventNOUI('#rc.xehBrowser#','FileBrowser',{computerRoot:this.value})" style="width:50px">
				<cfloop from="1" to="#arrayLen(rc.roots)#" index="i">
				<option value="#urlEncodedFormat(rc.roots[i].getAbsolutePath())#" <cfif rc.roots[i].getAbsolutePath() eq rc.computerRoot>selected=selected</cfif>>#rc.roots[i].getAbsolutePath()#</option>
				</cfloop>
			</select>
		</div>
		--->
		
		<!--- Your Current Location --->
		<div id="titleBar">
			#announceInterception("preTitleBar")#
			<div id="title">#prc.settings.title#</div>
			<!--- Refresh --->
			<a href="javascript:fbRefresh()" title="Refresh Listing"><img src="#prc.modRoot#/includes/images/arrow_refresh.png"  border="0"></a>&nbsp;&nbsp;
			<!--- Home --->
			<a href="javascript:fbDrilldown()" title="Go Home"><img src="#prc.modRoot#/includes/images/home.png"  border="0"></a>&nbsp;&nbsp;
			<!--- New Folder --->
			<cfif prc.settings.createFolders>
			<a href="javascript:fbNewFolder()" title="Create Folder"><img src="#prc.modRoot#/includes/images/folder_new.png" border="0"></a>&nbsp;&nbsp;
			</cfif>
			<!--- Delete --->
			<cfif prc.settings.deleteStuff>
			<a href="javascript:fbDelete()" title="Delete File-Folder"><img src="#prc.modRoot#/includes/images/cancel.png"  border="0"></a>&nbsp;&nbsp;
			</cfif>
			<!--- Upload --->
			<a href="javascript:fbDrilldown()" title="Upload"><img src="#prc.modRoot#/includes/images/upload.png"  border="0"></a>&nbsp;&nbsp;
			<cfif prc.settings.allowDownload>
			<!--- Download --->
			<a href="javascript:fbDownload()" title="Download File"><img src="#prc.modRoot#/includes/images/download.png"  border="0"></a>&nbsp;
			</cfif>
			#announceInterception("postTitleBar")#
		</div>
		
		
		<!--- Show the File Listing --->
		<div id="fileListing">
			#announceInterception("preFileListing")#
		    <!--- Messagebox --->
		    #getPlugin("MessageBox").renderit()#
		    
		    <!--- Display back links --->
			<cfif prc.currentRoot NEQ prc.dirRoot>
				<a href="javascript:fbDrilldown('#$getBackPath(prc.currentRoot)#')" title="Go Back"><img src="#prc.modRoot#/includes/images/folder.png" border="0"  alt="Folder"></a>
				<a href="javascript:fbDrilldown('#$getBackPath(prc.currentRoot)#')" title="Go Back">..</a><br>
			</cfif>
			
			<!--- Display directories --->
			<cfif prc.qListing.recordcount>
			<cfloop query="prc.qListing">
				
				<!--- Check Name Filter --->
				<cfif NOT reFindNoCase(prc.settings.nameFilter, prc.qListing.name)> <cfcontinue> </cfif>
				
				<!--- ID Name of the div --->
				<cfset validIDName = $validIDName( prc.qListing.name ) >
				<!--- URL used for selection --->
				<cfset plainURL = prc.currentroot & "/" & prc.qListing.name>
					
				<!--- Directory or File --->
				<cfif prc.qListing.type eq "Dir">
					<!--- Folder --->
					<div id="#validIDName#" 
						 onClick="fbSelect('#validIDName#','#JSStringFormat(plainURL)#')" 
						 class="folders"
						 data-type="dir"
						 onDblclick="fbDrilldown('#JSStringFormat(plainURL)#')">
						<a href="javascript:fbDrilldown('#JSStringFormat(plainURL)#')"><img src="#prc.modRoot#/includes/images/folder.png" border="0"  alt="Folder"></a>
						#prc.qListing.name#
					</div>
				<cfelseif prc.settings.showFiles>
					<!--- Display the DiV --->
					<div id="#validIDName#" 
						 class="files"
						 data-type="file"
						 onClick="fbSelect('#validIDName#','#JSStringFormat(plainURL)#')">
						<img src="#prc.modRoot#/includes/images/file.png" border="0"  alt="file">
						#prc.qListing.name#
					</div>
				</cfif>
			</cfloop>
			<cfelse>
			<em>Empty Directory.</em>
			</cfif>		
			#announceInterception("postFileListing")#	
		</div> <!--- end fileListing --->
		
		<!--- Location Bar --->
		<div id="locationBar">
			#announceInterception("preLocationBar")#
			#replace(prc.currentroot,"/",'<img class="divider" src="#prc.modRoot#/includes/images/bullet_go.png" alt="arrow" />&nbsp;',"all")#
			#announceInterception("postLocationBar")#
		</div>
	
		<!--- The Bottom Bar --->
		<div class="bottomBar">
			#announceInterception("preBottomBar")#
			<!--- Loader Bar --->
			<div id="loaderBar">
				<img src="#prc.modRoot#/includes/images/ajax-loader.gif" />
			</div>
			
			<!--- Download IFrame --->
			<cfif prc.settings.allowDownload>
			<iframe id="downloadIFrame" src="" style="display:none; visibility:hidden;"></iframe>
			</cfif>
			
			<!--- Selected Item & Type --->
			<input type="hidden" name="selectedItem" id="selectedItem" value="">
			<input type="hidden" name="selectedItemType" id="selectedItemType" value="file">
			
			<!--- Cancel Button --->
			<cfif len(rc.cancelCallback)>
				<input type="button" id="bt_cancel" value="Cancel" onClick="#rc.cancelCallback#()"> &nbsp;
			</cfif>
			
			<!--- Select Item --->
			<cfif len(rc.callback)>
			<input type="button" id="bt_select"  value="Choose" onClick="fbChoose()" disabled="true" title="Choose selected file/directory">
			</cfif>
			#announceInterception("postBottomBar")#
		</div>
		
	</div>
	#html.endForm()#
</div>
<!--- Custom Javascript --->
<script language="javascript">
$(document).ready(function() {
	$fileBrowser 		= $("##FileBrowser");
	$fileLoaderBar 		= $("##loaderBar");
	$selectedItem		= $("##selectedItem");
	$selectedItemType	= $("##selectedItemType");
	selectedHistory = "";
	$("##bt_select").attr("disabled",true);
});
function fbRefresh(){
	$fileLoaderBar.slideDown();
	$fileBrowser.parent().load( '#event.buildLink(prc.xehBrowser)#', {path:'#prc.safeCurrentRoot#'},function(){
		$fileLoaderBar.slideUp();
	});
}
function fbDrilldown(inPath){
	if( inPath == null ){ inPath = ""; }
	$fileLoaderBar.slideDown();
	$fileBrowser.parent().load( '#event.buildLink(prc.xehBrowser)#', {path:inPath},function(){
		$fileLoaderBar.slideUp();
	});
}
function fbSelect(sID,sURL){
	// history cleanup
	if (selectedHistory.length) {
		$("##" + selectedHistory).removeClass("selected");
	}
	// highlight selection
	var $sItem = $( "##"+sID );
	$sItem.addClass("selected");
	$selectedItemType.val( $sItem.attr("data-type") );
	// save selection
	$selectedItem.val( sURL );
	// history set
	selectedHistory = sID;
	// enable selection button
	$("##bt_select").attr("disabled",false);
}
<!--- Create Folders --->
<cfif prc.settings.createFolders>
function fbNewFolder(){
	var dName = prompt("Enter the new directory name?");
	if( dName != null){
		$fileLoaderBar.slideDown();
		$.post('#event.buildLink(prc.xehNewFolder)#',{dName:dName,path:'#prc.safeCurrentRoot#'},function(data){
			if( data.errors ){ alert(data.messages); }
			fbRefresh();
		},"json");
	}
}
</cfif>
<!--- Remove Stuff --->
<cfif prc.settings.deleteStuff>
function fbDelete(){
	var sPath = $selectedItem.val();
	if( !sPath.length ){ alert("Please select a file-folder first."); return; }
	if( confirm("Are you sure you want to remove the selected file/folder? This is irreversible!") ){
		$fileLoaderBar.slideDown();
		$.post('#event.buildLink(prc.xehRemove)#',{path:sPath},function(data){
			if( data.errors ){ alert(data.messages); }
			fbRefresh();
		},"json");
	}
}
</cfif>
<!--- Download --->
<cfif prc.settings.allowDownload>
function fbDownload(){
	var sPath = $selectedItem.val();
	var sType = $selectedItemType.val();
	if( !sPath.length || sType == "dir" ){ alert("Please select a file first."); return; }
	// Trigger the download
	$("##downloadIFrame").attr("src","#event.buildLink(prc.xehDownload)#/"+ escape(sPath) );
}
</cfif>
<!--- CallBack --->
<cfif len(rc.callback)>
function fbChoose(){
	#rc.callback#( $selectedItem.val() );
}
</cfif>
</script>
</cfoutput>