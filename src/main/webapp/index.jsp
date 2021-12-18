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
<!-- 编辑雇员modal框 -->
<div class="modal fade" id="update_emp_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">雇员编辑列表</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="add_emp_form">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input"
                                   placeholder="email@guigu.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" checked name="gender" id="gender1_update_input" value="0"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="1"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-3">
                            <!--部门提交id-->
                            <select class="form-control" name="dId" id="dept_select">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="update_emp">更新</button>
            </div>
        </div>
    </div>
</div>
<!-- 新增雇员modal框 -->
<div class="modal fade" id="add_emp_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">雇员新增列表</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="add_emp_form">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input"
                                   placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input"
                                   placeholder="email@guigu.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" checked name="gender" id="gender1_add_input" value="1"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="0"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-3">
                            <!--部门提交id-->
                            <select class="form-control" name="dId" id="dept_select">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="save_emp">保存</button>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <div class="row col-md-12">
        <div class="col-md-4"><h1>ssm-crud</h1></div>
        <div class="col-md-2 col-md-offset-10">
            <button type="button" class="btn btn-primary" id="add_emp_btn">新增</button>
            <button type="button" class="btn btn-danger" id="delete_emp_btn">删除</button>
        </div>
    </div>

    <div class="row col-md-12">
        <table class="table  table-striped" id="emps_table">
            <thead>
            <tr>
                <th><input type="checkbox" id="check_all"></th>
                <th>#</th>
                <th>lastName</th>
                <th>email</th>
                <th>gender</th>
                <th>deptName</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            </tbody>

        </table>
    </div>
    <div class="row col-md-12">
        <div class="col-md-4 col-md-offset-1" id="page_info_area"></div>
        <div class="col-md-6 col-md-offset-6" id="page_nav_area">

        </div>
    </div>
</div>
<script type="text/javascript">
    var page_total, current_pageNum, page_size;

    //页面加载完之后，发送ajax请求，得到分页数据
    $(function () {
        function reset_form(ele) {
            //打开模态框时清空表单内容，jquery对象是dom对象的数组
            $(ele)[0].reset();
            //removeClass 移除当前元素的类属性
            $(ele).find("*").removeClass("has-error has-success");
            //校验消息提示框内容也清空 find:查找子元素
            $(ele).find(".help-block").text("");
        }

        //初始化获取首页员工信息
        to_page(1);

        /*弹出新增模态框*/
        $("#add_emp_btn").click(function () {
            reset_form("#add_emp_modal form");
            //查询出部门列表,给新增模态框下
            getDepts("#add_emp_modal select");

            $('#add_emp_modal').modal({
                backdrop: 'static'
            });
        });

        //获取部门列表
        function getDepts(ele) {
            $.ajax({
                url: "${APP_PATH}/getDepts",
                type: "get",
                success: function (result) {
                    console.log(result);
                    //清空部门列表
                    $(ele).empty();
                    $.each(result.extend.depts, function (index, dept) {
                        // $("#dept_select")
                        $(ele)
                            .append(
                                $("<option></option>").attr("value", this.deptId).append(this.deptName)
                            );
                    });
                }
            });
        }


        function to_page(pageNum) {
            $.ajax({
                url: "${APP_PATH}/emps",
                data: "pn=" + pageNum,
                type: "get",
                success: function (result) {
                    console.log(result);
                    //1.解析显示员工
                    build_emps_table(result);
                    //2.解析显示分页信息
                    build_page_info(result);
                    //3.解析显示分页条
                    build_page_nav(result);
                }
            });
        }

        function clearEle(ele) {
            $(ele).empty();
        }

        function build_emps_table(result) {
            //先清空表单体
            clearEle("#emps_table tbody");
            var emps = result.extend.pageInfo.list;
            $.each(emps, function (index, item) {
                var checkBoxId = $("<td></td>").append($("<input type='checkbox'  class='check_item'/>"));
                var empIdTd = $("<td></td>").append(item.empId);
                var empNameTd = $("<td></td>").append(item.empName);
                var empEmailTd = $("<td></td>").append(item.email);
                var empGenderTd = $("<td></td>").append(item.gender == 0 ? '男' : '女');
                var DeptNameTd = $("<td></td>").append(item.dept.deptName);
                /*  <button type="button" class="btn btn-info">
                    <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>编辑
                    </button>
                    <button type="button" class="btn btn-danger">
                   <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                 删除</button>*/
                /*编辑按钮*/
                var editBtn = $("<button></button>").addClass("btn btn-info edit_btn")
                    .append($("<span></span>").addClass("glyphicon glyphicon-plus"))
                    .append("编辑");
                editBtn.attr("emp_id", item.empId);
                /*删除按钮*/
                var deleteBtn = $("<button></button>").addClass("btn btn-danger delete_btn")
                    .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
                    .append("删除");
                deleteBtn.attr("emp_id", item.empId);
                var btnTd = $("<td></td>").append(editBtn).append(" ").append(deleteBtn);
                $("<tr></tr>")
                    .append(checkBoxId)
                    .append(empIdTd)
                    .append(empNameTd)
                    .append(empEmailTd)
                    .append(empGenderTd)
                    .append(DeptNameTd)
                    .append(btnTd)
                    .appendTo("#emps_table tbody");/*appendto:追加到哪个元素，append:尾部追加元素*/
            })
        }

        //分页信息
        function build_page_info(result) {
            clearEle("#page_info_area");
            var pageInfo = result.extend.pageInfo;
            page_total = pageInfo.pages;
            current_pageNum = pageInfo.pageNum;
            page_size = pageInfo.size;
            $("#page_info_area").append("当前第" + pageInfo.pageNum + "页，共有" + pageInfo.pages + "页，总计" + pageInfo.total + "条记录")
        }

        //分页条
        function build_page_nav(result) {
            clearEle("#page_nav_area")
            // 构建ul元素 <ul class="pagination">
            var ul = $("<ul></ul>").addClass("pagination");

            //首页和上一页
            var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
            var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));

            //判断如果当前页没有上一页就不可点击 hasPreviousPage
            if (!result.extend.pageInfo.hasPreviousPage) {
                firstPageLi.addClass("disabled");
                prePageLi.addClass("disabled");
            } else {
                //为首页和上一页绑定点击事件
                firstPageLi.click(function () {
                    to_page(1);
                });
                prePageLi.click(function () {
                    to_page(result.extend.pageInfo.pageNum - 1);
                });
            }

            /*ul追加首页和上一页*/
            ul.append(firstPageLi);
            ul.append(prePageLi);

            //导航栏遍历   <li><a href="#">1</a></li>
            $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {
                var numLi = $("<li></li>").append($("<a></a>").append(item));
                //当前页要激活
                if (item == result.extend.pageInfo.pageNum) {
                    numLi.addClass("active");
                }
                //添加点击事件
                numLi.click(function () {
                    to_page(item);
                })
                ul.append(numLi);
            });

            //下一页和尾页的li
            var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
            var endPageLi = $("<li></li>").append($("<a></a>").append("尾页").attr("href", "#"));

            //判断如果当前页没有下一页就不可点击 hasNextPage
            if (!result.extend.pageInfo.hasNextPage) {
                nextPageLi.addClass("disabled");
                endPageLi.addClass("disabled");
            } else {
                //为尾页和下一页绑定点击事件
                nextPageLi.click(function () {
                    to_page(result.extend.pageInfo.pageNum + 1);
                });
                //小技巧，总页数不会超过总数
                endPageLi.click(function () {
                    to_page(result.extend.pageInfo.total);
                });
            }

            //ul后面追加下一页和尾页
            ul.append(nextPageLi);
            ul.append(endPageLi);

            //ul追加到<nav aria-label="Page navigation">
            var navEle = $("<nav></vav>").attr("aria-label", "Page navigation").append(ul);
            navEle.appendTo($("#page_nav_area"));
            // $("#page_nav_area").append(navEle);
        }

        //校验用户名是否可用,change事件发送ajax请求，并把结果以属性绑定到保存按钮上
        $("#empName_add_input").change(function () {
            var empName = this.value;
            $.ajax({
                url: "${APP_PATH}/checkName",
                data: "empName=" + empName,
                type: "POST",
                success: function (result) {
                    console.log(result);
                    if (result.code == 100) {
                        show_validate_msg('#empName_add_input', 'success', '用户名可用');
                        //给保存按钮添加属性
                        $("#save_emp").attr("ajax-va", "success");
                    } else {
                        show_validate_msg('#empName_add_input', 'error', result.extend.va_msg);
                        $("#save_emp").attr("ajax-va", "error");
                    }
                }
            });
        });


        //处理add输入框逻辑
        function validate_add_form() {
            //1. 校验用户名
            var empname = $("#empName_add_input").val();

            //如果通过ajax已经判断出错误了就不继续判断
            if ($("#empName_add_input").next("span").text() == '') {
                //正则表达式不要有空格
                var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5}$)/;
                if (!regName.test(empname)) {
                    // alert("用户名可以是2到5个汉字或者6-16的字母与数字以及_和-组成");
                    show_validate_msg('#empName_add_input', 'error', '用户名可以是2到5个汉字或者6-16的字母与数字以及_和-组成')
                    return false;
                } else {
                    show_validate_msg('#empName_add_input', 'success', '')
                }
            }

            //2.校验邮箱
            var emailVal = $("#email_add_input").val();
            //正则表达式不要有空格
            var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
            if (!regEmail.test(emailVal)) {
                // alert("邮箱格式不对，请先修改");  parent得到父元素
                show_validate_msg('#email_add_input', 'error', '邮箱格式不对，请先修改')
                return false;
            } else {
                show_validate_msg('#email_add_input', 'success', '')
            }
            return true;
        }

        //抽取校验显示信提示信息
        function show_validate_msg(ele, status, msg) {
            $(ele).parent().removeClass("has-success has-error");
            // $(ele).next("span").text();
            if (status == 'success') {
                $(ele).parent().addClass("has-success");
                $(ele).next("span").text("");
            } else {
                $(ele).parent().addClass("has-error");
                $(ele).next("span").text(msg);
            }
        }


        //新增雇员的保存按钮点击事件
        $("#save_emp").click(function () {
            //1.进行校验数据
            if (!validate_add_form()) {
                return false;
            }

            //2.获取当前按钮上的ajax-va属性值(通过了用户名可使用校验)
            if ($(this).attr("ajax-va") == 'error') {
                return false;
            }

            //3.发送请求保存员工
            $.ajax({
                url: "${APP_PATH}/saveEmp",
                data: $("#add_emp_modal form").serialize(),
                type: "post",
                success: function (result) {
                    console.log(result);
                    //如果后端校验成功了，则关闭模态框和跳转页面
                    if (result.code == 100) {
                        $('#add_emp_modal').modal('hide');
                        to_page(page_total + 1);
                    } else {
                        //没有通过后台校验则去显示对应的错误
                        //有哪个字段的信息就显示，没有就是undefined
                        if (result.extend.errorFields.empName != undefined) {
                            show_validate_msg('#empName_add_input', 'error', result.extend.errorFields.empName)
                        }
                        if (result.extend.errorFields.email != undefined) {
                            show_validate_msg('#email_add_input', 'error', result.extend.errorFields.email)
                        }
                    }
                }
            });
            ;
        });
        $(document).on("click", ".edit_btn", function () {
            // alert("edit");

            //1.查出部门信息，显示部门列表
            getDepts("#update_emp_modal select");

            //0.查出员工信息 方式1
            var id = $(this).parents("tr").children("td").eq(0).text();
            //在构造表单中的编辑按钮时就添加emp_id的属性
            id = $(this).attr("emp_id");

            //打开模态框之前，给更新按钮绑定当前id值
            $("#update_emp").attr("edit-id", id);
            //方式二：通过获取当前元素上的edit_id值
            // alert("id=" + id);
            getEmp(id);
            //2.弹出模态框
            $('#update_emp_modal').modal({
                backdrop: 'static'
            });
        });

        //查询员工信息
        function getEmp(id) {
            $.ajax({
                url: "${APP_PATH}/emp/" + id,
                type: "GET",
                success: function (result) {
                    console.log(result);
                    var emp = result.extend.emp;
                    $("#empName_update_static").text(emp.empName);
                    $("#email_update_input").val(emp.email);
                    $("#update_emp_modal input[name=gender]").val([emp.gender]);
                    $("#update_emp_modal select").val([emp.dId]);
                }
            });
        }

        //更新雇员
        $("#update_emp").click(function () {
            //1.验证邮箱
            var emailVal = $("#email_update_input").val();
            //正则表达式不要有空格
            var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
            if (!regEmail.test(emailVal)) {
                // alert("邮箱格式不对，请先修改");  parent得到父元素
                show_validate_msg('#email_update_input', 'error', '邮箱格式不对，请先修改')
                return false;
            } else {
                show_validate_msg('#email_update_input', 'success', '')
            }
            //2.发送ajax请求保存更新的员工数据,restful风格使用put请求，隐藏参数_method=PUT,
            $.ajax({
                url: "${APP_PATH}/emp/" + $(this).attr("edit-id"),
                // type: "POST",
                type: "PUT",  /*直接使用put请求，但是tomcat会拦截请求体数据，需要开启有个过滤器*/
                // data: $("#update_emp_modal form").serialize()+"&_method=PUT",  /*数据里拼接_method=put请求*/
                data: $("#update_emp_modal form").serialize(),
                success: function (result) {
                    console.log(result);//取消息
                    alert(result.msg);
                    //3.关闭模态框,刷新当前页
                    $('#update_emp_modal').modal('hide');
                    to_page(current_pageNum);
                }
            });

        });
        //给删除绑定点击事件 on（事件，选择器，函数）
        $(document).on("click", ".delete_btn", function () {
            var empName = $(this).parents("tr").children("td").eq(2).text();
            var id = $(this).parents("tr").find("td:eq(1)").text();

            //1.弹出框提示一下是够删除那个员工
            if (confirm("你确定删除[" + empName + "]吗？")) {
                //2.调用删除url
                $.ajax({
                    url: "${APP_PATH}/emp/" + id,
                    // type: "DELETE",
                    type: "POST",
                    data: "_method=DELETE",  //key/value拼接字符换；json串
                    success: function (result) {
                        alert(result.msg);
                        to_page(current_pageNum);
                    }
                })
                ;
            }
        });

        //完成全选操作
        $("#check_all").click(function () {
            //1.获取全选按钮的状态
            var allStatus = $(this).prop("checked");
            // check_item  子选择元素
            $(".check_item").prop("checked", allStatus);
        });

        //给每个单选按钮点击事件 .check_item
        $(document).on("click", ".check_item", function () {
            //判断选中子元素的个数 == 总子元素的个数
            var flag = $(".check_item:checked").length == $(".check_item").length;
            $("#check_all").prop("checked", flag);
        });

        //给批量删除点击事件
        $("#delete_emp_btn").click(function () {
            var ids = "";
            var empNameList = "[";
            var $checkItem = $(".check_item:checked");
            if ($checkItem.length == 0) {
                alert("请选择要删除的员工！");
                return false;
            }
            //遍历选中的员工列表
            $checkItem.each(function () {
                //拼接每一个选中的元素的id值
                ids += $(this).parents("tr").find("td:eq(1)").text() + ",";
                //凭借姓名
                empNameList += $(this).parents("tr").find("td:eq(2)").text() + ",";
            });
            ids = ids.substring(0, ids.length - 1);
            empNameList = empNameList.substring(0, empNameList.length - 1) + "]";

            //确实是否删除
            if (confirm("确认删除" + empNameList + "吗？")) {
                //发送批量删除的请求
                $.ajax({
                    url: "${APP_PATH}/emp/" + ids,
                    type: "DELETE",
                    success: function (result) {
                        alert(result.msg);
                        to_page(current_pageNum);
                        //取消全选框
                        $("#check_all").prop("checked", false);
                    }
                });
            }

        });

    });
    //给编辑按钮添加点击事件，当元素后加上的该事件失效不触发，需要使用on方法为后添加的元素添加行为
    // $(".edit_btn").click(function () {
    //
    // });

</script>
</body>
</html>
