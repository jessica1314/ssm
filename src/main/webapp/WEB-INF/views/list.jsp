<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <title>雇员列表</title>

    <%--配置jquery文件路径--%>
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.6.0.min.js"></script>
    <%--引入bootstrap的css文件--%>
    <link rel="stylesheet" href="${APP_PATH}/static/bootstrap-3.4.1-dist/css/bootstrap.css">
    <%--配置bootstrap的js路径，必须依赖于jquery文件--%>
    <script type="text/javascript" src="${APP_PATH}/static/bootstrap-3.4.1-dist/js/bootstrap.min.js"></script>
</head>
<body>
<div class="container">
    <div class="row col-md-12">
        <div class="col-md-4"><h1>ssm-crud</h1></div>
        <div class="col-md-2 col-md-offset-10">
            <button type="button" class="btn btn-primary">新增</button>
            <button type="button" class="btn btn-danger">删除</button>
        </div>
    </div>

    <div class="row col-md-12">
        <table class="table  table-striped">
            <tr>
                <th>#</th>
                <th>lastName</th>
                <th>email</th>
                <th>gender</th>
                <th>deptName</th>
                <th>操作</th>
            </tr>

            <%--遍历雇员列表信息--%>
            <c:forEach items="${pageInfo.list}" var="emp">
                <tr>
                    <td>${emp.empId}</td>
                    <td>${emp.empName}</td>
                    <td>${emp.email}</td>
                    <td>${emp.gender=='1'?'男':'女'}</td>
                    <td>${emp.dept.deptName}</td>
                    <td>
                        <button type="button" class="btn btn-info">编辑</button>
                        <button type="button" class="btn btn-danger">删除</button>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>
    <div class="row col-md-12">
        <div class="col-md-4 col-md-offset-1">当前第${pageInfo.pageNum}页，共有${pageInfo.pages}页，总计${pageInfo.total}条记录</div>
        <div class="col-md-6 col-md-offset-6">
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <li><a href="${APP_PATH}/getEmps">首页</a></li>
                    <c:if test="${pageInfo.hasPreviousPage}">
                        <li>
                            <a href="${APP_PATH}/getEmps?pn=${pageInfo.pageNum-1}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>

                    <c:forEach items="${pageInfo.navigatepageNums}" var="pageNum">
                        <c:if test="${pageNum==pageInfo.pageNum}">
                            <li class="active"><a href="#">${pageNum}</a></li>
                        </c:if>
                        <c:if test="${pageNum!=pageInfo.pageNum}">
                            <li><a href="${APP_PATH}/getEmps?pn=${pageNum}">${pageNum}</a></li>
                        </c:if>
                    </c:forEach>

                    <c:if test="${pageInfo.hasNextPage}">
                        <li>
                            <a href="${APP_PATH}/getEmps?pn=${pageInfo.pageNum+1}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <li><a href="${APP_PATH}/getEmps?pn=${pageInfo.total}">尾页</a></li>
                </ul>
            </nav>
        </div>
    </div>
</div>
</body>
</html>
