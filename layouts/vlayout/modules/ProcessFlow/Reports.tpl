{strip}
 
 <div class="listViewPageDiv" width="80%">
	<h2>PF Report</h2> 
   <form class="form-horizontal" autocomplete="off" name="frmSearch" method="post" action="index.php?module=ProcessFlow&view=Reports" enctype="multipart/form-data">
     
    <input type="hidden" name="module" value="ProcessFlow">
    <input type="hidden" name="view" value="Reports"> 

   <table class="table table-bordered" width="100%">
	   <tbody>
		    <tr>
                <td class="medium">Process Master</td>        
                <td class="medium">
                    <select name="processmasterid" id="processmasterid">
                        <option value=''>Select Process Master</option>
                        {foreach from=$PROCESS_MASTER_LIST item=pmname key=pmid}
                            <option value="{$pmid}" {if $pmid == $smarty.post.processmasterid } selected {/if}>{$pmname}</option>
                        {/foreach}
                    </select></td>  
                <td class="medium">Status</td>        
                <td class="medium">
                    <select name="pf_process_status">
                        <option value=''>All</option>
                        {foreach from=$PROCESS_STATUS_DATA item=pstatus}
                            <option value="{$pstatus}" {if $pstatus == $smarty.post.pf_process_status } selected {/if}>{$pstatus}</option>
                        {/foreach}
                    </select>
                </td>        
		    </tr>  
            <tr>
                <td class="medium" width="10%" >Default Fields</td>        
                <td class="medium" width="50%" >
                    <select name="fields[]" id="idFields" multiple  class="chzn-select" style="width:90%">
                        {foreach from=$PROCESSFLOW_FIELDS item=pffields key=k}
                            <option value="{$k}" {if in_array($k,$smarty.post.fields)} selected {/if}>{$pffields}</option>
                        {/foreach}
                    </select>
                </td>  
                <td class="medium" width="10%" >Custom Form Fields </td>        
                <td class="medium" width="50%" >
                    <select name="customformfields[]" id="customformfields" multiple  class="chzn-select" style="width:90%"> 
                    {foreach from=$CUSTOMFIELDS item=cl key=ck}
                            <option value="{$ck}" {if in_array($ck,$smarty.post.customformfields)} selected {/if}>{$cl}</option>
                        {/foreach}
                    </select>
                </td>  
            </tr>
            <tr>
                <td class="medium" width="10%" >Date Range</td>        
                <td class="medium" width="30%" >
                    <input id="date_start" type="text" class="dateField" name="date_start" placeholder="dd-mm-yyyy" value="{$smarty.post.date_start}"> to <input id="date_end" type="text" class="dateField" name="date_end" placeholder="dd-mm-yyyy" value="{$smarty.post.date_end}">
                </td>
                <td class="medium" width="10%" > </td>        
                <td class="medium" width="50%" > </td>        
            </tr>
	   </tbody>
	</table>
    <br>
    <div class="padding1per"><strong>Calculations</strong></div>
     
    <table class="table table-bordered CalculationFields"  width="50%">
        <thead>
            <tr class="calculationHeaders">
                <th>Columns</th>
                <th>Sum</th>
            </tr>
        </thead>
        <tbody id="CalculationFields">
             {foreach from=$CUSTOMFIELDS item=cl key=ck} 
                <tr class='calculationFieldRow'><td>{$cl}</td><td><input type='checkbox' name="cal[sum][{$ck}]" {if $smarty.post.cal.sum[$ck] == 'on'} checked {/if}></td></tr>
            {/foreach}
        </tbody>
    </table>
<br>
     <input class="btn btn-success" type="submit" name="submit" value="Search">
    </form>
<br>
<div class="padding1per"><strong>Calculations result</strong></div>
     
    <table class="table table-bordered"  width="50%">
        <thead>
            <tr class="calculationHeaders">
                <th>Columns</th>
                <th>Sum</th>
            </tr>
        </thead>
        {foreach from=$PROCESS_CAL_SUM_RECORDS_DATA key=k item=v}
        <tr><td>{$CUSTOMFIELDS[$k]}</td><td>{$v}</td></tr>
        {/foreach}
    </table>
<br> 
    <table class="table table-bordered listViewEntriesTable" id="tblData">
	   <thead>
		  <tr class="listViewHeaders">
            <th>{'#'}</th>
            {foreach from=$PROCESS_RECORDS_DATA['headers'] item=headers_data  }
                <th>{$headers_data}</th>
            {/foreach} 
		  </tr>
	   </thead>
	   <tbody>
            {foreach from=$PROCESS_RECORDS_DATA['data'] item=trdata key=k  }
                <tr class="listViewEntries"  >
                    <td class="medium">{$k+1}</td>
                    {foreach from=$trdata item=tddata}
                    <td nowrap="" class="medium">{$tddata}</td>
                    {/foreach}   
                </tr> 
		    {/foreach}
	   </tbody>
	</table>

</div>

</div></div></div>
 

<link href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css" rel="stylesheet"></link>
<link href="https://cdn.datatables.net/buttons/1.5.2/css/buttons.dataTables.min.css" rel="stylesheet"></link>




<script type="text/javascript" src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/buttons/1.5.2/js/dataTables.buttons.min.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.flash.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/pdfmake.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/vfs_fonts.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.html5.min.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.print.min.js"></script> 


<script>
$(document).ready(function() {  

    $('#customformfields').chosen();

    $('#tblData').DataTable( {
        dom: 'Bfrtip',
        buttons: [
            'copy', 'csv', 'excel', 'print',{
                extend: 'pdfHtml5',
                orientation: 'landscape',
                pageSize: 'LEGAL'
            }
        ] 
     
    });

     var dateFormat = "mm/dd/yy",
      from = $( "#date_start" )
        .datepicker({
          defaultDate: "+1w",
          changeMonth: true,
          numberOfMonths: 1
        })
        .on( "change", function() {
          to.datepicker( "option", "minDate", getDate( this ) );
        }),
      to = $( "#date_end" ).datepicker({
        defaultDate: "+1w",
        changeMonth: true,
        numberOfMonths: 1
      })
      .on( "change", function() {
        from.datepicker( "option", "maxDate", getDate( this ) );
      });
 
    function getDate( element ) {
      var date;
      try {
        date = $.datepicker.parseDate( dateFormat, element.value );
      } catch( error ) {
        date = null;
      }
 
      return date;
    }

    $("#processmasterid").change(function(){
       
        var processmasterid = $(this).val();
        var sentdata ={};
        sentdata.module ='ProcessFlow';
        sentdata.action = 'AjaxValidations';
        sentdata.mode = 'getCustomFormInfo';
        sentdata.processmasterid = processmasterid;

        AppConnector.request(sentdata).then(
            function(data){
                console.log(data.result.response);
                /* */
                var d = $.parseJSON(data.result.response);
                var htmls = '';
                var calculations_htmls = '';
                $.each(d, function(i, item) {
                    htmls += "<option value='"+i+"'>"+item+"</option>";
                    calculations_htmls += "<tr class='calculationFieldRow'><td>"+item+"</td><td><input type='checkbox' name='cal[sum]["+i+"]' ></td></tr>";
                });
                $('#customformfields').empty();
                $('#customformfields').append(htmls);
                $('#customformfields').trigger("liszt:updated");
                
                /* $('#CalculationFieldsTboday').empty(); */
                $('#CalculationFields').html(calculations_htmls);
            }
        );
    });
});
</script>
{/strip}
 