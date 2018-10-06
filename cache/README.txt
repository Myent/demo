Calendar++ will avoid creating duplicate meetings for a user in a particular time slot.
E.g.: User A has a meeting booked between 2 pm to 3 pm, then no event will be accepted in that particular time slot by the CRM.

Calendar++ form provides 3 steps to create an Event.

Step 1: Provide event details like Subject, Event date and time, Status.
Step 2: Select Contacts and Users to be invited for the meeting.
Step 3: Displays the invited contacts and Users.

Note : In step 2 if the user time slot is booked then it will show the pop-up to change the time slot.

Standard Modified Files are:
1.modules/Calendar/views/Edit.php
2.modules/Calendar/actions/Save.php
3.modules/Calendar/CalendarCommon.php
4.layouts/vlayout/modules/Calendar/resources/Edit.js
5.layouts/vlayout/modules/Calendar/resources/ToDo.js
6.modules/Events/models/Module.php
7.modules/Events/models/Record.php

Best Regards,

<span class="redColor"><strong>S.T.Prasad</strong></span>

Chief Shikari
<a href="http://www.vtigress.com" target=_blank>www.vtigress.com</a>
The PURR-fect mate for Vtiger