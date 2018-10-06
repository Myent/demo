{*/* ********************************************************************************
* The content of this file is subject to the Collaboration ("License");
* You may not use this file except in compliance with the License
* The Initial Developer of the Original Code is VTExperts.com
* Portions created by VTExperts.com. are Copyright(C) VTExperts.com.
* All Rights Reserved.
* ****************************************************************************** */*}
<section id="collaboration-history">
    <header class="collaboration-history-header">
        <h3>{vtranslate('LBL_HISTORY', 'Rooms')}</h3>
    </header>
    <div class="collaboration-history-search-box row">
        <div class="col-lg-6 col-md-6 col-sm-12">
            <select id="history-type" class="inputElement select2">
                <option value="R">{vtranslate('LBL_HISTORY_TYPE_ROOM', 'Rooms')}</option>
                <option value="M">{vtranslate('LBL_HISTORY_TYPE_MESSAGE', 'Rooms')}</option>
            </select>
        </div>
        <div class="col-lg-6 col-md-6 col-sm-12">
            <input type="text" id="history-search-box" placeholder="{vtranslate('LBL_SEARCH', 'Rooms')}" class="pull-right"/>
            <i class="fa fa-search"></i>
        </div>
    </div>
    <div class="collaboration-history-result">

    </div>
</section>