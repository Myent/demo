{*
/**
* VGS Related Module Updates
*
*
* @package        VGSRelModUpdates Module
* @author         Conrado Maggi
* @license        Comercial / VPL
* @copyright      2014 VGS Global
* @version        Release: 1.0
*/
*}

<div>
    <div style="width: 65%;margin: auto;margin-top: 2em;padding: 2em;">
        <h3 style="padding-bottom: 1em;text-align: center">{vtranslate('License Activation', $MODULE)}</h3>
        <div class="row" style="margin: 1em;">


            <div class="alert alert-warning" style="float: left;margin-left:1em !important; margin-bottom: 0px !important;margin-top: 0px !important;width: 80%; display:block;">
                {vtranslate('Please insert your License Id and click the activate button. Your license will be validated using a SSL encrypted connection. If you rather to use the manual validation method please <span id="enable-manual" style="color: blue; text-decoration: underline;">Click here</span>', $MODULE)}
            </div>

        </div>

    </div>


    <div style="width: 90%;margin: auto;margin-top: 2%;">
        
        <input type="hidden" id="isvalid" value="{$IS_VALIDATED}">

        <div class="row-fluid">
            <div class="row-fluid">
                <div class="span12">
                    <table class="table table-bordered">
                        <tbody>
                            <tr>
                                <td class="fieldLabel" >
                                    <label class="pull-right marginRight10px"><b>{vtranslate('License Id', $QUALIFIED_MODULE)}</b></label>
                                </td>
                                <td class="fieldValue">
                                    <input type="text" id="licenseid" name="licenseid" value="{$LICENSEID}">
                                </td>
                            </tr>

                        </tbody>
                    </table>

                    <div id="manual-activation" style="display:none;">
                        <div style="width: 65%;margin: auto;margin-top: 2em;padding: 2em;">
                            <h4 style="padding-bottom: 1em;text-align: center">{vtranslate('Manual Activation', $MODULE)}</h4>
                            <div class="row" style="margin: 1em;">


                                <div class="alert" style="float: left;margin-left:1em !important; margin-bottom: 0px !important;margin-top: 0px !important;width: 80%; display:block;">
                                    {vtranslate('Please get email you license information to info@vgsglobal.com to receive the instructions for manual activation', $MODULE)}
                                </div>

                            </div>

                        </div>     


                        <table class="table table-bordered" style="margin-top:2%;">
                            <tbody>

                                <tr>
                                    <td class="fieldLabel">
                                        <label class="pull-right marginRight10px"><b>{vtranslate('Activation Id', $QUALIFIED_MODULE)}</b></label>
                                    </td>
                                    <td class="fieldValue">
                                        <input type="text" id="activationid" name="activationid">

                                    </td>
                                </tr>


                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="row-fluid" style="margin-top: 3%">
                    <div class="span12" style="margin-top: 3%">
                        <span class="pull-right">
                            <button class="btn btn-success activateButton" id="activate" type="button"><strong>{vtranslate('Activate License', $QUALIFIED_MODULE)}</strong></button>
                            <button class="btn btn-success activateButton" id="deactivate" type="button"><strong>{vtranslate('Deactivate License', $QUALIFIED_MODULE)}</strong></button>
                            <a class="cancelLink" type="reset" onclick="javascript:window.history.back();">{vtranslate('LBL_CANCEL', $QUALIFIED_MODULE)}</a>
                        </span>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <div id="privacy-policy span12" style="font-size: 80%;margin-top: 5%;width: 60%;margin-left: 5%;">
        <b>Privacy Policy:</b> The license validation process is a 100% automated process. It's done over a secure https connection to ensure your data is 100% secure. Even though, if you still prefer to user the manual validation method please contacts us for instructions.
    </div>
                        
                        <input type="hidden" id="module_name" value="{$MODULE}">
    {/strip}
        <script type="text/javascript">
            jQuery('#js_strings').html('{Zend_Json::encode($JS_LANG)}');
        </script>

    </div>
