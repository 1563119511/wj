<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <meta charset="UTF-8">
    <title>${Title}</title>
    <link rel="stylesheet" href="/css/bootstrap.min.css">
    <style>
        body {
            padding: 00px 50px;
        }

        .student-container {
            display: flex;
            height: 450px;
            width: 100%;
        }

        .left {
            width: 30%;
            height: 100%;
        }

        .right {
            width: 70%;
            height: 100%;

        }

        .table-input {
            width: 100px;
        }
    </style>
    <script src="/js/jquery-3.3.1.min.js"></script>
    <script src="/js/bootstrap.min.js"></script>
    <script src="/js/popper.min.js"></script>
    <script src="/js/ajax.js"></script>
</head>


<body>

<div class="page-header">
    <h1>教师课题管理
        <small>教师信息管理</small>
    </h1>
</div>


<div class="row">
    <div class="col-lg-8 col-lg-offset-2 ">
        <div class="student-container">
            <div class="left">
                <div style="width:100%;text-align: center;">
                    <img src="/images/443625372.jpeg" class="img-thumbnail" style="width:50%;margin-top: 30px;">
                </div>
                <div style="text-align:center;">
                    <br/>
                    <span>工号：${user.userId}</span>
                    <br/>
                    <span>姓名：${user.userName}</span>
                    <br/>
                    <span><a href="/Logout">退出登录</a></span>
                </div>

            </div>
            <div class="right">
                <div>
                    <!-- Nav tabs -->
                    <ul class="nav nav-tabs" role="tablist" id="myTabs">
                        <li role="presentation" class="active" onclick="foo(this)">
                            <a href="#home" aria-controls="home" role="tab" data-toggle="tab">课题管理</a>
                        </li>
                        <li role="presentation" onclick="foo(this)">
                            <a href="#profile" aria-controls="profile" role="tab" data-toggle="tab">查看学生成果</a>
                        </li>
                        <li role="presentation" onclick="foo(this)"><a href="#course" aria-controls="course"
                                                                       role="tab" data-toggle="tab">查看学生选题</a></li>
                        <li role="presentation" onclick="foo(this)"><a href="#messages" aria-controls="messages"
                                                                       role="tab" data-toggle="tab">学生成绩录入</a></li>
                        <li role="presentation" onclick="foo(this)"><a href="#settings" aria-controls="settings"
                                                                       role="tab" data-toggle="tab">签到查看</a></li>
                    </ul>
                    <div class="tab-content">
                        <%--课题录入及查看页--%>
                        <div role="tabpanel" class="tab-pane fade in active" id="home">
                            <br/>
                            <div class="panel panel-default">
                                <!-- Default panel contents -->
                                <form class="form-horizontal" id="subject-form" onsubmit="checkFrom()"
                                      action="/Subject/pub_subject" method="post">
                                    <div style="margin: 5px; border-bottom: 1px solid #ddd; ">
                                        <div class="form-group">
                                            <label for="input-subject-name" class="col-sm-2 control-label">课题名称</label>
                                            <div class="col-sm-8">
                                                <input type="text" class="form-control" name="subject_name"
                                                       id="input-subject-name" placeholder="请输入课题名称">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="input-subject-kind" class="col-sm-2 control-label">课题类型</label>
                                            <div class="col-sm-8">
                                                <input type="text" class="form-control" name="subject_kind"
                                                       id="input-subject-kind" placeholder="请输入课题类型">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="input-max-select-num"
                                                   class="col-sm-2 control-label">最大选课人数</label>
                                            <div class="col-sm-8">
                                                <input type="number" min="1" max="10" name="max_select_num"
                                                       class="form-control" id="input-max-select-num" placeholder="1"/>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-sm-offset-2 col-sm-10">
                                                <input type="submit" class="btn btn-primary"/>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                                <!-- Table -->
                                <table class="table table-bordered table-striped table-hover" id="subject-list">
                                    <tr>
                                        <thead>
                                        <td>课题名称</td>
                                        <td>课题类型</td>
                                        <td>最大选课人数</td>
                                        <td>当前已选人数</td>
                                        </thead>
                                    </tr>
                                </table>

                            </div>
                        </div>
                        <div role="tabpanel" class="tab-pane" id="profile"><br/>
                            <div class="panel panel-default">
                                <!-- Default panel contents -->
                                <div class="panel-heading">成果查看区域</div>
                                <div class="panel-body">
                                    <p>在此可以查看学生上传的文件信息</p>
                                </div>

                                <!-- Table -->
                                <table class="table table-bordered table-striped table-hover">
                                    <tr>
                                        <thead>
                                        <td>课题名称</td>
                                        <td>学号</td>
                                        <td>姓名</td>
                                        <td>操作</td>
                                        </thead>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        <div role="tabpanel" class="tab-pane" id="course"><br/>
                            <div class="panel panel-default">
                                <!-- Default panel contents -->
                                <div class="panel-heading">选题信息</div>
                                <div class="panel-body">
                                    <p>查看所有的学生选题信息，并审核选题是否满足</p>
                                </div>

                                <!-- Table -->
                                <table id="student-select-teacher-subject-list"
                                       class="table table-hover table-bordered table-striped">
                                    <tr>
                                        <thead>
                                        <td>课题名称</td>
                                        <td>选题者</td>
                                        <td>状态</td>
                                        <td>操作</td>
                                        </thead>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        <div role="tabpanel" class="tab-pane" id="messages"><br/>
                            <div class="panel panel-default">
                                <!-- Default panel contents -->
                                <div class="panel-heading">成绩录入区域</div>
                                <div class="panel-body">
                                    <p>在此处录入学生成绩，录入后不可修改</p>
                                </div>

                                <!-- Table -->
                                <form:form action="/Grade/pubGrade" method="post" modelAttribute="gradeList">
                                    <table class="table table-striped table-bordered table-hover"
                                           id="studentGradeTable">
                                        <thead>
                                        <td>课题名称</td>
                                        <td>学生</td>
                                        <td>平时成绩（不可修改，系统自动计算）</td>
                                        <td>自评成绩</td>
                                        <td>测试成绩</td>
                                        <td>最终成绩（不可修改，系统自动计算）</td>
                                        </thead>
                                    </table>
                                    <input type="submit" class="btn btn-primary"/>
                                </form:form>
                            </div>
                        </div>
                        <div role="tabpanel" class="tab-pane" id="settings">
                            <br/>
                            <div class="panel panel-default">
                                <!-- Default panel contents -->
                                <div class="panel-heading">签到查看</div>
                                <div class="panel-body">
                                    <p>查看所有的签到。</p>
                                </div>

                                <!-- Table -->
                                <table class="table">
                                    <tr>
                                        <td>#</td>
                                        <td>签到时间</td>
                                        <td>签到时间</td>
                                        <td>签退时间</td>

                                    </tr>
                                    <tr>
                                        <td>1</td>
                                        <td>Impassive</td>
                                        <td>2019-04-13:18:00:00</td>
                                        <td>2019-04-13:18:00:00</td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    var tabList = $("#myTabs");

    $('#myTabs a').click(function (e) {
        e.preventDefault();
        $(this).tab('show')
        if (e.currentTarget.innerText == '查看学生选题') {
            ajax("/Subject/SelectStudentsForTeacher?userId=" +${user.userId}, QueryStudentsForTeacher, "GET");
        }
        if (e.currentTarget.innerText == '学生成绩录入') {
            ajax("/Grade/teacherQueryGrade", TeacherQueryGradeCallback, "GET");
        }

    });

    function foo(e) {

        var liList = tabList.find("li");

        for (var i = 0; i < liList.length; i++) {
            liList[i].removeAttribute('class');
        }

        e.className = "active";

    }

    function checkFrom() {
        if ($("#input-subject-name").val() != ""
            && $("#input-subject-kind").val() != ""
            && $("#input-subject-name").val() != "")
            return true;
        else {
            alert("表单中不能提交空数据");
            return false;
        }
    }

    ajax("/Subject/search_teacher_id?teacher_id=" +${user.userId}, QueryTeacherIdSubjectCallback, "GET")
</script>

</html>