<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <%@ include file="/pages/common/header.jsp"%><!--引入权限系统该页面需无须引用header.jsp -->

	<script type='text/javascript' src="../lib/jquery-1.8.3.min.js"></script>
    <script type='text/javascript' src="../lib/angular/angular.js"></script>
<!--     <script type='text/javascript' src="//ajax.googleapis.com/ajax/libs/angularjs/1.4.8/angular.min.js"></script> -->

    <script type='text/javascript' src="//cdn.jsdelivr.net/momentjs/latest/moment-with-locales.min.js"></script>
    <script type='text/javascript' src="//cdn.jsdelivr.net/angular.moment/latest/angular-moment.min.js"></script>
    <script type='text/javascript' src="//cdnjs.cloudflare.com/ajax/libs/moment-range/2.0.3/moment-range.min.js"></script>

    <script type='text/javascript' src="//rawgit.com/JimLiu/angular-ui-tree/master/dist/angular-ui-tree.js"></script>
    <link rel="stylesheet" type="text/css" href="//rawgit.com/angular-ui-tree/angular-ui-tree/master/dist/angular-ui-tree.min.css">

    <script type='text/javascript' src="//rawgit.com/ganarajpr/angular-dragdrop/master/draganddrop.js"></script>

    <script type='text/javascript' src="//rawgit.com/marcj/css-element-queries/master/src/ElementQueries.js"></script>
    <script type='text/javascript' src="//rawgit.com/marcj/css-element-queries/master/src/ResizeSensor.js"></script>

    <script type='text/javascript' src="jsPlumb-2.0.5.js"></script>

<!--     <link rel="stylesheet" type="text/css" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.2/css/font-awesome.min.css"> -->

    <link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/bootstrap/latest/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="pages/domain/style.css">

    <script type='text/javascript' src="../lib/angular-gantt/assets/angular-gantt.js"></script>
    <script type='text/javascript' src="../lib/angular-gantt/assets/angular-gantt-plugins.js"></script>
    <link rel="stylesheet" type="text/css" href="lib/angular-gantt/assets/angular-gantt.css">
    <link rel="stylesheet" type="text/css" href="lib/angular-gantt/assets/angular-gantt-plugins.css">

    <script type='text/javascript' src="script.js"></script>

</head>
<body>
<body>
<div id="test" ng-app="plnkrGanttMaster" ng-controller="Ctrl">
{{ data }}
    <div gantt data="data" view-scale="hour" column-width="getColumnWidth(hour)" api=registerApi>
        <!-- <gantt-table columns="['model.name']"></gantt-table> -->
        <gantt-tree></gantt-tree>
        <gantt-groups></gantt-groups>
        <gantt-tooltips></gantt-tooltips>
        <gantt-bounds></gantt-bounds>
        <gantt-progress></gantt-progress>
        <gantt-sortable></gantt-sortable>
        <gantt-movable></gantt-movable>
        <gantt-draw-task></gantt-draw-task>
        <gantt-resize-sensor></gantt-resize-sensor>
        <gantt-overlap></gantt-overlap>
        <gantt-dependencies></gantt-dependencies>
    </div>
    <br/>
    <div >
		<button type="button" class="btn btn-primary btn-lg" ng-click="test()">TEST</button>
    </div>
</div>
</body>

</html>
