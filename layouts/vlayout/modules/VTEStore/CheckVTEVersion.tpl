{*+***********************************************************************************
* The contents of this file are subject to the vtiger CRM Public License Version 1.0
* ("License"); You may not use this file except in compliance with the License
* The Original Code is:  vtiger CRM Open Source
* The Initial Developer of the Original Code is vtiger.
* Portions created by vtiger are Copyright (C) vtiger.
* All Rights Reserved.
*************************************************************************************}
{strip}
    <div class="editContainer" style="padding-left: 3%;padding-right: 3%">
        <h3>
            {vtranslate('MODULE_LBL',$QUALIFIED_MODULE)}
        </h3>
        <hr>
        <div id="breadcrumb">
            <ul class="crumbs marginLeftZero">
                <li class="first step active"  style="z-index:9" id="step1">
                    <a>
                        <span class="stepNum">&nbsp;</span>
                        <span class="stepText">{vtranslate('VTEStore Update Required',$QUALIFIED_MODULE)}</span>
                    </a>
                </li>
            </ul>
        </div>
        <div class="clearfix"></div>
    </div>
    <div class="workFlowContents" style="padding-left: 3%;padding-right: 3%">
            <div class="padding1per" style="border:1px solid #ccc;">
                <label>
                    <strong>{vtranslate('VTEStore Update Required',$QUALIFIED_MODULE)}</strong>
                </label>
                <br>
                <div class="control-group">
                    <div><span>{vtranslate('out of date',$QUALIFIED_MODULE)}</span></div>
                    <div><span>{vtranslate('LBL_THE_UPGRADE_WILL_NOT_IMPACT',$QUALIFIED_MODULE)}</span></div>
                </div>


                <div class="control-group">
                    <div><span><button style="" id="UpgradeVTEStore" class="btn btn-success UpgradeVTEStore" data-message="{vtranslate('LBL_MESSAGE_UPGRAGE_VTE_STORE_TO_LASTEST', 'VTEStore')}" data-svn="lastest">{vtranslate('LBL_UPGRADE_VTE_STORE', 'VTEStore')}</button></span></div>
                </div>

                <div class="control-group">
                    <div><span>{vtranslate('LBL_HAVE_TROUBLE',$QUALIFIED_MODULE)} {vtranslate('LBL_CONTACT_US',$QUALIFIED_MODULE)}</span></div>
                </div>
                <div class="control-group">
                    <ul style="padding-left: 10px;">
                        <li>{vtranslate('LBL_EMAIL',$QUALIFIED_MODULE)}: &nbsp;&nbsp;<a href="mailto:Support@VTExperts.com">Support@VTExperts.com</a></li>
                        <li>{vtranslate('LBL_PHONE',$QUALIFIED_MODULE)}: &nbsp;&nbsp;<span>+1 (818) 495-5557</span></li>
                        <li>{vtranslate('LBL_CHAT',$QUALIFIED_MODULE)}: &nbsp;&nbsp;{vtranslate('LBL_AVAILABLE_ON',$QUALIFIED_MODULE)} <a href="http://www.vtexperts.com" target="_blank">http://www.VTExperts.com</a></li>
                    </ul>
                </div>
            </div>
    </div>
    <div class="clearfix"></div>
</div>
{/strip}