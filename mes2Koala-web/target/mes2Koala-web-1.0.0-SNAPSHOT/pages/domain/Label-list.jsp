<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/pages/common/header.jsp"%><!--引入权限系统该页面需无须引用header.jsp -->
<%@ page import="java.util.Date"%>
<% String formId = "form_" + new Date().getTime();
   String gridId = "grid_" + new Date().getTime();
   String path = request.getContextPath()+request.getServletPath().substring(0,request.getServletPath().lastIndexOf("/")+1);
%>
<script type="text/javascript">
var grid;
var form;
var _dialog;
$(function (){
    grid = $("#<%=gridId%>");
    form = $("#<%=formId%>");
	var selectItems = {};

	var testTypeContents = [ {
		title : '请选择',
		value : ''
	} ];
	$.ajax(
			{
				url : '${pageContext.request.contextPath}/SystemDictionary/getByType/TestType.koala',
				type : 'GET',
				dataType : 'json'
			}).done(function(msg) {
		for (var i = 0; i < msg.length; i++) {
			testTypeContents.push({
				title : msg[i]['label'],
				value : msg[i]['value']
			});
		}
		selectItems['testTypeID'] = testTypeContents;
		form.find('#testTypeID').select({
			title: '请选择',
			contents: selectItems['testTypeID']
		}).on('change',function(){
			form.find('#testTypeID_').val($(this).getValue());
			if(form.find('#testTypeID_').val()=='CP'){
				form.find('#packageTypeID').setValue('');
				form.find('#packageTypeID').find('button').attr('disabled',true);
			}else{
				form.find('#packageTypeID').find('button').attr('disabled',false);
			}
		});
	});

	var labelTypeContents = [ {
		title : '请选择',
		value : ''
	} ];
	$.ajax(
			{
				url : '${pageContext.request.contextPath}/SystemDictionary/getByType/LabelType.koala',
				type : 'GET',
				dataType : 'json',
			}).done(function(msg) {
		for (var i = 0; i < msg.length; i++) {
			labelTypeContents.push({
				title : msg[i]['label'],
				value : msg[i]['value']
			});
		}
		selectItems['labelTypeID'] = labelTypeContents;
	});


	var taxTypeContents = [ {
		title : '请选择',
		value : ''
	} ];
	$.ajax(
			{
				url : '${pageContext.request.contextPath}/SystemDictionary/getByType/TaxType.koala',
				type : 'GET',
				dataType : 'json'
			}).done(function(msg) {
		for (var i = 0; i < msg.length; i++) {
			taxTypeContents.push({
				title : msg[i]['label'],
				value : msg[i]['value']
			});
		}
		selectItems['taxTypeID'] = taxTypeContents;
	});


	var packageTypeContents = [ {
		title : '请选择',
		value : ''
	} ];
	$.ajax(
			{
				url : '${pageContext.request.contextPath}/SystemDictionary/getByType/PackageType.koala',
				type : 'GET',
				dataType : 'json',
			}).done(function(msg) {
		for (var i = 0; i < msg.length; i++) {
			packageTypeContents.push({
				title : msg[i]['label'],
				value : msg[i]['value']
			});
		}
		selectItems['packageTypeID'] = packageTypeContents;
		form.find('#packageTypeID').select({
			title: '请选择',
			contents: selectItems['packageTypeID']
		}).on('change',function(){
			form.find('#packageTypeID_').val($(this).getValue());
		});
	});

	PageLoader = {
	   //
	    initSearchPanel:function(){
      	                	            	                	            	                	            	                	            	        	     },
	    initGridPanel: function(){
	         var self = this;
	         var width = 180;
	         return grid.grid({
	                identity:"id",
	                buttons: [
	                        {content: '<button class="btn btn-primary" type="button"><span class="glyphicon glyphicon-plus"><span>添加</button>', action: 'add'},
	                        {content: '<button class="btn btn-success" type="button"><span class="glyphicon glyphicon-edit"><span>修改</button>', action: 'modify'},
	                        {content: '<button class="btn btn-danger" type="button"><span class="glyphicon glyphicon-remove"><span>删除</button>', action: 'delete'},
                            {content: '<button class="btn btn-primary" type="button"><span class="glyphicon glyphicon-plus"><span>导出到Excel</button>',action: 'exportExcel'}
	                    ],
	                url:"${pageContext.request.contextPath}/Label/pageJson.koala",
	                columns: [
	                     	                         	                         { title: '标签名称', name: 'labelName', width: 220},
	                         	                         	                         	                         { title: '标签类型', name: 'labelType', width: width},
	                         	                         	                         	                         { title: '测试类型', name: 'testType', width: width},
	                         	                         	                         	                         { title: '封装类型', name: 'packageType', width: width},
	                         	                         	                         	                         { title: '保税类型', name: 'taxType', width:width },
	                         	                         	                             { title: '操作', width: 120, render: function (rowdata, name, index)
	                                 {
	                                     var param = '"' + rowdata.id + '"';
	                                     var h = "<a href='javascript:openLabelDetailsPage(" + param + ")'>查看</a> ";
	                                     return h;
	                                 }
	                             }
	                ]
	         }).on({
	                   'add': function(){
	                       self.add($(this));
	                   },
	                   'modify': function(event, data){
	                        var indexs = data.data;
	                        var $this = $(this);
	                        if(indexs.length == 0){
	                            $this.message({
	                                type: 'warning',
	                                content: '请选择一条记录进行修改'
	                            })
	                            return;
	                        }
	                        if(indexs.length > 1){
	                            $this.message({
	                                type: 'warning',
	                                content: '只能选择一条记录进行修改'
	                            })
	                            return;
	                        }
	                       self.modify(indexs[0], $this);
	                    },
	                   'delete': function(event, data){
	                        var indexs = data.data;
	                        var $this = $(this);
	                        if(indexs.length == 0){
	                            $this.message({
	                                   type: 'warning',
	                                   content: '请选择要删除的记录'
	                            });
	                            return;
	                        }
	                        var remove = function(){
	                            self.remove(indexs, $this);
	                        };
	                        $this.confirm({
	                            content: '确定要删除所选记录吗?',
	                            callBack: remove
	                        });
	                   },
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
                           $this.confirm({
                               content: '确定要导出所选记录吗?',
                               callBack: function () {
                                   self.exportExcel(indexs, $this);
                               }
                           });
                       } 
	         });
	    },
	    add: function(grid){
	        var self = this;
	        var dialog = $('<div class="modal fade"><div class="modal-dialog">'
	        	+'<div class="modal-content"><div class="modal-header"><button type="button" class="close" '
	        	+'data-dismiss="modal" aria-hidden="true">&times;</button>'
	        	+'<h4 class="modal-title">新增标签</h4></div><div class="modal-body">'
	        	+'<p>One fine body&hellip;</p></div><div class="modal-footer">'
	        	+'<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>'
	        	+'<button type="button" class="btn btn-success" id="save">保存</button></div></div>'
	        	+'</div></div>');
	        $.get('<%=path%>/Label-add.jsp').done(function(html){
	            dialog.modal({
	                keyboard:false
	            }).on({
	                'hidden.bs.modal': function(){
	                    $(this).remove();
	                }
	            }).find('.modal-body').html(html);
	            self.initPage(dialog.find('form'));
	        });

	        dialog.find('#save').on('click',{grid: grid}, function(e){
	              if(!Validator.Validate(dialog.find('form')[0],3))return;
	              $.post('${pageContext.request.contextPath}/Label/add.koala', dialog.find('form').serialize()).done(function(result){
	                   if(result.success ){
	                        dialog.modal('hide');
	                        e.data.grid.data('koala.grid').refresh();
	                        e.data.grid.message({
	                            type: 'success',
	                            content: '保存成功'
	                         });
	                    }else{
	                        dialog.find('.modal-content').message({
	                            type: 'error',
	                            content: result.errorMessage
	                        });
	                     }
	              });
	        });
	    },
	    modify: function(id, grid){
	        var self = this;
	        var dialog = $('<div class="modal fade"><div class="modal-dialog"><div class="modal-content"><div class="modal-header"><button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button><h4 class="modal-title">修改标签</h4></div><div class="modal-body"><p>One fine body&hellip;</p></div><div class="modal-footer"><button type="button" class="btn btn-default" data-dismiss="modal">取消</button><button type="button" class="btn btn-success" id="save">保存</button></div></div></div></div>');
	        $.get('<%=path%>/Label-update.jsp').done(function(html){
	               dialog.find('.modal-body').html(html);
	               self.initPage(dialog.find('form'));
	               $.get( '${pageContext.request.contextPath}/Label/get/' + id + '.koala').done(function(json){
	                       json = json.data;
	                        var elm;
	                        for(var index in json){
	                            elm = dialog.find('#'+ index + 'ID');
	                            if(elm.hasClass('select')){
	                                elm.setValue(json[index]);
	                            }else{
	                                elm.val(json[index]);
	                            }
	                        }
	                        dialog.find('#labelNameDisplayID').val(json['labelName']);
	                });
	                dialog.modal({
	                    keyboard:false
	                }).on({
	                    'hidden.bs.modal': function(){
	                        $(this).remove();
	                    }
	                });
	                dialog.find('#save').on('click',{grid: grid}, function(e){
	                    if(!Validator.Validate(dialog.find('form')[0],3))return;
	                    $.post('${pageContext.request.contextPath}/Label/update.koala?id='+id, dialog.find('form').serialize()).done(function(result){
	                        if(result.success){
	                            dialog.modal('hide');
	                            e.data.grid.data('koala.grid').refresh();
	                            e.data.grid.message({
	                            type: 'success',
	                            content: '保存成功'
	                            });
	                        }else{
	                            dialog.find('.modal-content').message({
	                            type: 'error',
	                            content: result.actionError
	                            });
	                        }
	                    });
	                });
	        });
	    },
	    initPage: function(form){
	              form.find('.form_datetime').datetimepicker({
	                   language: 'zh-CN',
	                   format: "yyyy-mm-dd",
	                   autoclose: true,
	                   todayBtn: true,
	                   minView: 2,
	                   pickerPosition: 'bottom-left'
	               }).datetimepicker('setDate', new Date());//加载日期选择器
	               form.find('.select').each(function(){
	                    var select = $(this);
	                    var idAttr = select.attr('id');
	                    select.select({
	                        title: '请选择',
	                        contents: selectItems[idAttr]
	                    }).on('change', function(){
	                        form.find('#'+ idAttr + '_').val($(this).getValue());
							if(form.find('#testTypeID_').val()=='CP' && form.find('#packageTypeID_').val()!=''){
								form.find('#packageTypeID').setValue('');
								form.find('#packageTypeID').find('button').attr('disabled',true);
							}else{
								form.find('#packageTypeID').find('button').attr('disabled',false);
							}
	                    });
	               });
	   			form.find('#labelUpload').change(function (e) {
					e.preventDefault();
					var fd = new FormData();
					fd.append('label', $('#labelUpload')[0].files[0]);
					var fileNameArr = $('#labelUpload')[0].files[0].name.split('.');
					var fileName = fileNameArr[fileNameArr.length-1];
					if(fileName === 'btw'){
						$.ajax({
							type: 'post',
							url: '${pageContext.request.contextPath}/FileUpload/uploadLabel.koala',
							data: fd,
							processData: false,
							contentType: false,
							cache: false,
							success: function (msg) {
								form.find('#labelFullNameID').val(msg.data);
								console.log(msg.data);
								grid.message({
									type: 'success',
									content: '上传标签文件成功'
								});
							},
							error: function (data) {
								console.log('error');
								grid.message({
									type: 'error',
									content: '上传标签文件失败'
								})
							}
						});
					}else{
						$('#labelUpload').val('');//文件名错误则清空标签名称
						form.message({
							type: 'error',
							content: '文件格式不正确，请选择文件名后缀是".btw"的文件'
						})
					}

				})
	    },
	    remove: function(ids, grid){
	    	var data = [{ name: 'ids', value: ids.join(',') }];
	    	$.post('${pageContext.request.contextPath}/Label/delete.koala', data).done(function(result){
	                        if(result.success){
	                            grid.data('koala.grid').refresh();
	                            grid.message({
	                                type: 'success',
	                                content: '删除成功'
	                            });
	                        }else{
	                            grid.message({
	                                type: 'error',
	                                content: result.result
	                            });
	                        }
	    	});
	    },
	    exportExcel: function (ids, grid) {
            var data = [{name: 'ids', value: ids.join(',')}];
            $.post('${pageContext.request.contextPath}/Label/exportExcel.koala', data).done(function (result) {
                if (result.success) {
                    grid.data('koala.grid').refresh();
                    grid.message({
                        type: 'success',
                        content: '导出成功'
                    });
                    var dialog = $('<div class="modal fade"><div class="modal-dialog"><div class="modal-content"><div class="modal-header"><button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button><h4 class="modal-title">导出Excel</h4></div><div class="modal-body"><p id="downloadID"></p></div><div class="modal-footer"><button type="button" class="btn btn-success" data-dismiss="modal" id="save">确定</button></div></div></div></div>');
                    dialog.modal({
                        keyboard: false
                    }).on({
                        'hidden.bs.modal': function () {
                            $(this).remove();
                        }
                    }).find('#downloadID').html("导出成功！" + "<a style='margin-left:20px;'   href='"+ result.data +"'>点击下载</a>"); 
                } else {
                    grid.message({
                        type: 'error',
                        content: result.errorMessage
                    });
                }
            });
        }
	}
	PageLoader.initSearchPanel();
	PageLoader.initGridPanel();
	form.find('#search').on('click', function(){
            if(!Validator.Validate(document.getElementById("<%=formId%>"),3))return;
            var params = {};
            form.find('input').each(function(){
                var $this = $(this);
                var name = $this.attr('name');
                if(name){
                    params[name] = $this.val();
                }
            });
            grid.getGrid().search(params);
        });
});

var openLabelDetailsPage = function(id){
        var dialog = $('<div class="modal fade"><div class="modal-dialog"><div class="modal-content"><div class="modal-header"><button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button><h4 class="modal-title">查看</h4></div><div class="modal-body"><p>One fine body&hellip;</p></div><div class="modal-footer"><button type="button" class="btn btn-info" data-dismiss="modal">返回</button></div></div></div></div>');
        $.get('<%=path%>/Label-view.jsp').done(function(html){
               dialog.find('.modal-body').html(html);
               $.get( '${pageContext.request.contextPath}/Label/get/' + id + '.koala').done(function(json){
                       json = json.data;
                        var elm;
                        for(var index in json){
                        if(json[index]+"" == "false"){
                        		dialog.find('#'+ index + 'ID').html("<span style='color:#d2322d' class='glyphicon glyphicon-remove'></span>");
                        	}else if(json[index]+"" == "true"){
                        		dialog.find('#'+ index + 'ID').html("<span style='color:#47a447' class='glyphicon glyphicon-ok'></span>");
                        	}else{
                          		 dialog.find('#'+ index + 'ID').html(json[index]+"");
                        	}
                        }
                        if ( json['labelName'] != "")
					   		dialog.find('#labelNameID').html(json['labelName'] + "<a style='margin-left:20px;'   href='"+json['labelFullName']+"'>下载</a>");
               });
                dialog.modal({
                    keyboard:false
                }).on({
                    'hidden.bs.modal': function(){
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
          <div class="form-group">
          <label class="control-label" style="width:100px;float:left;">标签名称：&nbsp;</label>
            <div style="margin-left:15px;float:left;">
            <input name="labelName" class="form-control" type="text" style="width:180px;" id="labelNameID"  />
        </div>
          <label class="control-label" style="width:100px;float:left;margin-left:20px;">测试类型：&nbsp;</label>
			  <div style="margin-left:15px;float:left;">
				  <div class="btn-group select" id="testTypeID" ></div>
				  <input type="hidden" id="testTypeID_" name="testType" />
			  </div>
          <label class="control-label" style="width:100px;float:left;margin-left:20px;">封装类型：&nbsp;</label>
			  <div style="margin-left:15px;float:left;">
				  <div class="btn-group select" id="packageTypeID"></div>
				  <input type="hidden" id="packageTypeID_" name="packageType" />
			  </div>
        </div>
            </td>
       <td style="vertical-align: bottom;"><button id="search" type="button" style="position:relative; margin-left:35px; top: -15px" class="btn btn-primary"><span class="glyphicon glyphicon-search"></span>&nbsp;查询</button></td>
  </tr>
</table>	
</form>
<!-- grid -->
<div id=<%=gridId%>></div>
</div>
</body>
</html>
