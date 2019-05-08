<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <meta charset="UTF-8">
    <title>${Title}</title>
    <link rel="stylesheet" href="/css/bootstrap.min.css">
    <style>
        body {
            padding: 0px 50px;
        }

        .no-click {
            /*cursor: not-allowed;*/
            pointer-events: none;
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

        #upload {
            display: none;

        }

        .uploadFile {
            display: inline-block;
            width: 110px;
            height: 60px;
            border: 1px dashed #e5e5ee;
            text-align: center;
            line-height: 60px;
            font-size: 18px;
            font-family: '楷体';
            color: gray;
            border-radius: 10px;
            margin: 0px;
        }

        .uploadFile:hover {
            cursor: pointer;
            border: 1px dashed rgb(51, 133, 255);
            color: rgb(51, 133, 255);
            transition: .5s border;
        }
    </style>
    <script src="/js/jquery-3.3.1.min.js"></script>
    <script src="/js/bootstrap.min.js"></script>
    <script src="/js/popper.min.js"></script>
    <script src="/js/ajax.js"></script>
</head>
<body>

<div class="page-header">
    <h1>学生课题选择
        <small>学生信息管理</small>
    </h1>
</div>

<div class="row">
    <div class="col-lg-8 col-lg-offset-2 ">
        <div class="student-container">
            <div class="left">
                <div style="width:100%;text-align: center;">
                    <img src="/images/443625372.jpeg" class="img-thumbnail" style="width:50%;margin-top: 30px;"
                         alt="error">
                </div>
                <div style="text-align:center;">
                    <br/>
                    <span>
                            <button id="btn-check-in"
                                    class="btn btn-primary"
                                    onclick="ajax('/User/Checkin', CheckInCallback, 'GET')">签到</button>
                        </span>
                    <br/>
                    <span>姓名：${user.userName}</span>
                    <br/>
                    <span>学号：${user.userId}</span>
                    <br/>
                    <span>性别：${user.roleInfo.sex}</span>
                    <br/>
                    <span>班级：${user.roleInfo.tclass}</span>
                    <br/>
                    <span><a href="/Logout">退出登录</a></span>
                </div>
            </div>
            <div class="right">
                <div>
                    <!-- Nav tabs -->
                    <ul class="nav nav-tabs" role="tablist" id="myTabs">
                        <li role="presentation" class="active" onclick="foo(this)"><a href="#home"
                                                                                      aria-controls="home" role="tab"
                                                                                      data-toggle="tab">课题选择</a></li>
                        <li role="presentation" onclick="foo(this)"><a href="#result"
                                                                       onclick="ajax('/Subject/selectStudentSubject?userId='+${user.userId}, QueryStudentSubjectCallback ,'GET')"
                                                                       aria-controls="profile" role="tab"
                                                                       data-toggle="tab">成果上传</a></li>
                        <li role="presentation" onclick="foo(this)"><a href="#score" aria-controls="messages"
                                                                       role="tab" data-toggle="tab">成绩管理</a></li>
                        <li role="presentation" onclick="foo(this)"><a href="#arrive" aria-controls="settings"
                                                                       role="tab" data-toggle="tab">签到查看</a></li>
                    </ul>

                    <!-- Tab panes -->
                    <div class="tab-content">
                        <%--选题页面--%>
                        <div role="tabpanel" class="tab-pane fade in active" id="home">
                            <br/>
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <div id="ctrl-panel" class="row">
                                        <input type="hidden" id="subject-id">
                                        <span id="subject-name" class="col-xs-4">课程名称</span>
                                        <span id="subject-teacher" class="col-xs-4">指导教师</span>
                                        <span class="col-xs-4">
                                                <button onclick="selectSubject()" class="btn btn-default">选择</button>
                                            </span>
                                    </div>
                                </div>
                                <div class="panel-body">
                                    <div class="row">
                                        <div class="col-xs-2">
                                            <ul id="teacher-list"
                                                class="list-group">
                                            </ul>
                                        </div>
                                        <div class="col-xs-10">
                                            <table id="subject-list"
                                                   class="table table-bordered table-striped table-hover">
                                                <tr>
                                                    <thead>
                                                    <td>题目名称</td>
                                                    <td>类型</td>
                                                    <td>指导教师</td>
                                                    <td>可选人数</td>
                                                    <td>已选人数</td>
                                                    </thead>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%-- 成果上传 --%>
                        <div role="tabpanel" class="tab-pane" id="result"><br/>
                            <div class="panel panel-default">
                                <!-- Default panel contents -->
                                <div class="panel-heading">成果上传区域</div>
                                <div class="panel-body">
                                    <p>请上传课题研究成果，多次上传以最后一次为准</p>
                                    <p>
                                    <form action="/Subject/Upload" enctype="multipart/form-data" method="post">

                                        <label class="uploadFile" for="upload">
                                            成果上传
                                        </label><br />
                                        <label>自评成绩：</label>
                                        <input type="number" min="0" max="100" name="grade_selfjudge"/>
                                        <input type="file" name="file" id='upload'/>
                                        <input class="btn btn-primary" type="submit"/>
                                    </form>
                                    </p>
                                </div>

                                <!-- Table -->
                                <table class="table" id="subject-student-selected">
                                    <tr>
                                        <td>课题名称</td>
                                        <td>课题类型</td>
                                        <td>指导教师</td>
                                        <td>结果提交</td>
                                        <td>操作</td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        <%-- 成绩查看 --%>
                        <div role="tabpanel" class="tab-pane" id="score"><br/>
                            <div class="panel panel-default">
                                <!-- Default panel contents -->
                                <div class="panel-heading">成绩查看区域</div>
                                <div class="panel-body">
                                    <p>此处显示的成绩为最终成绩(平时成绩和最终成绩)</p>
                                </div>

                                <!-- Table -->
                                <table id="student-grade-table" class="table table-hover table-bordered" >
                                    <thead>
                                        <td>课题名称</td>
                                        <td>指导教师</td>
                                        <td>平时成绩</td>
                                        <td>自评成绩</td>
                                        <td>测试成绩</td>
                                        <td>最终成绩</td>
                                    </thead>
                                    <tr><tr/>
                                </table>
                            </div>
                        </div>
                        <div role="tabpanel" class="tab-pane" id="arrive">
                            <br/>
                            <div class="panel panel-default">
                                <!-- Default panel contents -->
                                <div class="panel-heading">签到查看</div>
                                <div class="panel-body">
                                    <p>查看所有的签到。现已签到<span>12</span>次</p>
                                </div>
                                <!-- Table -->
                                <table class="table">
                                    <thead>
                                        <td>#</td>
                                        <td>签到时间</td>
                                        <td>签退时间</td>
                                    </thead>
                                    <tr>
                                        <td>1</td>
                                        <td>0:0:0</td>
                                        <td>12:0:0</td>
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
        $(this).tab('show');
        if (e.currentTarget.innerText == '成绩管理') {
            ajax("/Grade/StudentGrade?userid=" +${user.userId}, StudentGradeCallback, "GET");
        }
    });

    function foo(e) {
        var liList = tabList.find("li");
        for (var i = 0; i < liList.length; i++) {
            liList[i].removeAttribute('class');
        }
        e.className = "active";
    }

    ajax('/User/AllTeacher', QueryTeacherCallback, 'GET');
    ajax("/Admin/controlTime", StudentQueryControlTimeCallback, "GET")
    checkUserCheckin();
</script>

</html>