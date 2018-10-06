

{strip}
    <script type="text/javascript" src="layouts/vlayout/modules/SumField/resources/SumField.js"></script>

    <div  class="row-fluid conditionsContainer" >
        {assign var=FIELD_VALUE_MAPPING value=ZEND_JSON::decode($TASK_OBJECT->field_value_mapping)}
        {assign var=TOTAL_MODULE_MODEL value=$TASK_OBJECT->getTotalSumModule()}
        {assign var=PRODUCT_MODULE_MODEL value=$TASK_OBJECT->getProductModule()}

        <input type="hidden" id="fieldValueMapping" name="field_value_mapping" value='{Vtiger_Util_Helper::toSafeHTML($TASK_OBJECT->field_value_mapping)}' />
        <div class="row-fluid ">
			<span class="span6">
                <div class="row-fluid"> <strong>Choose field to calculate sum</strong></div>
                <br>
                <div class="row-fluid">
                    <span class="span5"> <label class="pull-right" style="font-size: 12px"><b> Module name</b></label></span>
                    <span class="span5">	<input type="text" value="{$MODULE_MODEL->get('name')}"  name="sum_module_name" data-validation-engine="validate[funcCall[Vtiger_AlphaNumeric_Validator_Js.invokeValidation]]"/></span>
                </div>
                <br>
              <div class="row-fluid">  <span class="span5"><label class="pull-right" style="font-size: 12px"><b>Sum Product Field </b> </label></span>
                  <span class="span5">  <select name="sum_field"  style="min-width: 150px">
                          <option value="none"></option>
                          {*  {foreach from=$MODULE_MODEL->getFields() item=FIELD_MODEL}
                               {assign var=FIELD_INFO value=$FIELD_MODEL->getFieldInfo()}
                               {if $FIELD_MODEL->getFieldType()=='N'||$FIELD_MODEL->getFieldType()=='NN'}
                                   <option value="{$FIELD_MODEL->get('name')}" data-fieldtype="{$FIELD_MODEL->getFieldType()}"
                                           data-field-name="{$FIELD_MODEL->get('name')}" data-fieldinfo='{ZEND_JSON::encode($FIELD_INFO)}' >
                                       {vtranslate($FIELD_MODEL->get('label'), $MODULE_MODEL->get('name'))}
                                   </option>
                               {/if}
                           {/foreach}*}

                          {foreach from=$PRODUCT_MODULE_MODEL->getFields() item=FIELD_MODEL}
                              {assign var=FIELD_INFO value=$FIELD_MODEL->getFieldInfo()}
                              {if $FIELD_MODEL->getFieldType()=='N'||$FIELD_MODEL->getFieldType()=='NN'}
                                  <option value="{$FIELD_MODEL->get('name')}" {if $FIELD_VALUE_MAPPING[0].sum_field==$FIELD_MODEL->get('name')}selected {/if} data-fieldtype="{$FIELD_MODEL->getFieldType()}"
                                          data-field-name="{$FIELD_MODEL->get('name')}" data-fieldinfo='{ZEND_JSON::encode($FIELD_INFO)}' >
                                      {vtranslate($FIELD_MODEL->get('label'), $PRODUCT_MODULE_MODEL->get('name'))}
                                  </option>
                              {/if}
                          {/foreach}
                      </select></span>
              </div>
                <br>
                  <div class="row-fluid">  <span class="span5"><label class="pull-right" style="font-size: 12px"><b>Update to Invoice Field </b> </label></span>
                  <span class="span5">  <select name="update_field"  style="min-width: 150px">
                          <option value="none"></option>
                          {foreach from=$MODULE_MODEL->getFields() item=FIELD_MODEL}
                              {assign var=FIELD_INFO value=$FIELD_MODEL->getFieldInfo()}
                              {if $FIELD_MODEL->getFieldType()=='N'||$FIELD_MODEL->getFieldType()=='NN'}
                                  <option value="{$FIELD_MODEL->get('name')}" {if $FIELD_VALUE_MAPPING[0].update_field==$FIELD_MODEL->get('name')}selected {/if} data-fieldtype="{$FIELD_MODEL->getFieldType()}"
                                          data-field-name="{$FIELD_MODEL->get('name')}" data-fieldinfo='{ZEND_JSON::encode($FIELD_INFO)}' >
                                      {vtranslate($FIELD_MODEL->get('label'), $MODULE_MODEL->get('name'))}
                                  </option>
                              {/if}
                          {/foreach}
                      </select></span>
                  </div>
    </span>

				<span class="span6">
                      <div  class="row-fluid"> <strong>Choose field to update total sum</strong></div>
                    <br>
                 <div class="row-fluid"> <span class="span5"> <label class="pull-right" style="font-size: 12px"><b> Module name</b></label></span>
                     <span class="span5">	<input type="text" value="{if $FIELD_VALUE_MAPPING[0].total_modulename!=''}{$FIELD_VALUE_MAPPING[0].total_modulename}{else}{$TASK_OBJECT->total_sum_module} {/if}"  name="totalsum_module_name" data-validation-engine="validate[funcCall[Vtiger_AlphaNumeric_Validator_Js.invokeValidation]]"/></span>
                 </div>
 <br>
              <div class="row-fluid">   <span class="span5"><label class="pull-right" style="font-size: 12px"><b>Update to Contacts Field </b> </label></span>
                  <span class="span5">  <select name="total_update_field"  style="min-width: 150px">
                          <option value="none"></option>

                          {foreach from=$TOTAL_MODULE_MODEL->getFields() item=FIELD_MODEL}
                              {assign var=FIELD_INFO value=$FIELD_MODEL->getFieldInfo()}
                              {if $FIELD_MODEL->getFieldType()=='N'||$FIELD_MODEL->getFieldType()=='NN'}
                                  <option value="{$FIELD_MODEL->get('name')}" {if $FIELD_VALUE_MAPPING[0].total_field==$FIELD_MODEL->get('name')}selected {/if} data-fieldtype="{$FIELD_MODEL->getFieldType()}"
                                          data-field-name="{$FIELD_MODEL->get('name')}" data-fieldinfo='{ZEND_JSON::encode($FIELD_INFO)}' >
                                      {vtranslate($FIELD_MODEL->get('label'), $TOTAL_MODULE_MODEL->get('name'))}
                                  </option>
                              {/if}
                          {/foreach}
                      </select></span>
              </div >
                     <br>
                     <div class="row-fluid"> <span class="span5"> <label class="pull-right" style="font-size: 12px"><b> By </b> </label> </span>
                         <span class="span5">
                            <select name="sumby"  style="min-width: 150px">
                                <option value=""></option>
                                <option value="month" {if $FIELD_VALUE_MAPPING[0].total_sumby=="month"}selected {/if}>Month</option>
                            </select>
                         </span>
                     </div>
    </span>

        </div>
    </div>

{/strip}