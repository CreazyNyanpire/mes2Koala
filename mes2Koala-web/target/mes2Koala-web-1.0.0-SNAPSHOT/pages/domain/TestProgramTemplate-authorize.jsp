<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
    .selectDepartment .modal-dialog {
        width: 750px;
    }
    .selectDepartment .modal-body {
        min-height: 310px;
    }
    .selectDepartment .tree {
        margin-left: auto;
        margin-right: auto;
        width: 96%;
        min-height: 285px;
        max-height: 300px;
    }
</style>
<div class="modal fade selectDepartment">

    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">选择授权人</h4>
            </div>
            <div class="modal-body" style="width: 300px;margin-left: 20px; margin-right: auto;">

                  <div class="tree" style="margin: 2px!important;" id="memberTree"></div>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-success" id="confirm">确定</button>
            </div>
        </div>
    </div>
</div>