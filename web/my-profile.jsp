<%@page import="store.user.UserError"%>
<%@page import="store.user.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile của tôi</title>
        <jsp:include page="meta.jsp" flush="true"/>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <style>

            #manager__header{
                padding: 0.5rem 1rem;
                background: white;
                border-radius: 0.5rem;

            }



            .navbar__container> a{
                color:black;
            }
            .dropdown-menu{
                right:0;
                left:auto;
            }
            #manager__header{
                padding: 0.5rem 1rem;
                text-align: right;
                border-radius: 0.5rem;
                background: transparent;
                font-size: 0.7rem;
            }
            #manager__header h4{
                font-size: 1.75rem;
            }
            .fa-clock-rotate-left::before {
                content: "\f1da";
            }
        </style>
    </head>
    <body>
        <%
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
            if ("AD".equalsIgnoreCase(loginUser.getRoleID())) {
        %>
        <div class="sidenav">
            <a href="ShowAccountController"><i class="fa fa-address-card fa-lg"></i>Quản lý tài khoản</a>
            <a href="ShowManagerController"><i class="fa fa-group fa-lg"></i>Quản lý manager</a>
            <a href="ShowCategoryController"><i class="fa fa-cart-plus fa-lg"></i>Quản lý loại sản phẩm</a>
        </div>
        <% } else     if (loginUser.getRoleID().equals("EM")) {    
        %>
        
        <div class="sidenav">
            <a href="ShowOrderController"><i class="fa fa-cart-plus fa-lg"></i>Quản lí đơn hàng</a>
            <a href="https://dashboard.tawk.to/login"><i class="fa fa-archive fa-lg"></i>Quản lí Q&A</a>
            <a href="customer-return-history.jsp"><i class="fa fa-clock-rotate-left fa-lg"></i>Lịch sử đổi/trả</a>
        </div> 
        
        <%  } else {%>
        <div class="sidenav">
            <a href="ManagerStatisticController"><i class="fa fa-bar-chart fa-lg"></i>Số liệu thống kê</a>
            <a href="ManagerShowProductController"><i class="fa fa-archive fa-lg"></i>Quản lí sản phẩm</a>
            <a href="ShowOrderController"><i class="fa fa-cart-plus fa-lg"></i>Quản lí đơn hàng</a>
            <a href="customer-return-history.jsp"><i class="fa fa-clock-rotate-left fa-lg"></i>Lịch sử đổi/trả</a>
        </div> 
        <%  }%>
        <div id="content" class="p-3 px-5 bg-grey">
            <!--WELCOME USER-->
            <div class="flex-item text-right" id="manager__header">
                <form class="m-0" action="MainController" method="POST">  
                    <h4 class="dropdown">
                        <b>Xin chào, </b>
                        <a  data-toggle="dropdown" role="button"><b class="text-color-dark"><%= loginUser.getFullName()%></b></a>
                        <div  class="dropdown-menu nav-tabs" role="tablist">
                            <a class="text-dark" href="my-profile.jsp"><button class="dropdown-item btn" role="tab" type="button">Thông tin tài khoản</button></a>
                            <input class=" dropdown-item btn" type="submit" name="action" value="Logout"/>
                        </div>
                    </h4>
                </form>
            </div>

            <div class="main">
                <h3>Profile của tôi</h3>
                <br>
                <table class="profile">
                    <tr>
                        <th>Tên tài khoản</th>
                        <td><%= loginUser.getUserID()%></td>
                    </tr>
                    <tr>
                        <th>Họ và tên</th>   
                        <td><%= loginUser.getFullName()%>
                            <div class="modal fade" id="myModal3" role="dialog" aria-labelledby="myModalLabel">
                                <div class="modal-dialog">
                                    <div class="modal-content" >
                                        <div class="modal-header">
                                            <h4 class="modal-title" id="myModalLabel">Thay đổi tên</h4>
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>

                                        </div>
                                        <div class="modal-body">
                                            <form action="MainController" method="POST">
                                                <div class="row">
                                                    <div class="col-md-12 mb-4">

                                                        <div class="form-outline">
                                                            <label class="form-label" for="newName">Tên mới</label>
                                                            <input type="text" name="newName" required="" id="newName" maxlength="100" value="<%= loginUser.getFullName()%>" class="form-control form-control-lg" />
                                                        </div>

                                                    </div>

                                                </div>

                                        </div>
                                        <div class="modal-footer">
                                            <button class="btn btn-default" type="submit" name="action" value="UpdateName">Cập nhật</button>
                                            <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
                                        </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                            <i class="fa fa-edit fa-2x" data-toggle="modal" data-target="#myModal3" style="margin-left: 12px;"></i>
                        </td>
                    </tr>
                    <tr>   
                        <th>Mật khẩu</th>
                        <td>************ 
                            <div class="modal fade" id="myModal1" role="dialog" aria-labelledby="myModalLabel">
                                <div class="modal-dialog">
                                    <div class="modal-content" >
                                        <div class="modal-header">
                                            <h4 class="modal-title" id="myModalLabel">Thay đổi mật khẩu</h4>
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>

                                        </div>
                                        <div class="modal-body">
                                            <form action="MainController" method="POST">
                                                <div class="row">
                                                    <div class="col-md-12 mb-4">

                                                        <div class="form-outline">
                                                            <label class="form-label" for="currentPassword">Mật khẩu hiện tại</label>
                                                            <input type="password" name="currentPassword" required="" id="currentPassword" maxlength="100" class="form-control form-control-lg" />
                                                            <p style="color: red">${requestScope.USER_ERROR.password}</p>
                                                        </div>

                                                    </div>

                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12 mb-4">

                                                        <div class="form-outline">
                                                            <label class="form-label" for="newPassword">Mật khẩu mới</label>
                                                            <input type="password" name="newPassword" required="" id="newPassword" class="form-control form-control-lg" />
                                                            <p style="color: red">${requestScope.USER_ERROR.confirm}</p>
                                                        </div>

                                                    </div>

                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12 mb-4">

                                                        <div class="form-outline">
                                                            <label class="form-label" for="confirmNewPassword">Nhập lại mật khẩu mới</label>
                                                            <input type="password" name="confirmNewPassword" required="" id="confirmNewPassword" class="form-control form-control-lg" />
                                                        </div>

                                                    </div>

                                                </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button class="btn btn-default" type="submit" name="action" value="UpdatePassword">Cập nhật</button>
                                            <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
                                        </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                            <i class="fa fa-edit fa-2x" data-toggle="modal" data-target="#myModal1" style="margin-left: 12px;"></i>
                        </td>
                    </tr>
                    <tr>   
                        <th>Giới tính</th>
                        <td><%= loginUser.getSex() == true ? "Nam" : "Nữ"%>
                            <div class="modal fade" id="myModal5" role="dialog" aria-labelledby="myModalLabel">
                                <div class="modal-dialog">
                                    <div class="modal-content" >
                                        <div class="modal-header">
                                            <h4 class="modal-title" id="myModalLabel">Thay đổi giới tính</h4>
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>

                                        </div>
                                        <form action="MainController" method="POST">
                                            <div class="modal-body">

                                                <div class="row">
                                                    <div class="col-md-12 mb-4">

                                                        <div>

                                                            <input  type="radio" <% if (loginUser.getSex()) { %>checked<%} %> id="Nam" name="newSex"  value="true"/>
                                                            <label class="form-label" for="Nam">Nam</label><br>
                                                            <input  type="radio" <% if (!loginUser.getSex()) { %>checked<%}%> id="Nữ" name="newSex"  value="false"/>
                                                            <label class="form-label" for="Nữ">Nữ</label>
                                                        </div>

                                                    </div>

                                                </div>

                                            </div>
                                            <div class="modal-footer">
                                                <button class="btn btn-default" type="submit" name="action" value="UpdateSex">Cập nhật</button>
                                                <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
                                            </div>
                                        </form>
                                    </div>

                                </div>
                            </div>
                            </form>
                            <i class="fa fa-edit fa-2x" data-toggle="modal" data-target="#myModal5" style="margin-left: 12px;"></i>
                        </td>
                    </tr>
                    <tr>   
                        <th>Ngày sinh</th>
                        <td><%= loginUser.getBirthday()%>
                            <div class="modal fade" id="myModal6" role="dialog" aria-labelledby="myModalLabel">
                                <div class="modal-dialog">
                                    <div class="modal-content" >
                                        <div class="modal-header">
                                            <h4 class="modal-title" id="myModalLabel">Thay đổi ngày sinh</h4>
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>

                                        </div>
                                        <form action="MainController" method="POST">
                                            <div class="modal-body">

                                                <div class="row">
                                                    <div class="col-md-12 mb-4">

                                                        <div class="form-outline">
                                                            <label class="form-label" for="newBirthday">Ngày sinh</label>
                                                            <input type="date" name="newBirthday" id="newBirthday" class="form-control form-control-lg" value="<%= loginUser.getBirthday()%>"/>
                                                        </div>

                                                    </div>

                                                </div>

                                            </div>
                                            <div class="modal-footer">
                                                <button class="btn btn-default" type="submit" name="action" value="UpdateBirthday">Cập nhật</button>
                                                <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
                                            </div>
                                        </form>
                                    </div>

                                </div>
                            </div>
                            </form>
                            <i class="fa fa-edit fa-2x" data-toggle="modal" data-target="#myModal6" style="margin-left: 12px;"></i>
                        </td>
                    </tr>
                    <tr>   
                        <th>Số điện thoại</th>
                        <td><% if (!loginUser.getPhone().isEmpty()) {%><%= loginUser.getPhone()%><% } else { %><i>Bạn chưa có thông tin này.</i><% }%>
                            <div class="modal fade" id="myModal4" role="dialog" aria-labelledby="myModalLabel">
                                <div class="modal-dialog">
                                    <div class="modal-content" >
                                        <div class="modal-header">
                                            <h4 class="modal-title" id="myModalLabel">Thay đổi số điện thoại</h4>
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>

                                        </div>
                                        <form action="MainController" method="POST">
                                            <div class="modal-body">

                                                <div class="row">
                                                    <div class="col-md-12 mb-4">

                                                        <div class="form-outline">
                                                            <label class="form-label" for="newPhone">Số điện thoại mới</label>
                                                            <input type="text" name="newPhone" id="newPhone" required="" maxlength="20" value="<%= loginUser.getPhone()%>" class="form-control form-control-lg" />
                                                        </div>

                                                    </div>

                                                </div>

                                            </div>
                                            <div class="modal-footer">
                                                <button class="btn btn-default" type="submit" name="action" value="UpdatePhone">Cập nhật</button>
                                                <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
                                            </div>
                                        </form>
                                    </div>

                                </div>
                            </div>
                            </form>
                            <i class="fa fa-edit fa-2x" data-toggle="modal" data-target="#myModal4" style="margin-left: 12px;"></i>
                        </td>
                    </tr>
                    <tr>
                        <th>Địa chỉ</th>
                        <td><% if (!loginUser.getAddress().isEmpty()) {%><%= loginUser.getAddress()%><% } else { %><i>Bạn chưa có thông tin này.</i><% }%>
                            <div class="modal fade" id="myModal2" role="dialog" aria-labelledby="myModalLabel">
                                <div class="modal-dialog">
                                    <div class="modal-content" >
                                        <div class="modal-header">
                                            <h4 class="modal-title" id="myModalLabel">Thay đổi địa chỉ</h4>
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>

                                        </div>
                                        <div class="modal-body">
                                            <form action="MainController" method="POST">
                                                <div class="row">
                                                    <div class="col-md-12 mb-4">

                                                        <div class="form-outline">
                                                            <label class="form-label" for="newAddress">Địa chỉ mới</label>
                                                            <input type="text" name="newAddress" required="" id="newAddress" value="<%= loginUser.getAddress()%>" class="form-control form-control-lg" />                                                    
                                                        </div>

                                                    </div>

                                                </div>

                                        </div>
                                        <div class="modal-footer">
                                            <button class="btn btn-default" type="submit" name="action" value="UpdateAddress">Cập nhật</button>
                                            <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
                                        </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                            <i class="fa fa-edit fa-2x" data-toggle="modal" data-target="#myModal2" style="margin-left: 12px;"></i>
                        </td>
                    </tr>
            </div>

            <% UserError userError = (UserError) request.getAttribute("USER_ERROR");
            if (userError != null) { %>
            <script>

                $(document).ready(function () {
                    $("#myModal1").modal();
                });

            </script>                                                
            <% }%>                             

    </body>
</html>
