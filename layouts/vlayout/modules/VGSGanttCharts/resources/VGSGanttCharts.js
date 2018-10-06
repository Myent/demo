function ViewGanttChart(t) {
    var e = [];
    if (isNaN(parseFloat(t)))
        var a = Vtiger_List_Js.getInstance(),
            e = a.readSelectedIds(!0),
            n = "list";
    else {
        e[0] = t, t = "Project";
        var n = "detail"
    }
    var i = jQuery(".listViewLoadingMsg").text(),
            o = jQuery.progressIndicator({
                message: i,
                position: "html",
                blockInfo: {
                    enabled: !0
                }
            });


    var params = {
        module: 'VGSGanttCharts',
        action: 'getCurrentUserDateFormat',
    };
    AppConnector.request(params).then(
            function (data) {
                if (data.success) {
                    var response = data.result;
                    jQuery('#current_user_id').after('<input type="hidden" id="user_gantt_date_format" value="' + response + ' ">');
                    jQuery.when(jQuery.getScript("layouts/vlayout/modules/VGSGanttCharts/resources/dhtmlx/dhtmlxgantt.js"), jQuery.Deferred(function (t) {
                        jQuery(t.resolve)
                    })).done(function () {
                        var a = jQuery("<link rel='stylesheet' type='text/css' href='layouts/vlayout/modules/VGSGanttCharts/resources/dhtmlx/dhtmlxgantt.css'>");
                        jQuery("head").append(a), gantt.config.columns = [{
                                name: "text",
                                label: "Task name",
                                tree: !0
                            }, {
                                name: "start_date",
                                label: "Start time",
                                align: "center"
                            }, {
                                name: "progress",
                                label: "Progress",
                                align: "center"
                            }, {
                                name: "add",
                                label: "",
                                width: 44
                            }], gantt.config.sort = true, gantt.config.scale_unit = "day", gantt.config.xml_date = "%Y-%m-%d %H:%i:%s", gantt.config.date_grid = jQuery('#user_gantt_date_format').val(), gantt.config.drag_links = !1, gantt.config.details_on_dblclick = !1, "detail" == n ? (jQuery(".detailViewInfo").attr("id", "gantt-here"), jQuery("#gantt-here").css("min-height", "450px"), jQuery(".detailViewContainer").css("min-height", "550px"), gantt.init("gantt-here"), void 0 == jQuery(".monthView").val() && ($(".detailViewButtoncontainer").after('<button style="margin-bottom: 0.5%;margin-right: 0.5%;" class="btn addButton monthView" onclick="monthView();"><strong>Month View</strong></button>'), $(".detailViewButtoncontainer").after('<button style="margin-bottom: 0.5%;margin-right: 0.5%;" class="btn addButton weekView" onclick="weekView();"><strong>Week View</strong></button>'), $(".detailViewButtoncontainer").after('<button style="margin-bottom: 0.5%;margin-right: 0.5%;" class="btn addButton dayView" onclick="dayView();"><strong>Day View</strong></button>'))) : (jQuery(".listViewPageDiv").css("min-height", "350px"), jQuery("#listViewContents").css("min-height", "350px"), jQuery("#listViewContents").height(jQuery(window).height() - jQuery(".navbar-fixed-top").height()), jQuery(".customFilterMainSpan").hide(), gantt.init("listViewContents"),
                                void 0 == jQuery(".monthView").val() && ($(".listViewActionsDiv").after('<button style="margin-bottom: 0.5%;margin-right: 0.5%;" class="btn addButton monthView" onclick="monthView();"><strong>Month View</strong></button>'), $(".listViewActionsDiv").after('<button style="margin-bottom: 0.5%;margin-right: 0.5%;" class="btn addButton weekView" onclick="weekView();"><strong>Week View</strong></button>'), $(".listViewActionsDiv").after('<button style="margin-bottom: 0.5%;margin-right: 0.5%;" class="btn addButton dayView" onclick="dayView();"><strong>Day View</strong></button>'))),
                                gantt.config.buttons_left = ["dhx_save_btn", "dhx_cancel_btn"], gantt.load("index.php?module=VGSGanttCharts&mode=loadGanttData&view=ProjectGanttChartListView&for_module=" + t + "&selected_ids=" + e, "json"), o.progressIndicator({
                            mode: "hide"
                        }), gantt.attachEvent("onAfterTaskDrag", function (t, e, a) {
                            var a = gantt.getTask(t);
                            console.log(a.id), updateTask(a)
                        }), gantt.attachEvent("onTaskDblClick", function (t) {
                            var e = gantt.getTask(t),
                                    a = e.id,
                                    n = e.type;
                            if ("" == n) {
                                var i = "index.php?module=ProjectTask&view=Detail&record=" + a;
                                window.open(i, "_blank")
                            } else if ("project" == n) {
                                var i = "index.php?module=Project&view=Detail&record=" + a;
                                window.open(i, "_blank")
                            } else if ("milestone" == n) {
                                var i = "index.php?module=ProjectMilestone&view=Detail&record=" + a;
                                window.open(i, "_blank")
                            }
                        }), gantt.attachEvent("onLightboxSave", function (a, i) {
                            createTask(i, e, n, t)
                        }), gantt.attachEvent("onLinkValidation", function (t) {
                            console.log(t)
                        }), gantt.templates.grid_row_class = function (t, e, a) {
                            return a.$level > 0 ? "nested_task" : ""
                        }
                    })

                }
            },
            function (error, err) {

            }
    );


}

function updateTask(t) {
    var e = {
        task_id: t.id,
        progress: t.progress,
        start_date: t.start_date.getTime() / 1e3,
        end_date: t.end_date.getTime() / 1e3
    };
    jQuery.ajax({
        data: e,
        url: "index.php?module=VGSGanttCharts&mode=updateTaskData&view=ProjectGanttChartListView",
        type: "post",
        success: function () {}
    })
}

function createTask(t, e, a, n) {
    var i = {
        projecttaskname: t.text,
        project_id: t.parent,
        progress: t.progress,
        start_date: t.start_date.getTime() / 1e3,
        end_date: t.end_date.getTime() / 1e3
    };
    jQuery.ajax({
        data: i,
        url: "index.php?module=VGSGanttCharts&mode=createTask&view=ProjectGanttChartListView",
        type: "post",
        success: function (i) {
            i = i.replace(/(\r\n|\n|\r)/gm, "");
            i = i.replace("↵", "");
            var o = i.split("::");
            return "Success" != o[0] ? "error" : (gantt.getTask(t.id).id = o[1], gantt.hideCover(gantt.getLightbox()), gantt.resetLightbox(), gantt.clearAll(), "detail" == a ? gantt.load("index.php?module=VGSGanttCharts&mode=loadGanttData&view=ProjectGanttChartListView&for_module=" + n + "&selected_ids=" + e, "json") : gantt.load("index.php?module=VGSGanttCharts&mode=loadGanttData&view=ProjectGanttChartListView&for_module=" + n + "&selected_ids=" + e, "json"), void 0)
        }
    })
}

function getParameterByName(t) {
    t = t.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
    var e = new RegExp("[\\?&]" + t + "=([^&#]*)"),
            a = e.exec(location.search);
    return null == a ? "" : decodeURIComponent(a[1].replace(/\+/g, " "))
}

function weekView() {
    gantt.config.scale_unit = "week", gantt.render()
}

function dayView() {
    gantt.config.scale_unit = "day", gantt.render()
}

function monthView() {
    gantt.config.scale_unit = "month", gantt.render()
}
