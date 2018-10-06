	<span class="span btn-toolbar pull-right">
			<div class="row-fluid">

		<div class="listViewActions pull-right">
		  <div class="pageNumbers alignTop ">
			<span>
			  <span style="padding-right:1px" class="pageNumbersText" id="pageNumbersText">{if $ISSUES_LIST['pagination']['range']['start'] neq ''}{$ISSUES_LIST['pagination']['range']['start']}{else}0{/if} to {if $ISSUES_LIST['pagination']['range']['end'] neq ''}{$ISSUES_LIST['pagination']['range']['end']}{else}0{/if}
			  <!--<span class="icon-refresh pull-right totalNumberOfRecords cursorPointer"></span>-->
			  </span>
			  <span class="totalNumberOfRecords" id="totalNumberOfRecords">
			   of {$ISSUES_LIST['pagination']['totalcount']}
			  </span>
			</span>
		  </div>
		  <div class="btn-group alignTop margin0px">
			<span class="pull-right">
			  <span class="btn-group">
				<button type="button"  id="listViewPreviousPageButton" {if $ISSUES_LIST['pagination']['prevPageExists']}{else} disabled="disabled"{/if}class="btn">
				  <span class="icon-chevron-left">
				  </span>
				</button>
				<button data-toggle="dropdown" id="listViewPageJump" type="button" class="btn dropdown-toggle">
				  <i title="Page Jump" class="vtGlyph vticon-pageJump">
				  </i>
				</button>
				<ul id="listViewPageJumpDropDown" class="listViewBasicAction dropdown-menu">
				  <li>
					<span class="row-fluid">
					  <span class="span3 pushUpandDown2per">
						<span class="pull-right">
						  Page
						</span>
					  </span>
					  <span class="span4">
						<input type="text" value="1" class="listViewPagingInput" id="pageToJump">
					  </span>
					  <span class="span2 textAlignCenter pushUpandDown2per">
						of&nbsp;
					  </span>
					  <span id="totalPageCount" class="span2 pushUpandDown2per">
					  {$ISSUES_LIST['pagination']['pageCount']}
					  </span>
					</span>
				  </li>
				</ul>
				<button type="button" {if $ISSUES_LIST['pagination']['nextPageExists']}{else} disabled="disabled"{/if} id="listViewNextPageButton" class="btn">
				  <span class="icon-chevron-right">
				  </span>
				</button>
			  </span>
			</span>
		  </div>
		</div>
		<div class="clearfix">
		</div>
		<input type="hidden" value="{$RECORD_ID}" id="recordid">
		<input type="hidden" value="{$SELECTED_MODULE_NAME}" id="submodule">
	    <input type="hidden" name="excludedIds" id="excludedIds">

	</div>
		</span>
		
		
		
