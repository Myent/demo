{*/* * *******************************************************************************
* The content of this file is subject to the VTE Collaboration ("License");
* You may not use this file except in compliance with the License
* The Initial Developer of the Original Code is VTExperts.com
* Portions created by VTExperts.com. are Copyright(C)VTExperts.com.
* All Rights Reserved.
* ****************************************************************************** */*}

<div class="container-fluid">
    <div class="contentHeader row-fluid">
        <h3 class="span8 textOverflowEllipsis">
            <a href="index.php?module=ModuleManager&parent=Settings&view=List">&nbsp;{vtranslate('MODULE_MANAGEMENT',$QUALIFIED_MODULE)}</a>&nbsp;>&nbsp;{vtranslate({$MODULE_NAME}, $QUALIFIED_MODULE)}
        </h3>
    </div>
    <hr>
    <div class="clearfix"></div>

    <form action="index.php" method="POST">
        <input type="hidden" name="module" value="Rooms">
        <input type="hidden" name="parent" value="Settings">
        <input type="hidden" name="action" value="Save">

        <div class="listViewContentDiv row-fluid" id="listViewContents">
            <div class="row" style="margin-bottom: 20px;">
                <div class="span8">
                    <h3>{vtranslate('ENABLE_LINK_TO_RECORD',$QUALIFIED_MODULE)}</h3>
                    {vtranslate('SETTING_GUID',$QUALIFIED_MODULE)}
                </div>
                <div class="span4">
                    <span class="pull-right">
                        <button class="btn btn-success" type="submit"><strong>Save</strong></button>
                    </span>
                </div>
            </div>
            <div class="row">
                <div class="span12">
                    <select name="active_modules[]" multiple="true" class="chzn-select" style="width: 100%;">
                        {foreach item=MODULEOBJ from=$ENTITIES}
                            <option value="{$MODULEOBJ.name}" {if $MODULEOBJ.c_active eq 1}selected=""{/if}>{$MODULEOBJ.tablabel}</option>
                        {/foreach}
                    </select>
                </div>
            </div>
        </div>
    </form>
</div>

