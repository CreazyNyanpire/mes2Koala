<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <%@ include file="/pages/common/header.jsp"%><!--引入权限系统该页面需无须引用header.jsp -->
    <%@ page import="java.util.Date" %>
    <% String formId = "form_" + new Date().getTime();
        String gridId = "grid_" + new Date().getTime();
        String path = request.getContextPath() + request.getServletPath().substring(0, request.getServletPath().lastIndexOf("/") + 1);
    %>
    <script type="text/javascript">
        var grid;
        var form;
        var _dialog;
        $(function () {
            grid = $("#<%=gridId%>");
            form = $("#<%=formId%>");
            PageLoader = {
                //
                initSearchPanel: function () {
                    var startTimeVal = form.find('#createTimestampID_start');
                    var startTime = startTimeVal.parent();
                    var endTimeVal = form.find('#createTimestampID_end');
                    var endTime = endTimeVal.parent();
                    startTime.datetimepicker({
                        language: 'zh-CN',
                        format: "yyyy-mm-dd",
                        autoclose: true,
                        todayBtn: true,
                        minView: 2,
                        pickerPosition: 'bottom-left'
                    }).on('changeDate', function () {
                        endTime.datetimepicker('setStartDate', startTimeVal.val());
                    });//加载日期选择器
                    var yesterday = new Date();
                    yesterday.setDate(yesterday.getDate() - 1);
                    endTime.datetimepicker({
                        language: 'zh-CN',
                        format: "yyyy-mm-dd",
                        autoclose: true,
                        todayBtn: true,
                        minView: 2,
                        pickerPosition: 'bottom-left'
                    }).on('changeDate', function (ev) {
                        startTime.datetimepicker('setEndDate', endTimeVal.val());
                    }).datetimepicker('setDate', new Date()).trigger('changeDate');//加载日期选择器
                    startTime.datetimepicker('setDate', yesterday).trigger('changeDate');
                    form.find('#selected_SELECT').select({
                        title: '请选择',
                        contents: [
                            {title: '请选择', value: ''},
                            {title: '是', value: '1'},
                            {title: '否', value: '0'}
                        ]
                    }).on('change', function () {
                        form.find('#selectedID_').val($(this).getValue());
                    });
                    var startTimeVal = form.find('#lastModifyTimestampID_start');
                    var startTime = startTimeVal.parent();
                    var endTimeVal = form.find('#lastModifyTimestampID_end');
                    var endTime = endTimeVal.parent();
                    startTime.datetimepicker({
                        language: 'zh-CN',
                        format: "yyyy-mm-dd",
                        autoclose: true,
                        todayBtn: true,
                        minView: 2,
                        pickerPosition: 'bottom-left'
                    }).on('changeDate', function () {
                        endTime.datetimepicker('setStartDate', startTimeVal.val());
                    });//加载日期选择器
                    var yesterday = new Date();
                    yesterday.setDate(yesterday.getDate() - 1);
                    endTime.datetimepicker({
                        language: 'zh-CN',
                        format: "yyyy-mm-dd",
                        autoclose: true,
                        todayBtn: true,
                        minView: 2,
                        pickerPosition: 'bottom-left'
                    }).on('changeDate', function (ev) {
                        startTime.datetimepicker('setEndDate', endTimeVal.val());
                    }).datetimepicker('setDate', new Date()).trigger('changeDate');//加载日期选择器
                    startTime.datetimepicker('setDate', yesterday).trigger('changeDate');
                },
                initGridPanel: function () {
                    var self = this;
                    var width = 180;
                    return grid.grid({
                        identity: "id",
                        buttons: [
                            {
                                content: '<button class="btn btn-primary" type="button"><span class="glyphicon glyphicon-plus"><span>从Excel导入</button>',
                                action: 'importExcel'
                            },
                            {
                                content: '<button class="btn btn-primary" type="button"><span class="glyphicon glyphicon-plus"><span>添加</button>',
                                action: 'add'
                            },
                            {
                                content: '<button class="btn btn-success" type="button"><span class="glyphicon glyphicon-edit"><span>修改</button>',
                                action: 'modify'
                            },
                            {
                                content: '<button class="btn btn-danger" type="button"><span class="glyphicon glyphicon-remove"><span>删除</button>',
                                action: 'delete'
                            },
                            {
                                content: '<button class="btn btn-primary" type="button"><span class="glyphicon glyphicon-plus"><span>导出到Excel</button>',
                                action: 'exportExcel'
                            },
                        ],
                        url: "${pageContext.request.contextPath}/BomUse/pageJson.koala",
                        columns: [
                           // {title: 'logic', name: 'logic', width: width},
                            {
                                title: 'bom',
                                name: 'bomTemplate',
                                width: width,
                                render: function (rowdata, rowindex, value) {
                                    // alert(JSON.stringify(rowdata));
                                    if (rowdata['bomTemplateDTO'] != null) { // 有可能还没有设定
                                        var param = '' + rowdata['bomTemplateDTO']['name'] + '';
                                        return param;
                                    } else {
                                        return ""
                                    }
                                }
                            },
                            {
                                title: 'selected',
                                name: 'selected',
                                width: 120,
                                render: function (rowdata, rowindex, value) {
                                    return rowdata.selected ? "<span style='color:#47a447' class='glyphicon glyphicon-ok'></span>" : "<span style='color:#d2322d' class='glyphicon glyphicon-remove'></span>";
                                }
                            },

                            // {title: 'createEmployNo', name: 'createEmployNo', width: width},
                           // {title: 'lastModifyEmployNo', name: 'lastModifyEmployNo', width: width},
                            {
                                title: '操作', width: 120, render: function (rowdata, name, index) {
                                var param = '"' + rowdata.id + '"';
                                var h = "<a href='javascript:openDetailsPage(" + param + ")'>查看</a> ";
                                return h;
                            }
                            }
                        ]
                    }).on({
                        'exportExcel': function (event, data) {
                            var indexs = data.data;
                            var $this = $(this);
                            if (indexs.length == 0) {
                                $this.message({
                                    type: 'warning',
                                    content: '请选择要导出的记录'
                                });
                                return;
                            }
                            var exportExcel = function () {
                                self.exportExcel(indexs, $this);
                            };
                            $this.confirm({
                                content: '确定要导出所选记录吗?',
                                callBack: exportExcel
                            });
                        },
                        'add': function () {
                            self.add($(this));
                        },
                        'modify': function (event, data) {
                            var indexs = data.data;
                            var $this = $(this);
                            if (indexs.length == 0) {
                                $this.message({
                                    type: 'warning',
                                    content: '请选择一条记录进行修改'
                                })
                                return;
                            }
                            if (indexs.length > 1) {
                                $this.message({
                                    type: 'warning',
                                    content: '只能选择一条记录进行修改'
                                })
                                return;
                            }
                            self.modify(indexs[0], $this);
                        },
                        'delete': function (event, data) {
                            var indexs = data.data;
                            var $this = $(this);
                            if (indexs.length == 0) {
                                $this.message({
                                    type: 'warning',
                                    content: '请选择要删除的记录'
                                });
                                return;
                            }
                            var remove = function () {
                                self.remove(indexs, $this);
                            };
                            $this.confirm({
                                content: '确定要删除所选记录吗?',
                                callBack: remove
                            });
                        }
                    });
                },
                add: function (grid) {
                    var self = this;
                    var dialog = $('<div class="modal fade"><div class="modal-dialog">'
                            + '<div class="modal-content"><div class="modal-header"><button type="button" class="close" '
                            + 'data-dismiss="modal" aria-hidden="true">&times;</button>'
                            + '<h4 class="modal-title">新增</h4></div><div class="modal-body">'
                            + '<p>One fine body&hellip;</p></div><div class="modal-footer">'
                            + '<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>'
                            + '<button type="button" class="btn btn-success" id="save">保存</button></div></div>'
                            + '</div></div>');
                    $.get('<%=path%>/BomUse-add.jsp').done(function (html) {
                        dialog.modal({
                            keyboard: false
                        }).on({
                            'hidden.bs.modal': function () {
                                $(this).remove();
                            }
                        }).find('.modal-body').html(html);
                        self.initPage(dialog.find('form'));
                    });
                    dialog.find('#save').on('click', {grid: grid}, function (e) {
                        if (!Validator.Validate(dialog.find('form')[0], 3))return;
                        $.post('${pageContext.request.contextPath}/BomUse/add.koala', dialog.find('form').serialize()).done(function (result) {
                            if (result.success) {
                                dialog.modal('hide');
                                e.data.grid.data('koala.grid').refresh();
                                e.data.grid.message({
                                    type: 'success',
                                    content: '保存成功'
                                });
                            } else {
                                dialog.find('.modal-content').message({
                                    type: 'error',
                                    content: result.actionError
                                });
                            }
                        });
                    });
                },
                modify: function (id, grid) {
                    var self = this;
                    var dialog = $('<div class="modal fade"><div class="modal-dialog"><div class="modal-content"><div class="modal-header"><button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button><h4 class="modal-title">修改</h4></div><div class="modal-body"><p>One fine body&hellip;</p></div><div class="modal-footer"><button type="button" class="btn btn-default" data-dismiss="modal">取消</button><button type="button" class="btn btn-success" id="save">保存</button></div></div></div></div>');
                    $.get('<%=path%>/BomUse-update.jsp').done(function (html) {
                        dialog.find('.modal-body').html(html);
                        self.initPage(dialog.find('form'));
                        $.get('${pageContext.request.contextPath}/BomUse/get/' + id + '.koala').done(function (json) {
                            json = json.data;
                            var elm;
                            for (var index in json) {
                                elm = dialog.find('#' + index + 'ID');
                                if (elm.hasClass('select')) {
                                    elm.setValue(json[index]);
                                } else {
                                    elm.val(json[index]);
                                }
                            }
                        });
                        dialog.modal({
                            keyboard: false
                        }).on({
                            'hidden.bs.modal': function () {
                                $(this).remove();
                            }
                        });
                        dialog.find('#save').on('click', {grid: grid}, function (e) {
                            if (!Validator.Validate(dialog.find('form')[0], 3))return;
                            // alert(dialog.find('form').serialize())
                            $.post('${pageContext.request.contextPath}/BomUse/update.koala?id=' + id, dialog.find('form').serialize()).done(function (result) {
                                if (result.success) {
                                    dialog.modal('hide');
                                    e.data.grid.data('koala.grid').refresh();
                                    e.data.grid.message({
                                        type: 'success',
                                        content: '保存成功'
                                    });
                                } else {
                                    dialog.find('.modal-content').message({
                                        type: 'error',
                                        content: result.actionError
                                    });
                                }
                            });
                        });
                    });
                },
                initPage: function (form) {
                    form.find('.form_datetime').datetimepicker({
                        language: 'zh-CN',
                        format: "yyyy-mm-dd",
                        autoclose: true,
                        todayBtn: true,
                        minView: 2,
                        pickerPosition: 'bottom-left'
                    }).datetimepicker('setDate', new Date());//加载日期选择器
                    form.find('.select').each(function () {
                        var select = $(this);
                        var idAttr = select.attr('id');
                        select.select({
                            title: '请选择',
                            contents: selectItems[idAttr]
                        }).on('change', function () {
                            form.find('#' + idAttr + '_').val($(this).getValue());
                        });
                    });
                },
                remove: function (ids, grid) {
                    var data = [{name: 'ids', value: ids.join(',')}];
                    $.post('${pageContext.request.contextPath}/BomUse/delete.koala', data).done(function (result) {
                        if (result.success) {
                            grid.data('koala.grid').refresh();
                            grid.message({
                                type: 'success',
                                content: '删除成功'
                            });
                        } else {
                            grid.message({
                                type: 'error',
                                content: result.result
                            });
                        }
                    });
                },
                exportExcel: function (ids, grid) {
                    var data = [{name: 'ids', value: ids.join(',')}];
                    $.post('${pageContext.request.contextPath}/BomUse/exportExcel.koala', data).done(function (result) {
                        if (result.success) {
                            grid.data('koala.grid').refresh();
                            grid.message({
                                type: 'success',
                                content: '导出'
                            });
                        } else {
                            grid.message({
                                type: 'error',
                                content: result.result
                            });
                        }
                    });
                }
            };
            PageLoader.initSearchPanel();
            PageLoader.initGridPanel();
            form.find('#search').on('click', function () {
                if (!Validator.Validate(document.getElementById("<%=formId%>"), 3))return;
                var params = {};
                form.find('input').each(function () {
                    var $this = $(this);
                    var name = $this.attr('name');
                    if (name) {
                        params[name] = $this.val();
                    }
                });
                grid.getGrid().search(params);
            });
        });

        var openDetailsPage = function (id) {
            var dialog = $('<div class="modal fade"><div class="modal-dialog"><div class="modal-content"><div class="modal-header"><button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button><h4 class="modal-title">查看</h4></div><div class="modal-body"><p>One fine body&hellip;</p></div><div class="modal-footer"><button type="button" class="btn btn-info" data-dismiss="modal">返回</button></div></div></div></div>');
            $.get('<%=path%>/BomUse-view.jsp').done(function (html) {
                dialog.find('.modal-body').html(html);
                $.get('${pageContext.request.contextPath}/BomUse/get/' + id + '.koala').done(function (json) {
                    json = json.data;
                    var elm;
                    for (var index in json) {
                        if (json[index] + "" == "false") {
                            dialog.find('#' + index + 'ID').html("<span style='color:#d2322d' class='glyphicon glyphicon-remove'></span>");
                        } else if (json[index] + "" == "true") {
                            dialog.find('#' + index + 'ID').html("<span style='color:#47a447' class='glyphicon glyphicon-ok'></span>");
                        } else {
                            dialog.find('#' + index + 'ID').html(json[index] + "");
                        }
                    }
                });
                dialog.modal({
                    keyboard: false
                }).on({
                    'hidden.bs.modal': function () {
                        $(this).remove();
                    }
                });
            });
        }
    </script>
</head>
<body>
<div style="width:98%;margin-right:auto; margin-left:auto; padding-top: 15px;">
    <!-- search form -->
    <form name=<%=formId%> id=<%=formId%> target="_self" class="form-horizontal">
        <input type="hidden" name="page" value="0">
        <input type="hidden" name="pagesize" value="10">
        <table border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td>
                    <%--<div class="form-group">--%>
                        <%--<label class="control-label" style="width:100px;float:left;">createEmployNo:&nbsp;</label>--%>

                        <%--<div style="margin-left:15px;float:left;">--%>
                            <%--<input name="createEmployNo" class="form-control" type="text" style="width:180px;"--%>
                                   <%--id="createEmployNoID"/>--%>
                        <%--</div>--%>
                        <%--<label class="control-label" style="width:100px;float:left;">lastModifyEmployNo:&nbsp;</label>--%>

                        <%--<div style="margin-left:15px;float:left;">--%>
                            <%--<input name="lastModifyEmployNo" class="form-control" type="text" style="width:180px;"--%>
                                   <%--id="lastModifyEmployNoID"/>--%>
                        <%--</div>--%>
                    <%--</div>--%>
                    <div class="form-group">
                        <%--<label class="control-label" style="width:100px;float:left;">createTimestamp:&nbsp;</label>--%>

                        <%--<div style="margin-left:15px;float:left;">--%>
                            <%--<div class="input-group date form_datetime" style="width:160px;float:left;">--%>
                                <%--<input type="text" class="form-control" style="width:160px;" name="createTimestamp"--%>
                                       <%--id="createTimestampID_start">--%>
                                <%--<span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>--%>
                            <%--</div>--%>
                            <%--<div style="float:left; width:10px; margin-left:auto; margin-right:auto;">--%>
                                <%--&nbsp;-&nbsp;</div>--%>
                            <%--<div class="input-group date form_datetime" style="width:160px;float:left;">--%>
                                <%--<input type="text" class="form-control" style="width:160px;" name="createTimestampEnd"--%>
                                       <%--id="createTimestampID_end">--%>
                                <%--<span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>--%>
                            <%--</div>--%>
                        <%--</div>--%>
                        <label class="control-label" style="width:100px;float:left;">selected:&nbsp;</label>

                        <div style="margin-left:15px;float:left;">
                            <div class="btn-group select" id="selected_SELECT"></div>
                            <input type="hidden" id="selectedID_" name="selected"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <%--<label class="control-label" style="width:100px;float:left;">logic:&nbsp;</label>--%>

                        <%--<div style="margin-left:15px;float:left;">--%>
                            <%--<input name="logic" class="form-control" type="text" style="width:180px;" id="logicID"/>--%>
                        <%--</div>--%>
                        <%--<label class="control-label" style="width:100px;float:left;">lastModifyTimestamp:&nbsp;</label>--%>

                        <%--<div style="margin-left:15px;float:left;">--%>
                            <%--<div class="input-group date form_datetime" style="width:160px;float:left;">--%>
                                <%--<input type="text" class="form-control" style="width:160px;" name="lastModifyTimestamp"--%>
                                       <%--id="lastModifyTimestampID_start">--%>
                                <%--<span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>--%>
                            <%--</div>--%>
                            <%--<div style="float:left; width:10px; margin-left:auto; margin-right:auto;">--%>
                                <%--&nbsp;-&nbsp;</div>--%>
                            <%--<div class="input-group date form_datetime" style="width:160px;float:left;">--%>
                                <%--<input type="text" class="form-control" style="width:160px;"--%>
                                       <%--name="lastModifyTimestampEnd" id="lastModifyTimestampID_end">--%>
                                <%--<span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>--%>
                            <%--</div>--%>
                        <%--</div>--%>
                    </div>
                </td>
                <td style="vertical-align: bottom;">
                    <button id="search" type="button" style="position:relative; margin-left:35px; top: -15px"
                            class="btn btn-primary"><span class="glyphicon glyphicon-search"></span>&nbsp;查询
                    </button>
                </td>
            </tr>
        </table>
    </form>
    <!-- grid -->
    <div id=<%=gridId%>></div>
</div>
</body>
</html>
