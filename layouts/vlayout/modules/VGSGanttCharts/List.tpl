<script>
    {literal}
        jQuery(document).ready(function() {
            jQuery('#leftPanel').addClass('hide');
            jQuery('#rightPanel').removeClass('span10').addClass('span12');
            jQuery('#tButtonImage').removeClass('icon-chevron-left').addClass('icon-chevron-right');
        });

    {/literal} 
</script> 
<script type="text/javascript" src="layouts/vlayout/modules/VGSGanttCharts/resources/VGSGanttCharts.js"></script>
<div style="width: 80%;margin: auto;margin-top: 2em;padding: 2em;">
    <h3 style="padding-bottom: 1em;">VGS Gantt Charts Module</h3>
    <p>This an extension module. Please go to Project Module or Tasks Module and click on the view gantt button</p>
    <img src="layouts/vlayout/modules/VGSGanttCharts/gantt.png" style="margin-top: 2%;width: 50%;margin-bottom: 2%">
    <p><b>Important Notice:</b> All you taks must have a start and date defined. Otherwise you wont see the gantt chart</p>
    
</div>
    <div style="height: 250px"></div>
    <div><a href="index.php?module=VGSGanttCharts&view=VGSLicenseSettings&parent=Settings" >Module License</a></div>



